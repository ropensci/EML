/**
 *     '$RCSfile: EMLParser.java,v $'
 *     Copyright: 1997-2002 Regents of the University of California,
 *                          University of New Mexico, and
 *                          Arizona State University
 *      Sponsors: National Center for Ecological Analysis and Synthesis and
 *                Partnership for Interdisciplinary Studies of Coastal Oceans,
 *                   University of California Santa Barbara
 *                Long-Term Ecological Research Network Office,
 *                   University of New Mexico
 *                Center for Environmental Studies, Arizona State University
 * Other funding: National Science Foundation (see README for details)
 *                The David and Lucile Packard Foundation
 *   For Details: http://knb.ecoinformatics.org/
 *
 *      '$Author: walbridge $'
 *        '$Date: 2008-11-05 21:08:45 $'
 *    '$Revision: 1.16 $'
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
package org.ecoinformatics.eml;

import java.io.*;
import java.net.URL;
import java.util.*;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.ext.DeclHandler;
import org.xml.sax.ext.LexicalHandler;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.AttributesImpl;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.InputSource;

import org.apache.xpath.XPathAPI;
import org.apache.xerces.parsers.DOMParser;
import org.w3c.dom.Attr;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.DocumentType;
import org.apache.xerces.dom.DocumentTypeImpl;
import org.apache.xpath.objects.XObject;


import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.*;

import edu.ucsb.nceas.configxml.*;

/**
 * This is a SAX parser to validate EML packages.  This parser will validate
 * an EML package with references based on the following rules:
 * <ul>
 *  <li>
 *  If a user wants to reuse content to indicate the repetition of an object,
 *  a reference must be used. you cannot have two identical ids in a document.
 *  </li>
 *  <li>
 *  "Local scope" is defined as identifiers unique only to a single instance
 *  document (if a document does not have a system or if scope is set to 'local'
 *  then all ids are defined as distinct content).
 *  </li>
 *  <li>
 *  System scope is defined as identifiers unique to an entire data management
 *  system (if two documents share a system string, then any IDs in those two
 *  documents that are identical refer to the same object).
 *  </li>
 *  <li>
 *  If an element references another element, it must not have an ID.
 *  </li>
 *  <li>
 *  All EML packages must have the 'eml' module as the root.
 *  </li>
 *  <li>
 *  The system and scope attribute are always optional except for at the
 *  'eml' module where the scope attribute is fixed as 'system'. The scope
 *  attribute defaults to 'local' for all other modules.
 *  </li>
 * </ul>
 */
public class EMLParser
{
  private String parserName;
  private ConfigXML config;
  private Key[] keys;
  private Keyref[] keyrefs;
  private Hashtable idHash = new Hashtable();
  private Hashtable idrefHash = new Hashtable();
  private File xml;

  /**
   * parses an eml file
   * @param xml the eml input stream to parse
   */
  public EMLParser(File xml)
  {
    //this(xml, new File("lib/config.xml"));
    this.xml = xml;
    URL configFile = getClass().getResource("/config.xml");
    try
    {

      config = new ConfigXML(configFile.openStream());
    }
    catch(Exception e)
    {
      throw new EMLParserException("Config file not found: " + e.getMessage());
    }

    parseConfig();
    parseKeys();
    parseKeyrefs();
  }

  /**
   * parses an eml file
   * @param xml the eml file to parse
   * @param configFile the alternate config file to use
   */
  public EMLParser(File xml, File configFile)
         throws EMLParserException
  {
    this.xml = xml;
    try
    {
      config = new ConfigXML(configFile.getAbsolutePath());
    }
    catch(Exception e)
    {
      throw new EMLParserException("Config file not found: " + e.getMessage());
    }

    parseConfig();
    parseKeys();
    parseKeyrefs();
  }


  /**
   * parses an eml reader
   * @param xmlReader the xml need to parse
   * @param configFile the alternate config file to use
   */
  public EMLParser(String xmlReader)
         throws EMLParserException, IOException
  {
    if (xmlReader == null || xmlReader.equals(""))
    {
      throw new EMLParserException("The string need to be parse is null");
    }
    URL configFile = getClass().getResource("/config.xml");
    try
    {

      config = new ConfigXML(configFile.openStream());
    }
    catch(Exception e)
    {
      throw new EMLParserException("Config file not found: " + e.getMessage());
    }
    // catch the String reader
    String xmlString = xmlReader;
    parseConfig();
    parseKeys(xmlString);
    parseKeyrefs(xmlString);
  }


  /**
   * make sure all ids are unique and hash the keys
   */
  private void parseKeys()
  {
    for(int i=0; i<keys.length; i++)
    {
      try
      {
        NodeList keyNL = getPathContent(new FileInputStream(xml),
                                        keys[i].selector);
        parseKeysByNodeList(keyNL, i, keys[i].name);
      }
      catch(Exception e)
      {
        throw new EMLParserException("Error running xpath expression: " +
                                     keys[i].selector + " : " + e.getMessage());
      }
    }
  }

   /**
   * make sure all ids are unique and hash the keys for xml reader
   */
  private void parseKeys(String xmlString)
  {

    for(int i=0; i<keys.length; i++)
    {
      StringReader reader = new StringReader(xmlString);
      try
      {

        NodeList keyNL = getPathContent(reader, keys[i].selector);
        parseKeysByNodeList(keyNL, i, keys[i].name);
      }
      catch(Exception e)
      {
        throw new EMLParserException("Error running xpath expression: " +
                                     keys[i].selector + " : " + e.getMessage());
      }
    }
  }

  /**
   * Check nodelist has a unique key
   */
  private void parseKeysByNodeList(NodeList keyNL, int i, String keyname)
    throws Exception
  {
    for(int j=0; j<keyNL.getLength(); j++)
    {
      Node n = keyNL.item(j);
      Node id = XPathAPI.selectSingleNode(n, keys[i].field);
      String idval;

      if(id == null)
      {
        continue;
      }

      if(keys[i].field.indexOf("@") != -1)
      { //the field is an attribute
        idval = id.getNodeValue();
      }
      else
      { //the field is an element
        idval = id.getFirstChild().getNodeValue();
      }

      //try to get the id.  if it is already in the hash, throw exception
      //System.out.println("idval: " + idval);
      Object o = idHash.get(keyname + "." + idval);

      if(o == null)
      {
        //System.out.println("putting " + keyname + "." + idval + " :: " + i);
        idHash.put(keyname + "." + idval, new Integer(i));
        continue;  //continue on in the loop.
      }
      else
      {
        throw new EMLParserException("Error in xml document.  This " +
        "EML document is not valid because the id " +
        idval + " occurs " +
        "more than once.  IDs must be unique.");
      }
    }
  }


  /**
   * get all the keyrefs and make sure they don't have an id
   */
  private void parseKeyrefs()
  {
    for(int i=0; i<keyrefs.length; i++)
    {
      try
      {
        NodeList keyrefNL = getPathContent(new FileInputStream(xml),
                                           keyrefs[i].selector);
        parseKeyrefsByNodeList(keyrefNL, i);
      }
      catch(Exception e)
      {
        throw new EMLParserException("Error processing keyrefs: " +
                                     keyrefs[i].selector + " : " +
                                     e.getMessage());
      }
    }
  }

  /**
   * get all the keyrefs and make sure they don't have an id for xml reader
   */
  private void parseKeyrefs(String xmlString)
  {
    for(int i=0; i<keyrefs.length; i++)
    {
      StringReader reader = new StringReader(xmlString);
      try
      {
        NodeList keyrefNL = getPathContent(reader, keyrefs[i].selector);
        parseKeyrefsByNodeList(keyrefNL, i);

      }
      catch(Exception e)
      {
        throw new EMLParserException("Error processing keyrefs: " +
                                     keyrefs[i].selector + " : " +
                                     e.getMessage());
      }
    }
  }

  /*
   * get all the keyrefs and make usre they don't have and id(by node list)
   */
  private void parseKeyrefsByNodeList(NodeList keyrefNL, int i) throws Exception
  {
     for(int j=0; j<keyrefNL.getLength(); j++)
     {
          Node n = keyrefNL.item(j);
          Node id;
          if(keyrefs[i].field.equals("."))
          {
            id = n;
          }
          else
          {
            id = XPathAPI.selectSingleNode(n, keyrefs[i].field);
          }

          String idval;

          if(id == null)
          {
            continue;
          }

          if(keyrefs[i].field.indexOf("@") != -1)
          { //the field is an attribute
            idval = id.getNodeValue();
          }
          else
          { //the field is an element
            idval = id.getFirstChild().getNodeValue().trim();
          }

          int keyindex;
          Object o = idHash.get(keyrefs[i].refer + "." + idval);
          if(o == null)
          { //check to make sure the referenced key exists
            throw new EMLParserException("Error in xml document. This EML " +
              "instance is invalid because referenced id " + idval +
              " does not exist in the given keys.");
          }
          else
          {
            keyindex = ((Integer)o).intValue();
          }

          //now make sure that what it is referring to is the right key
          Key referencedKey = keys[keyindex];
          if(!referencedKey.name.equals(keyrefs[i].refer))
          {
            throw new EMLParserException("Error in xml document. This EML " +
              "instance is invalid because the keyref " + keyrefs[i].name +
              " must refer to a key by the name of " + keyrefs[i].refer +
              ". Instead it points at " + referencedKey.name);
          }

          //now make sure that the references parent meets the criteria
          //for the key's xpath expression and that it does not have
          //an id itself

          //get the parent of the id node
          Node parent = id.getParentNode();

          NamedNodeMap parentAtts = parent.getAttributes();
          //make sure that the reference doesn't have an id
          for(int k=0; k<parentAtts.getLength(); k++)
          {
            String parentAtt = parentAtts.item(k).getNodeName();
            if(("@" + parentAtt).equals(referencedKey.field))
            {
              throw new EMLParserException("Error in xml document. This EML " +
                "instance is invalid because this element has an id " +
                "and it is being used in a keyref expression.");
            }
          }
     }//for
  }

  /**
   * returns the absolute path of the node
   */
  private static String reverseEngineerPath(Node n)
  {
    String nodename = n.getNodeName();
    String path = "";
    while(!nodename.equals("#document"))
    {
      path = nodename + "/" + path;
      n = n.getParentNode();
      nodename = n.getNodeName();
    }

    return "/" + path;
  }

  /**
   * builds a document from a path.  the document is returned empty.
   * if you pass this /x/y/z you will get back a document of the form
   * &lt;x&gt;&lt;y&gt;&lt;z&gt;&lt;/z&gt;&lt;/y&gt;&lt;/x&gt;
   * @param path the path to parse
   */
  private Document buildDocumentFromPath(String path)
  {
    try
    {
      DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
      StringBuffer xml = new StringBuffer();
      Stack s = new Stack();

      StringTokenizer tokenizer = new StringTokenizer(path, "/");
      while(tokenizer.hasMoreElements())
      {
        String node = tokenizer.nextToken();
        xml.append("<").append(node).append(">");
        s.push(node);
      }

      while(!s.empty())
      {
        String node = (String)s.pop();
        xml.append("</").append(node).append(">");
      }

      return builder.parse(new InputSource(new StringReader(xml.toString())));
    }
    catch(Exception e)
    {
      throw new EMLParserException("Error building document fragment: " +
                                   e.getMessage());
    }
  }

  private void resolveKeys()
  {

  }

  /**
   * Gets the content of a path in an xml file(form input stream)
   */
  public static NodeList getPathContent(InputStream is, String xpath)
         throws Exception
  {
    InputSource in = new InputSource(is);
    return getPathContent(in, xpath);
  }

  /**
   * Gets the conten of a path in an xml document(from Reader)
   */
  public static NodeList getPathContent(StringReader read, String xpath)
                         throws Exception
  {
    InputSource in = new InputSource(read);
    DocumentBuilderFactory dfactory = DocumentBuilderFactory.newInstance();
    dfactory.setNamespaceAware(false);
    Document doc = dfactory.newDocumentBuilder().parse(in);

    // Set up an identity transformer to use as serializer.
    Transformer serializer = TransformerFactory.newInstance().newTransformer();
    serializer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");

    // Use the simple XPath API to select a nodeIterator.
    NodeList nl = XPathAPI.selectNodeList(doc, xpath);
    return nl;
    //return getPathContent(in, xpath);
  }

  private static NodeList getPathContent(InputSource in, String xpath)
                          throws Exception
  {
    DocumentBuilderFactory dfactory = DocumentBuilderFactory.newInstance();
    dfactory.setNamespaceAware(false);
    Document doc = dfactory.newDocumentBuilder().parse(in);

    // Set up an identity transformer to use as serializer.
    Transformer serializer = TransformerFactory.newInstance().newTransformer();
    serializer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");

    // Use the simple XPath API to select a nodeIterator.
    NodeList nl = XPathAPI.selectNodeList(doc, xpath);
    return nl;
  }

  private void parseConfig()
  {
    try
    { //parse the keys and keyrefs out of the config file
      NodeList keyNL = config.getPathContent("//key");
      keys = new Key[keyNL.getLength()];
      NodeList keyrefNL = config.getPathContent("//keyref");
      keyrefs = new Keyref[keyrefNL.getLength()];

      //get the keys
      for(int i=0; i<keyNL.getLength(); i++)
      {
        String name = "";
        String selector = "";
        String field = "";

        Node n = keyNL.item(i);

        //get the name
        NamedNodeMap atts = n.getAttributes();
        Node nameatt = atts.getNamedItem("name");
        name = nameatt.getNodeValue();

        //get the selector and field
        NodeList keychildren = n.getChildNodes();
        for(int j=0; j<keychildren.getLength(); j++)
        {
          Node kc = keychildren.item(j);
          if(kc.getNodeName().equals("selector"))
          {
            NamedNodeMap selectoratts = kc.getAttributes();
            Node selectoratt = selectoratts.getNamedItem("xpath");
            selector = selectoratt.getNodeValue();
          }
          else if(kc.getNodeName().equals("field"))
          {
            NamedNodeMap fieldatts = kc.getAttributes();
            Node fieldatt = fieldatts.getNamedItem("xpath");
            field = fieldatt.getNodeValue();
          }
        }

        if(name.equals("") | selector.equals("") | field.equals(""))
        {
          throw new EMLParserException("Error in config file.  All keys " +
                                       "must have a name, selector and field.");
        }

        keys[i] = new Key(name, selector, field);
      }

      //get the keyrefs
      for(int i=0; i<keyrefNL.getLength(); i++)
      {
        String name = "";
        String refer = "";
        String selector = "";
        String field = "";

        Node n = keyrefNL.item(i);

        //get the name and refer
        NamedNodeMap atts = n.getAttributes();
        Node nameatt = atts.getNamedItem("name");
        name = nameatt.getNodeValue();
        Node referatt = atts.getNamedItem("refer");
        refer = referatt.getNodeValue();

        //get the selector and field
        NodeList keychildren = n.getChildNodes();
        for(int j=0; j<keychildren.getLength(); j++)
        {
          Node kc = keychildren.item(j);
          if(kc.getNodeName().equals("selector"))
          {
            NamedNodeMap selectoratts = kc.getAttributes();
            Node selectoratt = selectoratts.getNamedItem("xpath");
            selector = selectoratt.getNodeValue();
          }
          else if(kc.getNodeName().equals("field"))
          {
            NamedNodeMap fieldatts = kc.getAttributes();
            Node fieldatt = fieldatts.getNamedItem("xpath");
            field = fieldatt.getNodeValue();
          }
        }

        if(name.equals("") | selector.equals("") |
           field.equals("") | refer.equals(""))
        {
          throw new EMLParserException("Error in config file.  All keys " +
                                       "must have a name, selector and field.");
        }

        keyrefs[i] = new Keyref(name, refer, selector, field);
      }
    }
    catch(Exception e)
    {
      throw new EMLParserException("Error parsing keys and keyrefs in config " +
                                   "file: " + e.getMessage());
    }
  }

  /**
   * provides a command line interface.
   */
  public static void main(String[] args)
  {
    if(args.length > 0 && !args[0].equals("-q"))
    {
      System.out.println("EML Parser version 1.0");
      System.out.println("Note that this parser DOES NOT VALIDATE your eml file ");
      System.out.println("agains the schema.  It only validates the ids and ");
      System.out.println("references. To validate your eml file against the ");
      System.out.println("schema, use SAXValidate or another xml parser.");
      System.out.println("Usage: java org.ecoinformatics.eml.EMLParser [-q] [<config file>] <eml file>");
      System.out.println("-----------------------------------------------------------------------");
    }

    if(args.length > 3)
    {
      System.out.println("Invalid number of arguments.");
    }

    String configfile = "";
    String emlfile = "";
    if(args.length == 3)
    {
      configfile = args[1];
      emlfile = args[2];
      System.out.println("emlfile: " + emlfile + " configfile: " + configfile);
    }
    else if(args.length == 2)
    {
      if(args[0].equals("-q"))
      {
        emlfile = args[1];
      }
      else
      {
        configfile = args[0];
        emlfile = args[1];
      }
    }
    else if(args.length == 1)
    {
      emlfile = args[0];
    }
    else if(args.length == 0)
    {

      System.out.println("Usage: java org.ecoinformatics.eml.EMLParser [-q] [<config file>] <eml file>");
      System.out.println("  -q = quiet mode, little or no output");
      System.out.println("  <config file> = use an alternate config file.  The default is lib/config.xml");
      System.out.println("  <eml file> = the EML file to parse");
      System.exit(0);
    }

    try
    {
      if(configfile.equals(""))
      {
        EMLParser parser = new EMLParser(new File(emlfile));
        FileReader xmldoc = new FileReader(emlfile);
        char [] ch = new char [4096];
        StringWriter writer = new StringWriter();
        int readNum = xmldoc.read(ch);
        while (readNum != -1)
        {
          writer.write(ch, 0, readNum);
          readNum = xmldoc.read(ch);
        }
        String str = writer.toString();
        EMLParser readerParser = new EMLParser(str);

      }
      else
      {
        EMLParser parser = new EMLParser(new File(emlfile), new File(configfile));
      }
      System.out.println(emlfile + " has valid ids and references.");
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }

  /**
   * class to represent a key
   */
  private class Key
  {
    protected String selector; //xpath expression for the selector
    protected String field;    //xpath expression for the field in the selector
    protected String name;     //name of the key

    Key(String name, String selector, String field)
    {
      this.name = name;
      this.selector = selector;
      this.field = field;
    }

    public String toString()
    {
      String s = "name: " + name + " selector: " + selector + " field: " + field;
      return s;
    }
  }

  /**
   * class to represent a keyref
   */
  private class Keyref
  {
    protected String name;     //name of the keyref
    protected String refer;    //the key that we are refering to
    protected String selector; //the selector for the keyref
    protected String field;    //the field in the selector

    Keyref(String name, String refer, String selector, String field)
    {
      this.name = name;
      this.refer = refer;
      this.selector = selector;
      this.field = field;
    }

    public String toString()
    {
      String s = "name: " + name + " refer: " + refer + " selector: " +
                  selector + " field: " + field;
      return s;
    }
  }
}

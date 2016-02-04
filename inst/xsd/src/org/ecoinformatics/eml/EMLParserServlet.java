/**
 *     '$RCSfile: EMLParserServlet.java,v $'
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
 *      '$Author: tao $'
 *        '$Date: 2008-10-09 00:00:40 $'
 *    '$Revision: 1.11 $'
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
import java.lang.*;
import java.util.*;
import java.lang.reflect.*;
import java.net.*;
import java.util.zip.*;

import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.MultipartParser;
import com.oreilly.servlet.multipart.ParamPart;
import com.oreilly.servlet.multipart.Part;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpUtils;
import javax.servlet.ServletOutputStream;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 * Servlet interface for the EMLParser
 */
public class EMLParserServlet extends HttpServlet
{

  private ServletConfig servletconfig = null;
  private ServletContext context = null;
  private HttpServletRequest request;
  private static HttpServletResponse response;
  private static PrintWriter out = null;
  private Hashtable params = new Hashtable();
  private static final String namespaces = "eml://ecoinformatics.org/eml-2.0.0 http://knb.ecoinformatics.org/emlparser/schema/eml-2.0.0/eml.xsd     eml://ecoinformatics.org/eml-2.0.1  http://knb.ecoinformatics.org/emlparser/schema/eml-2.0.1/eml.xsd     eml://ecoinformatics.org/eml-2.1.0 http://knb.ecoinformatics.org/emlparser/schema/eml-2.1.0/eml.xsd     eml://ecoinformatics.org/literature-2.1.0 http://knb.ecoinformatics.org/emlparser/schema/eml-2.1.0/eml-literature.xsd     eml://ecoinformatics.org/project-2.1.0 http://knb.ecoinformatics.org/emlparser/schema/eml-2.1.0/eml-project.xsd     eml://ecoinformatics.org/eml-2.1.1 eml.xsd     eml://ecoinformatics.org/literature-2.1.1 eml-literature.xsd     eml://ecoinformatics.org/project-2.1.1 eml-project.xsd     http://www.xml-cml.org/schema/stmml-1.1 http://knb.ecoinformatics.org/emlparser/schema/eml-2.1.0/stmml.xsd     http://www.xml-cml.org/schema/stmml http://knb.ecoinformatics.org/emlparser/schema/eml-2.0.1/stmml.xsd";
  private static final String NAMESPACEKEYWORD = "xmlns";
  public static final String EML2_1_1NAMESPACE = "eml://ecoinformatics.org/eml-2.1.1";
  public static final String EML2_1_0NAMESPACE = "eml://ecoinformatics.org/eml-2.1.0";
  public static final String EML2_0_1NAMESPACE = "eml://ecoinformatics.org/eml-2.0.1";
  public static final String EML2_0_0NAMESPACE = "eml://ecoinformatics.org/eml-2.0.0";

  /**
   * Initialize the servlet
   */
  public void init(ServletConfig servletconfig) throws ServletException
  {
    try
    {
      super.init(servletconfig);
      this.servletconfig = servletconfig;
      this.context = servletconfig.getServletContext();
      System.out.println("Starting EMLParserServlet");
    }
    catch (ServletException ex)
    {
      throw ex;
    }
  }

  /**
   * Destroy the servlet
   */
  public void destroy()
  {
    System.out.println("Destroying EMLParserServlet");
  }

  /** Handle "GET" method requests from HTTP clients */
  public void doGet (HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    // Process the data and send back the response
    handleGetOrPost(request, response);
  }

  /** Handle "POST" method requests from HTTP clients */
  public void doPost( HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    // Process the data and send back the response
    handleGetOrPost(request, response);
  }

  /**
   * Control servlet response depending on the action parameter specified
   */
  private void handleGetOrPost(HttpServletRequest request,
                               HttpServletResponse response)
                               throws ServletException, IOException
  {
    this.request = request;
    this.response = response;
    StringBuffer html = new StringBuffer();
    out = response.getWriter();
    String ctype = request.getContentType();
    InputStream fileToParse = null;
    File tempfile = null;

    html.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD html 4.0//EN\">");
    html.append("<html>");
    html.append("<head>");
    html.append("<title>EML ID and References Parser</title>");
    html.append("<link rel=\"stylesheet\" type=\"text/css\" ");
    html.append("href=\"http://knb.ecoinformatics.org/default.css\">");
    html.append("</head>");
    html.append("<body>");
    html.append("<table class=\"tabledefault\" width=\"100%\">");
    html.append("<tbody>");
    html.append("<tr>");
    html.append("<td rowspan=\"2\">");
    html.append("<img src=\"http://knb.ecoinformatics.org/images/KNBLogo.gif\">");
    html.append("</td>");
    html.append("<td colspan=\"7\"><div class=\"title\">");
    html.append("EML ID and References Parser</div></td>");
    html.append("</tr>");
    html.append("<tr>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/\" ");
    html.append("class=\"toollink\"> KNB Home </a></td>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/data.html\" ");
    html.append("class=\"toollink\"> Data </a></td>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/people.html\" ");
    html.append("class=\"toollink\"> People </a></td>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/informatics\" ");
    html.append("class=\"toollink\"> Informatics </a></td>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/biodiversity\" ");
    html.append("class=\"toollink\"> Biocomplexity </a></td>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/education\" ");
    html.append("class=\"toollink\"> Education </a></td>");
    html.append("<td><a href=\"http://knb.ecoinformatics.org/software\" ");
    html.append("class=\"toollink\"> Software </a></td>");
    html.append("</tr>");
    html.append("</tbody>");
    html.append("</table>");
    html.append("<hr>");

    HttpSession sess = request.getSession(true);
    String sess_id = "";
    try
    { //get the cookie for the session.
      sess_id = (String)sess.getId();
    }
    catch(IllegalStateException ise)
    {
      System.out.println("error in handleGetOrPost: this shouldn't " +
                         "happen: the session should be valid: " +
                         ise.getMessage());
    }

    File tempdir = new File("/tmp/emlparser");
    if(!tempdir.exists())
    {
      tempdir.mkdirs();
    }

    tempfile = new File("/tmp/emlparser/.tmpfile." + sess_id);

    if (ctype != null && ctype.startsWith("multipart/form-data"))
    { //deal with multipart encoding of the package zip file
      try
      {
        fileToParse = handleGetFile(request, response);
        int c = fileToParse.read();
        FileOutputStream fos = new FileOutputStream(tempfile);
        while(c != -1)
        {
          fos.write(c);
          c = fileToParse.read();
        }
        fos.flush();
        fos.close();
      }
      catch(Exception e)
      {
        out.println("<html><body><h1>Error handling multipart data: " +
                    e.getMessage() + "</h1></body></html>");
        System.out.println("Error handling multipart data: " + e.getMessage());
        e.printStackTrace();
      }
    }
    else
    {
      Enumeration paramlist = request.getParameterNames();
      while (paramlist.hasMoreElements())
      {
        String name = (String)paramlist.nextElement();
        Object value = request.getParameterValues(name);
        params.put(name,value);
      }
    }

    String action = ((String[])params.get("action"))[0];

    if(action.equals("parse"))
    { //parse action
      html.append(parse(tempfile));
    }
    else if(action.equals("textparse"))
    {
      String doctext = ((String[])params.get("doctext"))[0];
      if(doctext == null || doctext.trim().equals(""))
      {
        html.append("<h2>Error.  Submitted document is null.</h2>");
      }
      else
      {
        StringReader sr = new StringReader(doctext);
        FileWriter fw = new FileWriter(tempfile);
        int c = sr.read();
        while(c != -1)
        {
          fw.write(c);
          c = sr.read();
        }
        fw.flush();
        fw.close();

        html.append(parse(tempfile));
      }
    }
    else
    {
      html.append("<h2>Error.  Action '").append(action);
      html.append("' not registered</h2>");
    }

    tempfile.delete();

    html.append("<hr><a href=\"/emlparser\">Back</a> to the previous page.");
    html.append("</body></html>");
    response.setContentType("text/html");
    out.println(html.toString());
    out.flush();
  }

  private String parse(File tempfile)
  {
    StringBuffer html = new StringBuffer();

    try
    {
      if(tempfile != null)
      {
        EMLParser parser = new EMLParser(tempfile,
                           new File("/var/www/org.ecoinformatics.knb/emlparser/lib/config.xml"));
        html.append("<h2>EML specific tests: Passed.</h2><p>The tests which ");
        html.append("are specific to EML, including validation that IDs are ");
	html.append("present and properly referenced, have passed.</p>");
      }
      else
      {
        html.append("<h2>Error: The file sent to the parser was null.</h2>");
      }
    }
    catch(Exception e)
    {
      html.append("<h2>EML specific tests: Failed.</h2><p>The following errors were found:");
      html.append("</p><p>").append(e.getMessage()).append("</p>");
    }

    try
    {
      Reader xmlReader = new FileReader(tempfile);
      String namespaceInDoc = findNamespace(xmlReader);
      xmlReader.close();
      System.out.println("The namespace in xml is "+namespaceInDoc);
      SAXValidate validator = new SAXValidate(true);
      validator.runTest(new FileReader(tempfile), "DEFAULT", namespaces, namespaceInDoc);
      html.append("<hr><h2>XML specific tests: Passed.</h2>");
      html.append("<p>Document is XML-schema valid. There were no XML errors found in your document.</p>");
    }
    catch(IOException ioe)
    {
      html.append("<hr><h2>IOException: Error reading file</h2>");
      html.append("<p>").append(ioe.getMessage()).append("</p>");
    }
    catch(ClassNotFoundException cnfe)
    {
      html.append("<hr><h2>Parser class not found</h2>");
      html.append("<p>").append(cnfe.getMessage()).append("</p>");
    }
    catch(SAXException se)
    {
      if(se.getMessage().indexOf("WARNING") != -1)
      {
        html.append("<hr><h2>XML-Schema Warning</h2><p>The following warnings ");
        html.append("were issued about your document: </p><p>");
        html.append(se.getMessage()).append("</p>");
      }
      else
      {
        html.append("<hr><h2>XML specific tests: Failed</h2><p>");
        html.append("The following errors were ");
        html.append("found:</p><p>").append(se.getMessage()).append("</p>");
      }
    }

    return html.toString();
  }

   /**
   * This method deals with getting the zip file from the client, unzipping
   * it, then running the process on it.
   */
  private InputStream handleGetFile(HttpServletRequest request,
                               HttpServletResponse response)
                               throws Exception
  {
    Hashtable fileList = new Hashtable();
    try
    {
      MultipartParser mp = new MultipartParser(request, 1024 * 1024 * 8);
      Part part;
      while ((part = mp.readNextPart()) != null)
      {
        String name = part.getName();
        if (part.isParam())
        { // it's a parameter part
          ParamPart paramPart = (ParamPart) part;
          String value = paramPart.getStringValue();
          String[] s = {value};
          params.put(name, s);
        }
        else if (part.isFile())
        { // it's a file part
          FilePart filePart = (FilePart) part;
          fileList.put(name, filePart);
          // Stop once the first file part is found, otherwise going onto the
          // next part prevents access to the file contents.  So...for upload
          // to work, the datafile must be the last part
          break;
        }
      }
    }
    catch (Exception ioe)
    {
      throw ioe;
    }

    //now that we have the file, do some checking and get the files we need
    //out of the zip file.
    FilePart fp = (FilePart)fileList.get("filename");
    return fp.getInputStream();
  }
  
  /**
   * Gets namespace from the xml source
   */
  public static String findNamespace(Reader xml) throws IOException {
     
      String namespace = null;
      
      String eml2_0_0NameSpace = EML2_0_0NAMESPACE;
      String eml2_0_1NameSpace = EML2_0_1NAMESPACE;
      String eml2_1_0NameSpace = EML2_1_0NAMESPACE;
      String eml2_1_1NameSpace = EML2_1_1NAMESPACE;
      
      if (xml == null) {
          //System.out.println("Validation for schema is "+ namespace);
          return namespace;
      }
      String targetLine = getSchemaLine(xml);
      
      if (targetLine != null) {
          
          // find if the root element has prefix
          String prefix = getPrefix(targetLine);
          //System.out.println("prefix is:" + prefix);
          int startIndex = 0;
          
          
          if(prefix != null) {
              // if prefix found then look for xmlns:prefix
              // element to find the ns
              String namespaceWithPrefix = NAMESPACEKEYWORD
                      + ":" + prefix;
              startIndex = targetLine.indexOf(namespaceWithPrefix);
              //System.out.println("namespaceWithPrefix is:" + namespaceWithPrefix+":");
              //System.out.println("startIndex is:" + startIndex);
              
          } else {
              // if prefix not found then look for xmlns
              // attribute to find the ns
              startIndex = targetLine.indexOf(NAMESPACEKEYWORD);
              //System.out.println("startIndex is:" + startIndex);
          }
          
          int start = 1;
          int end = 1;
          String namespaceString = null;
          int count = 0;
          if (startIndex != -1) {
              for (int i = startIndex; i < targetLine.length(); i++) {
                  if (targetLine.charAt(i) == '"') {
                      count++;
                  }
                  if (targetLine.charAt(i) == '"' && count == 1) {
                      start = i;
                  }
                  if (targetLine.charAt(i) == '"' && count == 2) {
                      end = i;
                      break;
                  }
              }
          }
          // else: xmlns not found. namespace = null will be returned
          
          //System.out.println("targetLine is " + targetLine);
          //System.out.println("start is " + end);
          //System.out.println("end is " + end);
          
          if(start < end){
              namespaceString = targetLine.substring(start + 1, end);
              //System.out.println("namespaceString is " + namespaceString);
          }
          //System.out.println("namespace in xml is: "+ namespaceString);
          if(namespaceString != null){
              if (namespaceString.indexOf(eml2_0_0NameSpace) != -1) {
                  namespace = eml2_0_0NameSpace;
              } else if (namespaceString.indexOf(eml2_0_1NameSpace) != -1) {
                  namespace = eml2_0_1NameSpace;
              } else if (namespaceString.indexOf(eml2_1_0NameSpace) != -1) {
                  namespace = eml2_1_0NameSpace;
              } else if (namespaceString.indexOf(eml2_1_1NameSpace) != -1) {
                  namespace = eml2_1_1NameSpace;
              } else {
                  namespace = namespaceString;
              }
          }
      }
      
      //System.out.println("Validation for eml is " + namespace);
      
      return namespace;
      
  }
  
  /*
   * Gets the string which contains schema declaration info
   */
  private static String getSchemaLine(Reader xml) throws IOException {
      
      // find the line
      String secondLine = null;
      int count = 0;
      int endIndex = 0;
      int startIndex = 0;
      final int TARGETNUM = 1;
      StringBuffer buffer = new StringBuffer();
      boolean comment = false;
      boolean processingInstruction = false;
      char thirdPreviousCharacter = '?';
      char secondPreviousCharacter = '?';
      char previousCharacter = '?';
      char currentCharacter = '?';
      int tmp = xml.read();
      while (tmp != -1) {
          currentCharacter = (char)tmp;
          //in a comment
          if (currentCharacter == '-' && previousCharacter == '-'
                  && secondPreviousCharacter == '!'
                  && thirdPreviousCharacter == '<') {
              comment = true;
          }
          //out of comment
          if (comment && currentCharacter == '>' && previousCharacter == '-'
                  && secondPreviousCharacter == '-') {
              comment = false;
          }
          
          //in a processingInstruction
          if (currentCharacter == '?' && previousCharacter == '<') {
              processingInstruction = true;
          }
          
          //out of processingInstruction
          if (processingInstruction && currentCharacter == '>'
                  && previousCharacter == '?') {
              processingInstruction = false;
          }
          
          //this is not comment or a processingInstruction
          if (currentCharacter != '!' && previousCharacter == '<'
                  && !comment && !processingInstruction) {
              count++;
          }
          
          // get target line
          if (count == TARGETNUM && currentCharacter != '>') {
              buffer.append(currentCharacter);
          }
          if (count == TARGETNUM && currentCharacter == '>') {
              break;
          }
          thirdPreviousCharacter = secondPreviousCharacter;
          secondPreviousCharacter = previousCharacter;
          previousCharacter = currentCharacter;
          tmp = xml.read();
      }
      secondLine = buffer.toString();
      //System.out.println("the second line string is: " + secondLine);
      
      //xml.reset();
      return secondLine;
  }
  
  /*
   * Gets the prefix of this eml document. E.g eml for eml:eml
   */
  private static String getPrefix(String schemaLine) {
    
      String prefix = null;
      
      if(schemaLine.indexOf(" ") > 0){
          String rootElement = "";
          try {
              rootElement = schemaLine.substring(0, schemaLine.indexOf(" "));
          } catch (StringIndexOutOfBoundsException sioobe) {
              rootElement = schemaLine;
          }
          
          //System.out.println("rootElement:" + rootElement);
          
          if(rootElement.indexOf(":") > 0){
              prefix = rootElement.substring(0, rootElement.indexOf(":"));
          }
          
          if(prefix != null){
              return prefix.trim();
          }
      }
      return null;
  }
}

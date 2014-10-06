/**
 *  '$RCSfile: EMLConvert.java,v $'
 *  Copyright: 2000 Regents of the University of California and the
 *              National Center for Ecological Analysis and Synthesis
 *    Authors: @authors@
 *    Release: @release@
 *
 *   '$Author: higgins $'
 *     '$Date: 2003-03-21 17:54:15 $'
 * '$Revision: 1.3 $'
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/**
 * The purpose of this class is to transform an emlbeta6 package to an eml2 document.
 * This process is done using two succesive xslt transformations.
 * 
 * The 'main' class runs the transformation from the command line. The path to the 
 * top level beta6 dataset module must be passed on the command line. All the associated 
 * modules in the package are assumed to be in the same directory and the file names are
 * the ids used in the beta6 triples (e.g. "higgins.232.3")
 */ 

import javax.xml.transform.*;
import javax.xml.transform.sax.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

// Needed java classes
import java.io.InputStream;
import java.io.Reader;
import java.io.IOException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.StringWriter;
import java.io.FileWriter;

import java.util.Properties;

// Needed SAX classes  
import org.xml.sax.*;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.Parser;
import org.xml.sax.helpers.ParserAdapter;
import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.XMLReader;
import org.xml.sax.XMLFilter;
import org.xml.sax.ContentHandler;
import org.xml.sax.ext.LexicalHandler;
import org.xml.sax.ext.DeclHandler;

// Imported Serializer classes
import org.apache.xalan.serialize.Serializer;
import org.apache.xalan.serialize.SerializerFactory;
import org.apache.xalan.templates.OutputProperties;


import javax.xml.parsers.*;

public class EMLConvert
{ 

  static String path = "";
  static String fname = "";

  private static String indentAmount = "2";

  public static void setIndentAmount(String indentAmount) {
    EMLConvert.indentAmount = indentAmount;
  }

  /**
   * Method main
   */
  public static void main(String argv[]) 
            throws TransformerException, TransformerConfigurationException, Exception {
    if (argv.length<1) {
      System.out.println("Must have an argument with name/path of dataset module");
      System.exit(0);
    }

    
    // Instantiate  a TransformerFactory.
  	TransformerFactory tFactory = TransformerFactory.newInstance();
    URIResolver res = new MyURIResolver();   
    if (argv.length>1) {
      path = argv[1];
      if (!path.startsWith("file://")) {
         path = "file://" + path;
      }
      MyURIResolver.setDataDefault(path);
    }
    
    
    tFactory.setURIResolver(res);  


    // Determine whether the TransformerFactory supports The use uf SAXSource 
    // and SAXResult
    if (tFactory.getFeature(SAXSource.FEATURE) && tFactory.getFeature(SAXResult.FEATURE))
    { 
      // Cast the TransformerFactory to SAXTransformerFactory.
      SAXTransformerFactory saxTFactory = ((SAXTransformerFactory) tFactory);	  
      // Create a TransformerHandler for each stylesheet.
      TransformerHandler tHandler1 = saxTFactory.newTransformerHandler(new StreamSource("xsl/triple_info.xsl"));
      TransformerHandler tHandler2 = saxTFactory.newTransformerHandler(new StreamSource("xsl/emlb6toeml2.xsl")); 
      
      Transformer tr = tHandler1.getTransformer(); 
      getPathInfo(argv[0]);
      if (path.length()>0) {
         if (!path.startsWith("file://")) {
            path = "file://" + path;
         }
         MyURIResolver.setDataDefault(path);
      }
      tr.setParameter("packageName", fname); 

      Transformer lastTransformer = tHandler2.getTransformer();
      lastTransformer.setOutputProperty(OutputProperties.S_KEY_INDENT_AMOUNT, EMLConvert.indentAmount);

    
      // Create an XMLReader.
	    XMLReader reader = XMLReaderFactory.createXMLReader();
      reader.setContentHandler(tHandler1);
      reader.setProperty("http://xml.org/sax/properties/lexical-handler", tHandler1);

      tHandler1.setResult(new SAXResult(tHandler2));

//      StringWriter writer = new StringWriter();
      File outfile = new File("eml2out.xml");
      FileWriter writer = new FileWriter(outfile);
      Result result = new StreamResult(writer);

      tHandler2.setResult(result);

	    // Parse the XML input document. The input ContentHandler and output ContentHandler
      // work in separate threads to optimize performance. 

      reader.parse("xsl/triple_info.xsl"); 
//      String resultString = writer.toString();
//      System.out.println(resultString);
    }  
  }

  private static void getPathInfo1(String str) {
    int pos = -1;
    if ((str.indexOf("/")>-1)||(str.indexOf("\\")>-1)) {  
      int pos1 = str.lastIndexOf("/");
      int pos2 = str.lastIndexOf("\\");
      if (pos1>pos2) {
        pos = pos1;  
      }
      else { pos = pos2; }
      path = str.substring(0,pos+1);
      fname = str.substring(pos+1,str.length());  
    }
    else {
      fname = str;
    }
//   System.out.println("path: "+path+"  --fname: "+fname);
  } 

  private static void getPathInfo(String str) {
    File nf = new File(str);
    if (nf.exists()) {
      fname = nf.getName();
      path = nf.getAbsolutePath();
   System.out.println("path: "+path+"  --fname: "+fname);
    }
  }

}
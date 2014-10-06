/**
 *  '$RCSfile: MyURIResolver.java,v $'
 *  Copyright: 2000 Regents of the University of California and the
 *              National Center for Ecological Analysis and Synthesis
 *    Authors: @authors@
 *    Release: @release@
 *
 *   '$Author: higgins $'
 *     '$Date: 2003-03-20 00:53:16 $'
 * '$Revision: 1.2 $'
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
  The purpose of this class is to provide a special loader for use in xalan xslt transformations.
  It is used to remove the DOCTYPE elements from xml files loaded using the xslt 'document()' command.
  Otherwise, the xalan transformation engine tries to load SystemIDa in certain documents, and these
  are not necessarily correct/resolvable (especially since Morpho always uses the PublicID internally)
  This class extends the Trax URIResolver interface. Besides removing DOCTYPE elements, the class also
  provides for resolving the location of xsl/xml docs in one location and other documents 
  (like emlbeta6 modules) in a separate location.
*/ 
 
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory; 
import javax.xml.transform.TransformerException;
import javax.xml.transform.Source;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import javax.xml.transform.URIResolver;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;
import java.net.URL;
import java.io.*;

public class MyURIResolver implements URIResolver{   

  /*
   * used when the 'base' parameter for the 'resolve' method is null
   */
  static String baseDefault = "./";
  
  /*
   * used for non-xsl/xml documents; i.e. beta6 eml modules.
   * this is basically the path to datafiles
   */
  static String dataDefault = ""; 

  /*
   * method for setting the dataDefault param from another method
   */
  static public void setDataDefault(String s) {
    dataDefault = s;
  }
 
 /*
  * single method required by URIResolver interface
  */
 public Source resolve(String href, String base) throws TransformerException { 
  URL u = null;
  URL uDefault = null;
  try{  
    if ((base!=null)&&(isXMLXSL(href))) {
//     System.out.println("base: "+base+ " --href: "+href);
     URL context = new URL(base); 
      baseDefault = base;
      u = new URL(context, href);
    } else if (isXMLXSL(href)) {
//      System.out.println("baseDefault: "+baseDefault+ " --href: "+href);
      uDefault = new URL(baseDefault);
      u = new URL(uDefault, href); 
    } else {
//      System.out.println("dataDefault: "+dataDefault+ " --href: "+href); 
      uDefault = new URL(dataDefault);
      u = new URL(uDefault, href); 
    }
//    System.out.println("----URL:"+u.toString());
    InputStream is = u.openStream(); 
    InputStreamReader isr = new InputStreamReader(is);

    StringWriter sw = new StringWriter();
    int c;

    while ((c = isr.read()) != -1) {
        sw.write(c);
    } 
    sw.flush();
    is.close();
    sw.close();
    String sws = sw.toString();

    String outStr = removeDOCTYPE(sws);
    
    StringReader newStr = new StringReader(outStr);

    StreamSource stSrc = new StreamSource(newStr); 
    return stSrc;

    }
    catch (Exception e) { 
      System.out.println("-----Exception triggered in MyURIResolver-----");
      return null;
    }
  }

  /*
   * removes the DOCTYPE element and its contents from a Sting
   * used to avoid problems with incorrect SystemIDs 
   */
  private String removeDOCTYPE(String in) {  
    String ret = "";
    int startpos = in.indexOf("<!DOCTYPE");
    if (startpos>-1) {
      int stoppos = in.indexOf(">", startpos+10);   
      ret = in.substring(0,startpos) + in.substring(stoppos+1,in.length());
    } else {
      return in;
    }
    return ret;  
  }
   
  private boolean isXMLXSL(String str) {
    boolean ret = false;
    if ((str.indexOf(".xsl")>-1)||(str.indexOf(".XSL")>-1)) ret = true;
    if ((str.indexOf(".xml")>-1)||(str.indexOf(".XML")>-1)) ret = true;
    return ret;
  }

}

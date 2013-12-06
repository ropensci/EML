<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <xsl:output method="xml" indent="yes" encoding="utf-8" />
  <xsl:template match="/">
    <xsl:element name="rdf:RDF">
      <rdf:Description>
          <xsl:attribute name="rdf:about">
            <xsl:text>#</xsl:text> 
            <xsl:value-of select="eml/@packageId"/>
          </xsl:attribute> 
          <xsl:apply-templates select="/*|/@*"/>
       </rdf:Description>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*">
    <xsl:param name="subjectname"/>
              <!-- Build URI for subjects resources from acestors elements -->
              <xsl:element name="dc:title">
                <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                <xsl:value-of select="dataset/title"/>
              </xsl:element>
               <xsl:element name="dc:date">
                <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                <xsl:value-of select="dataset/pubDate"/>
              </xsl:element>
             <xsl:element name="dc:publisher">
                <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                <xsl:value-of select="dataset/publisher/organizationName"/>
              </xsl:element>
              <xsl:element name="dc:rights">
                <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                <xsl:value-of select="dataset/intellectualRights"/>
              </xsl:element>
             <xsl:element name="dc:description">
                <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                <xsl:value-of select="dataset/abstract"/>
              </xsl:element>
             <xsl:for-each select="dataset/creator">
               <xsl:element name="dc:creator">
                  <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                  <xsl:value-of select="individualName/givenName"/>&#160;<xsl:value-of select="individualName/surName"/>
                </xsl:element>
             </xsl:for-each>



        <!-- 
<dc:creator rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="contact/individualName/givenName"/><xsl:value-of select="contact/individualName/surName"/></dc:creator>
-->

  </xsl:template>
 </xsl:stylesheet>



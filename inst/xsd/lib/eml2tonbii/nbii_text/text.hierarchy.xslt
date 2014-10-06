<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://www.ora.com/XSLTCookbook/namespaces/strings">


<xsl:include href="str.dup.xslt"/>
<xsl:include href="str.replace.xslt"/>

<xsl:output method="text"/>

<!--Levels indented with two spaces by default -->
<xsl:param name="indent" select=" '  ' "/>

<xsl:template match="*">
  <xsl:param name="level" select="count(./ancestor::*)"/>
  
  <!-- Indent this element -->
  <xsl:apply-templates select="." mode="indent">
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
  
  <!--Process the element name. Default will output loacl-name -->
  <xsl:apply-templates select="." mode="name">
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
  
  <!--Signal the start of processing of attributes. Default will output '(' -->
  <xsl:apply-templates select="." mode="begin-attributes">
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
  
  <!--Process attributes. Default will output name="value". -->
  <xsl:apply-templates select="@*">
    <xsl:with-param name="element" select="."/>
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
  
  <!--Signal the end of processing of attributes. Default will output ')' -->
  <xsl:apply-templates select="." mode="end-attributes">
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
  
  <!-- Process the elements value. Default will format the value of a leaf element so it is indented at next line -->
  <xsl:apply-templates select="." mode="value">
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
  
  <xsl:apply-templates select="." mode="line-break">
    <xsl:with-param name="level" select="$level"/>
  </xsl:apply-templates>
 
  <!-- Process children -->
  <xsl:apply-templates select="*">
    <xsl:with-param name="level" select="$level + 1"/>
  </xsl:apply-templates>
  
</xsl:template>

<!--Default handling of element names. -->
<xsl:template match="*"	mode="name">[<xsl:value-of select="local-name(.)"/></xsl:template>

<!--Default handling of start of attributes. -->
<xsl:template match="*" mode="begin-attributes">
  <xsl:if test="@*"><xsl:text> </xsl:text></xsl:if>
</xsl:template>

<!--Default handling of attributes. -->
<xsl:template match="@*">
  <xsl:value-of select="local-name(.)"/>="<xsl:value-of select="."/>"<xsl:text/>
  <xsl:if test="position() != last()">
    <xsl:text> </xsl:text>
  </xsl:if>
</xsl:template>

<!--Default handling of end of attributes. -->
<xsl:template match="*" mode="end-attributes">]</xsl:template>

<!--Default handling of element values. -->
<xsl:template match="*" mode="value">
  <xsl:param name="level"/>

  <!-- Only output value for leaves -->
  <xsl:if test="not(*)">
    <xsl:variable name="indent-str">
      <xsl:call-template name="str:dup" >
        <xsl:with-param name="input" select="$indent"/>
        <xsl:with-param name="count" select="$level"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:text>&#xa;</xsl:text>
    
    <xsl:value-of select="$indent-str"/>
    
    <xsl:call-template name="str:replace">
      <xsl:with-param name="input" select="."/>
      <xsl:with-param name="search-string" select=" '&#xa;' "/>
      <xsl:with-param name="replace-string" select="concat('&#xa;',$indent-str)"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<!--Default handling of indentation is to insert $level copies of $indent global param. -->
<xsl:template match="*" mode="indent">
  <xsl:param name="level"/>

  <xsl:call-template name="str:dup" >
    <xsl:with-param name="input" select="$indent"/>
    <xsl:with-param name="count" select="$level"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="line-break">
  <xsl:text>&#xa;</xsl:text>
</xsl:template>
  
</xsl:stylesheet>

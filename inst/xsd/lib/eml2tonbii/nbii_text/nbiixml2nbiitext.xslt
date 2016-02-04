<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="text.hierarchy.xslt"/>

<!--Ignore attributes -->
<xsl:template match="@*"/>
<xsl:template match="*" mode="begin-attributes"/>
<xsl:template match="*" mode="end-attributes"/>

<xsl:template match="*"	mode="name">
  <!--Display element loacl name-->
  <xsl:value-of select="local-name(.)"/>
  <!--Follow by a colon+space if a leaf -->
  <xsl:if test="not(*)">: </xsl:if>
</xsl:template>

<xsl:template match="*" mode="value">
  <xsl:if test="not(*)">
    <xsl:value-of select="."/>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>

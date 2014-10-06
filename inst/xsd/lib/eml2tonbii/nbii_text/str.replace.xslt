<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://www.ora.com/XSLTCookbook/namespaces/strings" extension-element-prefixes="str">

<xsl:template name="str:replace">
	<xsl:param name="input"/>
	<xsl:param name="search-string"/>
	<xsl:param name="replace-string"/>
	<xsl:choose>
		<!-- See if the input contains the search string -->
		<xsl:when test="contains($input,$search-string)">
		<!-- If so, then concatenate the substring before the search
		string to the replacement string and to the result of
		recursively applying this template to the remaining sub-string.
		-->
			<xsl:value-of select="substring-before($input,$search-string)"/>
			<xsl:value-of select="$replace-string"/>
			<xsl:call-template name="str:replace">
				<xsl:with-param name="input"
				select="substring-after($input,$search-string)"/>
				<xsl:with-param name="search-string" 
				select="$search-string"/>
				<xsl:with-param name="replace-string" 
					select="$replace-string"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- There are no more occurences of the search string so 
			just return the current input string -->
			<xsl:value-of select="$input"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>

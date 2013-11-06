<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:eml="eml://ecoinformatics.org/eml-2.1.1" version="1.0">
  <xsl:output method="xml" indent="yes"></xsl:output>
  <!--<xsl:strip-space elements="*"></xsl:strip-space>-->
  <xsl:param name="package-id" select="'newID'"/>
	
  <xsl:template match="/* ">
    <!--handle top level element-->
    <xsl:element name="eml:eml">   
      <xsl:for-each select="@*">
	   <xsl:choose>
	    <xsl:when test="namespace-uri()='http://www.w3.org/2001/XMLSchema-instance'">
        <xsl:attribute name="xsi:{local-name()}" namespace="{namespace-uri()}">
          <xsl:variable name="value" select="."></xsl:variable>
          <xsl:choose>
            <!--change eml210 to eml211 in attribute-->
            <xsl:when test="contains($value, &quot;eml://ecoinformatics.org/eml-2.1.0&quot;)">
              <xsl:variable name="first-replace">
                 <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$value"></xsl:with-param>
                    <xsl:with-param name="replace" select="'eml://ecoinformatics.org/eml-2.1.0'"></xsl:with-param>
                    <xsl:with-param name="with" select="'eml://ecoinformatics.org/eml-2.1.1'"></xsl:with-param>
                 </xsl:call-template>
			   </xsl:variable>
            </xsl:when>
			 <!--change eml210 to eml211 in attribute-->
            <xsl:when test="contains($value, 'eml://ecoinformatics.org/eml-2.1.0')">
			  <xsl:variable name="first-replace">
                 <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$value"></xsl:with-param>
                    <xsl:with-param name="replace" select="'eml://ecoinformatics.org/eml-2.1.0'"></xsl:with-param>
                    <xsl:with-param name="with" select="'eml://ecoinformatics.org/eml-2.1.1'"></xsl:with-param>
                 </xsl:call-template>
			   </xsl:variable>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."></xsl:value-of>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
            <xsl:choose>
               <xsl:when test="name()='packageId'">
				   <!-- handle package id: if there is no given packageid, it will use the old one. Otherwise, using the given id-->
			       <xsl:attribute name="{name()}" namespace="{namespace-uri()}">
					    <xsl:choose>
							<xsl:when test="$package-id='newID'">
								<xsl:value-of select="."/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$package-id"/>
							</xsl:otherwise>
						</xsl:choose>
			       </xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
				  <xsl:attribute name="{name()}" namespace="{namespace-uri()}">
                        <xsl:value-of select="."/>
                   </xsl:attribute> 
               </xsl:otherwise>
            </xsl:choose>
		</xsl:otherwise>
       </xsl:choose>
      </xsl:for-each>

      <xsl:for-each select="/*/*">
        <xsl:choose>
          <xsl:when test="name()='access'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>
          
          <xsl:when test="name()='dataset'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='citation'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='software'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='protocol'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='additionalMetadata'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

        </xsl:choose>
      </xsl:for-each>
    </xsl:element>
    <!--  
	 <xsl:message terminate="no">
		 <xsl:call-template name="output_message4_warn"/>
	  </xsl:message>
	  -->
  </xsl:template>

  <!-- handle make changes under main module (dataset, citation, protocol and software) -->
  <xsl:template mode="handle-elements-under-main-module" match="*">
    <xsl:for-each select="./*">
    	<xsl:apply-templates select="."></xsl:apply-templates>
    </xsl:for-each>
  </xsl:template>

  <!-- main template which will copy nodes recursively-->
  <xsl:template match="*">
    <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates></xsl:apply-templates>
    </xsl:element>
  </xsl:template>

  <!--Template to replace string "replace" by string "with" in given string "text"-->
  <xsl:template name="replace-string">
    <xsl:param name="text"></xsl:param>
    <xsl:param name="replace"></xsl:param>
    <xsl:param name="with"></xsl:param>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"></xsl:value-of>
        <xsl:value-of select="$with"></xsl:value-of>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text,$replace)"></xsl:with-param>
          <xsl:with-param name="replace" select="$replace"></xsl:with-param>
          <xsl:with-param name="with" select="$with"></xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
	
	<!-- get full path of given element-->
    <xsl:template match="node()" mode="get-full-path">
      <xsl:for-each select="ancestor-or-self::*">
        <xsl:text>/</xsl:text><xsl:value-of select="name()" />
      </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>

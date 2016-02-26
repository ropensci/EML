<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:output encoding="ISO-8859-1"/>
<xsl:strip-space elements="*"/>
           


<xsl:param name="packageName" select="'higgins.4109.2'"/>
<xsl:param name="packageDir" select="''"/>

<xsl:variable name="dsb6" select="document(concat($packageDir,$packageName))"/>

<xsl:template match="/">
  <!--<xsl:variable name="dsb6" select="/"/> -->
 <xsl:element name="package">
   <xsl:attribute name="id"><xsl:value-of select="$packageName"/></xsl:attribute>
  <xsl:call-template name="getEntities">
    <xsl:with-param name="datasetId" select="$packageName"/>
    <xsl:with-param name="dsb6" select="$dsb6"/>
  </xsl:call-template>

  </xsl:element> 
 
</xsl:template>


<xsl:template name="getPackageStructure">
  <xsl:param name="packageName"/>
  <xsl:variable name="dsb6" select="document($packageName)"/>
 <xsl:element name="package">
   <xsl:attribute name="id"><xsl:value-of select="$packageName"/></xsl:attribute>
  <xsl:call-template name="getEntities">
    <xsl:with-param name="datasetId" select="$packageName"/>
    <xsl:with-param name="dsb6" select="$dsb6"/>
  </xsl:call-template>
  
  </xsl:element> 
 
</xsl:template>

<xsl:template name="parseTriples">
  <xsl:param name="subjectVal"/>
  <xsl:param name="dsb6"/>
  <xsl:variable name="tripleList"  select="subjectVal"/>
  <xsl:element name="{$tripleList}">
    <xsl:for-each select="$dsb6/dataset/triple[./object=$subjectVal]">
     <xsl:if test="((last()>0) and (./subject!=./object))">
      <xsl:variable name="cur" select="./subject"/>
      <xsl:element name="{$cur}">
        <xsl:attribute name="rel">
          <xsl:value-of select="./relationship"/>
        </xsl:attribute>
         <xsl:call-template name="parseTriples">
          <xsl:with-param name="subjectVal" select="$cur"/>
       </xsl:call-template>
      </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:element>    
</xsl:template>  

<xsl:template name="getEntities">
  <xsl:param name="datasetId"/>
  <xsl:param name="dsb6"/>
    <xsl:call-template name="getAccess">
      <xsl:with-param name="dsb6" select="$dsb6"/>
    </xsl:call-template>
    <xsl:if test="$dsb6/dataset/triple/relationship[contains(.,'provides table-entity information for DATAFILE')]!=''">
     <xsl:element name="entities">
      <xsl:for-each select="$dsb6/dataset/triple/relationship[contains(.,'provides table-entity information for DATAFILE')]">
        <xsl:element name="entity">
          <xsl:attribute name="id">
            <xsl:value-of select="../subject"/>
          </xsl:attribute>
               <xsl:call-template name="getAttributeFor">
                  <xsl:with-param name="entity" select="../subject"/>
                  <xsl:with-param name="dsb6" select="$dsb6"/>
                </xsl:call-template>
               <xsl:call-template name="getPhysicalFor">
                  <xsl:with-param name="entity" select="../subject"/>
                  <xsl:with-param name="dsb6" select="$dsb6"/>
                </xsl:call-template>
               <xsl:call-template name="getDataFileFor">
                  <xsl:with-param name="entity" select="../subject"/>
                  <xsl:with-param name="dsb6" select="$dsb6"/>
                </xsl:call-template>
        </xsl:element>
      </xsl:for-each>
     </xsl:element>
    </xsl:if> 
    
    <xsl:if test="$dsb6/dataset/triple[contains(./relationship,'provides eml-project information for')]!=''">
      <xsl:call-template name="getProject">
        <xsl:with-param name="dsb6" select="$dsb6"/>
      </xsl:call-template>
    </xsl:if>
    
</xsl:template>  

<xsl:template name="getAttributeFor">
  <xsl:param name="entity"/>
  <xsl:param name="dsb6"/>
  <xsl:for-each select="$dsb6/dataset/triple[contains(./relationship,'provides eml-attribute information for Table')]">
  <xsl:if test="./object=$entity">
    <xsl:element name="attribute">
      <xsl:value-of select="./subject"/>
    </xsl:element>
  </xsl:if>
  </xsl:for-each>  
</xsl:template>

<xsl:template name="getPhysicalFor">
  <xsl:param name="entity"/>
  <xsl:param name="dsb6"/>
  <xsl:for-each select="$dsb6/dataset/triple[contains(./relationship,'provides eml-physical information for Table')]">
  <xsl:if test="./object=$entity">
    <xsl:element name="physical">
      <xsl:value-of select="./subject"/>
    </xsl:element>
  </xsl:if>
  </xsl:for-each>  
</xsl:template>

<xsl:template name="getDataFileFor">
  <xsl:param name="entity"/>
  <xsl:param name="dsb6"/>
  <xsl:for-each select="$dsb6/dataset/triple[contains(./relationship,'provides table-entity information for DATAFILE')]">
  <xsl:if test="./subject=$entity">
    <xsl:element name="dataFile">
      <xsl:value-of select="./object"/>
    </xsl:element>
  </xsl:if>
  </xsl:for-each>  
</xsl:template>

<xsl:template name="getAccess">
  <xsl:param name="dsb6"/>
  <xsl:element name="acl">
    <xsl:value-of select="$dsb6/dataset/triple[contains(./relationship,'access control rules for')]/subject[1]"/>
  </xsl:element>  
</xsl:template>

<xsl:template name="getProject">
  <xsl:param name="dsb6"/>
  <xsl:element name="project">
    <xsl:value-of select="$dsb6/dataset/triple[contains(./relationship,'provides eml-project information for')]/subject[1]"/>
  </xsl:element>  
</xsl:template>


</xsl:stylesheet>

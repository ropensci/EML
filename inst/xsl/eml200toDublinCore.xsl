<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:eml="eml://ecoinformatics.org/eml-2.0.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
>
  
  <xsl:output method="xml"
              omit-xml-declaration="yes"
              encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  
  <!-- create a variable that contains all the elements that have an 'id' 
       attribute. Do this so that the the search for such elements only has
       to be carried out once.
    -->     
  <xsl:variable name="ids" select="//*[@id!='']"/>
  <xsl:variable name="metacat-server">http://metacat.lternet.edu/metacat/metacat</xsl:variable>

  <xsl:template match="/">
    <oai_dc:dc xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
               xmlns:dc="http://purl.org/dc/elements/1.1/" 
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
               xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
    <xsl:text>&#xA;</xsl:text>
     
    <xsl:variable name="packageId">
	  <xsl:value-of select="eml:eml/@packageId" />
	</xsl:variable>

    <xsl:for-each select="eml:eml/dataset/title">
      <xsl:element name="dc:title">
        <xsl:call-template name="title"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:for-each select="eml:eml/dataset/creator">
      <xsl:element name="dc:creator">
        <xsl:call-template name="creator"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:for-each select="eml:eml/dataset/keywordSet/keyword">
      <xsl:element name="dc:subject">
        <xsl:call-template name="subject"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:if test="eml:eml/dataset/abstract">
      <xsl:element name="dc:description">
        <xsl:value-of select="eml:eml/dataset/abstract" />
      </xsl:element>
    </xsl:if>

    <xsl:if test="eml:eml/dataset/publisher">
      <xsl:element name="dc:publisher">
        <xsl:call-template name="publisher"></xsl:call-template>
      </xsl:element>
    </xsl:if>

    <xsl:for-each select="eml:eml/dataset//associatedParty">
      <xsl:element name="dc:contributor">
        <xsl:call-template name="contributor"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:if test="eml:eml/dataset/pubDate">
      <xsl:element name="dc:date">
        <xsl:value-of select="eml:eml/dataset/pubDate" />
      </xsl:element>
    </xsl:if>
    
    <xsl:call-template name="type"></xsl:call-template>

    <xsl:for-each select="eml:eml/dataset//physical/dataFormat">
      <xsl:element name="dc:format">
        <xsl:call-template name="format"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:element name="dc:identifier"><xsl:value-of select="$metacat-server" />/<xsl:value-of select="$packageId" />/xml</xsl:element>

    <xsl:element name="dc:identifier">
      <xsl:value-of select="$packageId"/>
    </xsl:element>

    <xsl:for-each select="eml:eml/dataset//geographicCoverage/geographicDescription">
      <xsl:element name="dc:coverage">
        <xsl:value-of select="."/>
      </xsl:element>
    </xsl:for-each>

    <xsl:for-each select="eml:eml/dataset//geographicCoverage/boundingCoordinates">
      <xsl:element name="dc:coverage">
        <xsl:call-template name="coverageBoundingCoordinates"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:for-each select="eml:eml/dataset//temporalCoverage">
      <xsl:element name="dc:coverage">
        <xsl:call-template name="coverageTemporal"></xsl:call-template>
      </xsl:element>
    </xsl:for-each>

    <xsl:if test="eml:eml/dataset/intellectualRights">
      <xsl:element name="dc:rights">
        <xsl:value-of select="eml:eml/dataset/intellectualRights"/>
      </xsl:element>
    </xsl:if>

    <xsl:text>&#xA;</xsl:text>
    </oai_dc:dc>
  </xsl:template>


  <xsl:template name="title">
    <xsl:value-of select="." />
  </xsl:template>


  <xsl:template name="creator">
    <xsl:choose>
      <xsl:when test="individualName/surName">
        <xsl:choose>
          <xsl:when test="individualName/givenName">
            <xsl:value-of select="individualName/givenName" />
            <xsl:text>&#x20;</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:value-of select="individualName/surName" />
      </xsl:when>
      <xsl:when test="organizationName">
        <xsl:value-of select="organizationName" />
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="subject">
    <xsl:value-of select="." />
  </xsl:template>


  <xsl:template name="contributor">
    <xsl:choose>
      <xsl:when test="individualName/surName">
        <xsl:choose>
          <xsl:when test="individualName/givenName">
            <xsl:value-of select="individualName/givenName" />
            <xsl:text>&#x20;</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:value-of select="individualName/surName" />
      </xsl:when>
      <xsl:when test="organizationName">
        <xsl:value-of select="organizationName" />
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="publisher">
    <xsl:choose>
      <xsl:when test="eml:eml/dataset/publisher/individualName/surName">
        <xsl:choose>
          <xsl:when test="eml:eml/dataset/publisher/individualName/givenName">
            <xsl:value-of select="eml:eml/dataset/publisher/individualName/givenName" />
            <xsl:text>&#x20;</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:value-of select="eml:eml/dataset/publisher/individualName/surName" />
      </xsl:when>
      <xsl:when test="eml:eml/dataset/publisher/organizationName">
        <xsl:value-of select="eml:eml/dataset/publisher/organizationName" />
      </xsl:when>
      <xsl:when test="eml:eml/dataset/publisher/positionName">
        <xsl:value-of select="eml:eml/dataset/publisher/positionName" />
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="type">
    <xsl:element name="dc:type">
      <xsl:choose>
        <xsl:when test="eml:eml/dataset">dataset</xsl:when>
        <xsl:when test="eml:eml/citation">citation</xsl:when>
        <xsl:when test="eml:eml/software">software</xsl:when>
        <xsl:when test="eml:eml/protocol">protocol</xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template name="format">
    <xsl:choose>
      <xsl:when test="textFormat">text/plain</xsl:when>
      <xsl:when test="externallyDefinedFormat"><xsl:value-of select="formatName" /></xsl:when>
      <xsl:when test="binaryRasterFormat">binary raster</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="coverageBoundingCoordinates">
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="westBoundingCoordinate" /> W
    <xsl:value-of select="eastBoundingCoordinate" /> E
    <xsl:value-of select="northBoundingCoordinate" /> N
    <xsl:value-of select="southBoundingCoordinate" /> S
  </xsl:template>

  <xsl:template name="coverageTemporal">
    <xsl:choose>
      <xsl:when test="singleDateTime">
        <xsl:value-of select="singleDateTime/calendarDate" />
      </xsl:when>
      <xsl:when test="rangeOfDates">
        <xsl:value-of select="rangeOfDates/beginDate/calendarDate" />
        <xsl:text> to </xsl:text>
        <xsl:value-of select="rangeOfDates/endDate/calendarDate" />
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

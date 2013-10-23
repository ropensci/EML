<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:eml="eml://ecoinformatics.org/eml-2.1.1"  
xmlns:gmd="http://www.isotc211.org/2005/gmd"
xmlns:gmx="http://www.isotc211.org/2005/gmx" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:srv="http://www.isotc211.org/2005/srv" 
xmlns:gco="http://www.isotc211.org/2005/gco"
xmlns:gts="http://www.isotc211.org/2005/gts" 
xmlns:gml="http://www.opengis.net/gml"
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect" extension-element-prefixes="redirect">
	<xsl:output method="xml"/>
	<xsl:template match="eml:eml">
	
	

			
	 <redirect:write select="concat('ISO19139', '.xml')">
	 
<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml"
    xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">
		
	<gmd:fileIdentifier>
        <gco:CharacterString>
			<xsl:value-of select="dataset/alternateIdentifier"/>
		</gco:CharacterString>
    </gmd:fileIdentifier>
	
	<gmd:language>
        <gco:CharacterString>
			<xsl:value-of select="additionalMetadata/metadata/metadataLanguage"/>
		</gco:CharacterString>
    </gmd:language>
	
    <gmd:characterSet>
        <gmd:MD_CharacterSetCode
            codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode"
            codeListValue="utf8" codeSpace="ISOTC211/19115">utf8</gmd:MD_CharacterSetCode>
    </gmd:characterSet>				

    <gmd:contact>	
		<xsl:apply-templates select="dataset/metadataProvider"/>
	</gmd:contact>	
	
	<gmd:dateStamp>
<!--	this is resource pub date just used for testing -->
        <gco:Date><xsl:value-of select="dataset/pubDate"/></gco:Date>
    </gmd:dateStamp>
	
    <gmd:metadataStandardName>
        <gco:CharacterString>ISO 19115</gco:CharacterString>
    </gmd:metadataStandardName>
	
    <gmd:metadataStandardVersion>
        <gco:CharacterString>2003</gco:CharacterString>
    </gmd:metadataStandardVersion>
	
	 <gmd:referenceSystemInfo>
        <gmd:MD_ReferenceSystem>
            <gmd:referenceSystemIdentifier>
                <gmd:RS_Identifier>
                    <gmd:code>
                        <gco:CharacterString>World Geodetic System 84</gco:CharacterString>
                    </gmd:code>
                </gmd:RS_Identifier>
            </gmd:referenceSystemIdentifier>
        </gmd:MD_ReferenceSystem>
    </gmd:referenceSystemInfo>
	
	 <gmd:identificationInfo>
	   <gmd:MD_DataIdentification>
	          <gmd:citation>
                <gmd:CI_Citation>
                    <gmd:title>
                        <gco:CharacterString><xsl:value-of select="dataset/title[@xml:lang='en']"/></gco:CharacterString>
                    </gmd:title>
                    <gmd:date>
                        <gmd:CI_Date>
                            <gmd:date>
                                <gco:Date><xsl:value-of select="dataset/pubDate"/></gco:Date>
                            </gmd:date>
                            <gmd:dateType>
                                <gmd:CI_DateTypeCode
                                    codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode"
                                    codeListValue="revision" codeSpace="ISOTC211/19115"
                                >revision</gmd:CI_DateTypeCode>
                            </gmd:dateType>
                        </gmd:CI_Date>
                    </gmd:date>
					
				<gmd:citedResponsibleParty>
					<gmd:CI_ResponsibleParty>
						<xsl:apply-templates select="dataset/associatedParty"/>
					</gmd:CI_ResponsibleParty>
				</gmd:citedResponsibleParty>

				
                </gmd:CI_Citation>
            </gmd:citation>
			
	<gmd:abstract>
		<gco:CharacterString><xsl:value-of select="dataset/abstract/para"/></gco:CharacterString>
	</gmd:abstract>		
			
	<gmd:pointOfContact>
		<xsl:apply-templates select="dataset/creator"/>
	</gmd:pointOfContact>
	
	<!-- 
	<gmd:spatialRepresentationType>
		<gmd:MD_SpatialRepresentationTypeCode>zzz</gmd:MD_SpatialRepresentationTypeCode>
	</gmd:spatialRepresentationType>
	<gmd:spatialResolution>
                <gmd:MD_Resolution>
                    <gmd:equivalentScale>
                        <gmd:MD_RepresentativeFraction>
                            <gmd:denominator>
                                <gco:Integer>zzz</gco:Integer>
                            </gmd:denominator>
                        </gmd:MD_RepresentativeFraction>
                    </gmd:equivalentScale>
                </gmd:MD_Resolution>
	</gmd:spatialResolution>
	
	-->
	

	<gmd:resourceConstraints>
		<gmd:MD_LegalConstraints>
		<gmd:accessConstraints>
			<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>
		</gmd:accessConstraints>
		<gmd:otherConstraints>
		<gco:CharacterString><xsl:value-of select="dataset/intellectualRights"/></gco:CharacterString>
		</gmd:otherConstraints>
		</gmd:MD_LegalConstraints>
	</gmd:resourceConstraints>
			
	<gmd:language>
		<gco:CharacterString><xsl:value-of select="dataset/language"/></gco:CharacterString>
	</gmd:language>
	
	<gmd:characterSet>
		<gmd:MD_CharacterSetCode
                    codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode"
                    codeListValue="utf8" codeSpace="ISOTC211/19115">utf8</gmd:MD_CharacterSetCode>
	</gmd:characterSet>
	
	<gmd:topicCategory>
	<xsl:for-each select="dataset/keywordSet">
		<xsl:for-each select="keyword">
                <gmd:MD_TopicCategoryCode><xsl:value-of select="."/></gmd:MD_TopicCategoryCode>
		</xsl:for-each>
	</xsl:for-each>
	</gmd:topicCategory>
	
	<gmd:extent>
		<gmd:EX_Extent>
		<xsl:for-each select="dataset/coverage/geographicCoverage">
			<xsl:apply-templates select="."/>   
		</xsl:for-each>
		</gmd:EX_Extent>
	</gmd:extent>		
	
	<gmd:extent>
		<gmd:EX_Extent>
		<xsl:for-each select="dataset/coverage/temporalCoverage">
			<xsl:apply-templates select="."/>   
		</xsl:for-each>
		</gmd:EX_Extent>
	</gmd:extent>		
	
	
	</gmd:MD_DataIdentification>
	</gmd:identificationInfo>
	 
	
    <gmd:distributionInfo>
        <gmd:MD_Distribution>
            <gmd:distributionFormat>
                <gmd:MD_Format>
                    <gmd:name>
                        <gco:CharacterString><xsl:value-of select="additionalMetadata/metadata/physical/dataFormat/externallyDefinedFormat/formatName"/></gco:CharacterString>
                    </gmd:name>
                    <gmd:version>
                        <gco:CharacterString><xsl:value-of select="additionalMetadata/metadata/physical/dataFormat/externallyDefinedFormat/formatVersion"/></gco:CharacterString>
                    </gmd:version>
                </gmd:MD_Format>
            </gmd:distributionFormat>
            <gmd:transferOptions>
                <gmd:MD_DigitalTransferOptions>
                    <gmd:transferSize>
                        <gco:Real>zzz</gco:Real>
                    </gmd:transferSize>
                    <gmd:onLine>
                        <gmd:CI_OnlineResource>
                            <gmd:linkage>
                                <gmd:URL><xsl:value-of select="additionalMetadata/metadata/physical/distribution/online/url"/></gmd:URL>
                            </gmd:linkage>
                            <gmd:protocol>
                                <gco:CharacterString>zzz</gco:CharacterString>
                            </gmd:protocol>
                            <gmd:description>
                                <gco:CharacterString>zzz</gco:CharacterString>
                            </gmd:description>
                            <gmd:function>
                                <gmd:CI_OnLineFunctionCode
                                    codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode"
                                    codeListValue="download" codeSpace="ISOTC211/19115"
                                    >download</gmd:CI_OnLineFunctionCode>
                            </gmd:function>
                        </gmd:CI_OnlineResource>
                    </gmd:onLine>
                </gmd:MD_DigitalTransferOptions>
            </gmd:transferOptions>
        </gmd:MD_Distribution>
    </gmd:distributionInfo>

	  <gmd:dataQualityInfo>
        <gmd:DQ_DataQuality>
            <gmd:scope>
                <gmd:DQ_Scope>
                    <gmd:level>
                        <gmd:MD_ScopeCode
                            codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ScopeCode"
                            codeListValue="dataset">dataset</gmd:MD_ScopeCode>
                    </gmd:level>
                </gmd:DQ_Scope>
            </gmd:scope>
            <gmd:lineage>
                <gmd:LI_Lineage>
                    <gmd:statement>
                        <gco:CharacterString>
						<xsl:apply-templates select="dataset/methods"/>"
						</gco:CharacterString>
                    </gmd:statement>
                </gmd:LI_Lineage>
            </gmd:lineage>
        </gmd:DQ_DataQuality>
    </gmd:dataQualityInfo>				
			
	</gmd:MD_Metadata>
		</redirect:write>
</xsl:template>

<xsl:template match="creator">
     <gmd:CI_ResponsibleParty>	 
	<xsl:apply-templates select="individualName" mode="name"/>   
		<gmd:contactInfo>
			<gmd:CI_Contact>
			<xsl:apply-templates select="phone"/>               
			<xsl:apply-templates select="address"/>   
			<xsl:apply-templates select="onlineUrl"/>   
			</gmd:CI_Contact>
            </gmd:contactInfo>
			
            <gmd:role>
                <gmd:CI_RoleCode
                    codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                    codeListValue="custodian" codeSpace="ISOTC211/19115">custodian</gmd:CI_RoleCode>
            </gmd:role>
        </gmd:CI_ResponsibleParty>
</xsl:template>

<xsl:template match="metadataProvider">
     <gmd:CI_ResponsibleParty>	 
	<xsl:apply-templates select="individualName" mode="name"/>   
		<gmd:contactInfo>
			<gmd:CI_Contact>
			<xsl:apply-templates select="phone"/>               
			<xsl:apply-templates select="address"/>   
			<xsl:apply-templates select="onlineUrl"/>   
			</gmd:CI_Contact>
            </gmd:contactInfo>
			
            <gmd:role>
                <gmd:CI_RoleCode
                    codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode"
                    codeListValue="author" codeSpace="ISOTC211/19115">author</gmd:CI_RoleCode>
            </gmd:role>
        </gmd:CI_ResponsibleParty>
</xsl:template>

<xsl:template match="associatedParty">
     <gmd:CI_ResponsibleParty>	 
	<xsl:apply-templates select="individualName" mode="name"/>   
		<gmd:contactInfo>
			<gmd:CI_Contact>
			<xsl:apply-templates select="phone"/>               
			<xsl:apply-templates select="address"/>   
			<xsl:apply-templates select="onlineUrl"/>   
			</gmd:CI_Contact>
            </gmd:contactInfo>
			
            <gmd:role>
                <gmd:CI_RoleCode
                    codeList="" codeListValue="" codeSpace=""><xsl:value-of select="role"/></gmd:CI_RoleCode>
            </gmd:role>
        </gmd:CI_ResponsibleParty>
</xsl:template>



<xsl:template match="individualName" mode="name">
	<gmd:individualName>
			<givenName>
                <gco:CharacterString><xsl:value-of select="givenName"/></gco:CharacterString>
				</givenName>
				<surName>
                <gco:CharacterString><xsl:value-of select="surName"/></gco:CharacterString>
				</surName>
            </gmd:individualName>
</xsl:template>


<xsl:template match="phone">
<gmd:phone>
                        <gmd:CI_Telephone>
                            <gmd:voice>
                                <gco:CharacterString><xsl:value-of select="."/></gco:CharacterString>
                            </gmd:voice>
                        </gmd:CI_Telephone>
	</gmd:phone>
</xsl:template>


<xsl:template match="address"> 
 <gmd:address>
                        <gmd:CI_Address>
                            <gmd:deliveryPoint>
                                <gco:CharacterString><xsl:value-of select="deliveryPoint"/>
                                </gco:CharacterString>
                            </gmd:deliveryPoint>
                            <gmd:city>
                                <gco:CharacterString><xsl:value-of select="city"/></gco:CharacterString>
                            </gmd:city>
                            <gmd:administrativeArea>
                                <gco:CharacterString><xsl:value-of select="administrativeArea"/></gco:CharacterString>
                            </gmd:administrativeArea>
                            <gmd:postalCode>
                                <gco:CharacterString><xsl:value-of select="postalCode"/></gco:CharacterString>
                            </gmd:postalCode>
                            <gmd:country>
                                <gco:CharacterString><xsl:value-of select="country"/></gco:CharacterString>
                            </gmd:country>
                            <gmd:electronicMailAddress>
                                <gco:CharacterString><xsl:value-of select="../electronicMailAddress"/></gco:CharacterString>
                            </gmd:electronicMailAddress>
                        </gmd:CI_Address>
                    </gmd:address>
</xsl:template>

<xsl:template match="onlineUrl">
<gmd:onlineResource>
                        <gmd:CI_OnlineResource>
                            <gmd:linkage>
                                <gmd:URL><xsl:value-of select="."/></gmd:URL>
                            </gmd:linkage>
                        </gmd:CI_OnlineResource>
</gmd:onlineResource>
</xsl:template>

<xsl:template match="geographicCoverage">
 <gmd:geographicElement>
                        <gmd:EX_GeographicBoundingBox>
                            <gmd:westBoundLongitude>
                                <gco:Decimal><xsl:value-of select="boundingCoordinates/westBoundingCoordinate"/></gco:Decimal>
                            </gmd:westBoundLongitude>
                            <gmd:eastBoundLongitude>
                                <gco:Decimal><xsl:value-of select="boundingCoordinates/eastBoundingCoordinate"/></gco:Decimal>
                            </gmd:eastBoundLongitude>
                            <gmd:southBoundLatitude>
                                <gco:Decimal><xsl:value-of select="boundingCoordinates/southBoundingCoordinate"/></gco:Decimal>
                            </gmd:southBoundLatitude>
                            <gmd:northBoundLatitude>
                                <gco:Decimal><xsl:value-of select="boundingCoordinates/northBoundingCoordinate"/></gco:Decimal>
                            </gmd:northBoundLatitude>
                        </gmd:EX_GeographicBoundingBox>
                    </gmd:geographicElement>
</xsl:template>

<xsl:template match="temporalCoverage">
<!--  check on how to handle single dates in ISO -->
                    <gmd:temporalElement>
                        <gmd:EX_TemporalExtent>
                            <gmd:extent>
                                <gml:TimePeriod>
                                    <gml:begin>
                                        <gml:TimeInstant>
                                            <gml:timePosition><xsl:value-of select="rangeOfDates/beginDate/calendarDate"/></gml:timePosition>
                                        </gml:TimeInstant>
                                    </gml:begin>
                                    <gml:end>
                                        <gml:TimeInstant>
                                            <gml:timePosition><xsl:value-of select="rangeOfDates/endDate/calendarDate"/></gml:timePosition>
                                        </gml:TimeInstant>
                                    </gml:end>
                                </gml:TimePeriod>
                            </gmd:extent>
                        </gmd:EX_TemporalExtent>
                    </gmd:temporalElement>
</xsl:template>

<xsl:template match="methods">
	<xsl:if test="normalize-space(methodStep/description/para)">
							<xsl:text>Methods: </xsl:text>
							<xsl:value-of select="methodStep/description/para"/>
							<xsl:text>  | </xsl:text>
	</xsl:if>

	<xsl:if test="normalize-space(sampling/studyExtent/description)">
							<xsl:text>Sampling area: </xsl:text>
							<xsl:value-of select="sampling/studyExtent/description"/>
							<xsl:text>  | </xsl:text>
	</xsl:if>
	
	<xsl:if test="normalize-space(sampling/samplingDescription/para)">
							<xsl:text>Sampling procedure: </xsl:text>
							<xsl:value-of select="sampling/samplingDescription/para"/>
							<xsl:text>  | </xsl:text>
	</xsl:if>

	<xsl:if test="normalize-space(qualityControl/description/para)">
							<xsl:text>Quality control: </xsl:text>
							<xsl:value-of select="qualityControl/description/para"/>
							<xsl:text>  | </xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>

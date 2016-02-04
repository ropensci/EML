<?xml version="1.0" encoding="UTF-8"?>

<!-- 
        File: esri2eml.xsl
        Author: Inigo San Gil
        Date: 2007/02/26
        Revision: 1.2

   ** Log of Changes: Inigo San Gil, May 2006
   ** header changes: root element, new attributes, including migration to EML 2.0.1
   * TODO data format checker. (december 2003 to 2003-12-01, etc)
   ** Keywords: Thesaurus placed after regular, custom. keywords (was wrong order)
   ** Temporal Coverage: Three prong error:1/ ESRI XPath fixed. 2/ Swapped location with Geogrpahic Coverage element. 3/ Wrong Xpath for EML/.
   ** <geographicDescrition> mandatory in EML 2.0.1, kludge placed. (place keywords, or abstract)
   ** Contact info - stylesheet pushed an empty individualName tag.
   ** Publisher info encroached between contact info, fixed, placed afterwards.
   **: geography type, variable construct (XSL intepreter dependent) replaced by a Choose construct.
 
  * TODO: attributes lacking sufficient metadata are parsed and placed with incomlete fields (no <measurementScale>, since FGDC does not enforce corresponding attribute section: Workaround: when no attribute domain (measurementScale) is specified, default to textdomain with attribute definition value 
  * TODO: not enough types for horizontal coordinate system names? suggest more to eml-dev? lax field?
  ** make accuracy optional  Workaround: call to accuracy templates made optional by placing test of content in ESRI original format.
 
  ** Intrinsic problem: geometry and geometricObjectCount have cardinality one, while in ESRI we have many elements of type
metadata/spdoinfo/ptvctinf/sdtsterm/ptvctcnt and metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype. Now grab only first..
 
    Log of Changes: February 2007
       A couple of bugs and structure addition to accomodate a perl companion to add proper "best practices compliant" packageIds.
       -fixed optional accuracy 
	   -expanded keywordSet collection
	   -fixed access element -whenever possible, make site owned- and always public read.
	   -added intellectual rights, if those exist
	   -expanded collection of distribution info
	   -expanded "coverage" and "publisher" and "pubPLace"
        set up cases for a perl script companion (esri2emlSupport.pl). additional fields in raw esri field should be innocous enough so the stylesheet 
		produces eml without this perl companion code 
	   -added maintenance section
       -started adding content checks to avoid ending up with non-valid EML (checks for pubDate, abstract, additionalinfo, purpose, maintenance, distribution, intellectual rights, contact, publisher:: many MORE would be advisable)
       -additionalInfo is optional, may need to check before placing this EML element whether at least one of the fields therein is populated in BDP, a if (  this OR this OR this OR..) typoe of statement 
    -perl introduces a proper packageId and an access tag as for "provenance". 
  -->
<!--
       '$RCSfile: esri2eml.xsl,v $'
        '$Author: jones $'
          '$Date: 2007-03-01 17:03:20 $'
      '$Revision: 1.2 $'

    Copyright: 2003 Arizona State University
    
    This material is based upon work supported by the National Science Foundation 
    under Grant No. 9983132 and 0219310. Any opinions, findings and conclusions or recommendation 
    expressed in this material are those of the author(s) and do not necessarily 
    reflect the views of the National Science Foundation (NSF).  
                  
    For Details: http://ces.asu.edu/bdi

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eml="eml://ecoinformatics.org/eml-2.0.1" xmlns:stmml="http://www.xml-cml.org/schema/stmml" xmlns:sw="eml://ecoinformatics.org/software-2.0.1" xmlns:cit="eml://ecoinformatics.org/literature-2.0.1" xmlns:ds="eml://ecoinformatics.org/dataset-2.0.1" xmlns:prot="eml://ecoinformatics.org/protocol-2.0.1" xmlns:doc="eml://ecoinformatics.org/documentation-2.0.1" xmlns:res="eml://ecoinformatics.org/resource-2.0.1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
<!--xsl:stylesheet version="1.0" xml:lang="en" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"-->
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/">
	      <xsl:element name="eml:eml">
		<!--xsl:element name="eml:eml" namespace="eml://ecoinformatics.org/eml-2.0.1"-->
			<!--xsl:attribute name="xmlns:xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:attribute-->
			<xsl:attribute name="xsi:schemaLocation">eml://ecoinformatics.org/eml-2.0.1 C:/eml-2.0.1/eml.xsd</xsl:attribute>
			<xsl:attribute name="packageId">
				<xsl:choose>
					<xsl:when test="metadata/packageId">
						<!-- an ad-hoc packageID was added a posteriori -->
						<xsl:value-of select="metadata/packageId"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="metadata/Esri/MetaID"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="system">ESRI MetaID</xsl:attribute>
			<dataset>
				<xsl:attribute name="id">
					<xsl:value-of select="metadata/Esri/MetaID"/>
				</xsl:attribute>
				<xsl:attribute name="system">ESRI MetaID</xsl:attribute>
				<alternateIdentifier>
					<xsl:value-of select="metadata/Esri/MetaID"/>
				</alternateIdentifier>
	
				<xsl:if test="metadata/packageId">
					<alternateIdentifier>
						<xsl:value-of select="metadata/packageId"/>
					    <!-- an ad-hoc packageID was added a posteriori -->
					</alternateIdentifier>
				</xsl:if>		
				<xsl:for-each select="metadata/idinfo/citation/citeinfo/ftname">
					<shortName>
						<xsl:value-of select="."/>
					</shortName>
				</xsl:for-each>
				
				<xsl:for-each select="metadata/idinfo/citation/citeinfo/title">
					<title>
						<xsl:value-of select="."/>
					</title>
				</xsl:for-each>
				<xsl:for-each select="/metadata/idinfo/citation/citeinfo/origin">
					<xsl:element name="creator">
						<individualName>
							<surName>
								<xsl:value-of select="."/>
							</surName>
						</individualName>
					</xsl:element>
				</xsl:for-each>
				<xsl:if test="metadata/idinfo/citation/citeinfo/pubdate!=''">
					<pubDate>
						<xsl:value-of select="."/>
					</pubDate>
				</xsl:if>
				<xsl:if test="metadata/idinfo/descript/langdata">
					<language>
						<xsl:value-of select="."/>
					</language>
				</xsl:if>
				<xsl:if test="metadata/idinfo/citation/citeinfo/serinfo/sername">
					<series>
						<xsl:value-of select="."/>
					</series>
				</xsl:if>

				<xsl:if test="metadata/idinfo/descript/abstract">
					<abstract>
						<para>
							<literalLayout>
								<xsl:value-of select="."/>
							</literalLayout>
						</para>
					</abstract>
				</xsl:if>
				<xsl:if test="metadata/idinfo/keywords/theme/themekey!=''"><!-- even though these keywords are mandatory, ill check for content, anyway -->
					<keywordSet>
						<xsl:for-each select="metadata/idinfo/keywords/theme/themekey"><!-- theme kywds are mandatory, but the rest are optional, we'll put an if clause before print -->
							<keyword>
								<xsl:attribute name="keywordType">
									<xsl:value-of select="'theme'"/>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</keyword>
						</xsl:for-each>
						<xsl:if test="metadata/dataqual/lineage/method/methodid/methkt!=''"><!-- are there methodology keywords?-->
							<xsl:for-each select="metadata/dataqual/lineage/method/methodid/methkt">
								<keyword>
									<xsl:attribute name="keywordType">
										<xsl:value-of select="'theme'"/>
									</xsl:attribute>
									<xsl:value-of select="dataqual/lineage/method/methodid/methkt"/>
								</keyword>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/dataqual/lineage/method/methodid/methkey">
							<xsl:for-each select="metadata/dataqual/lineage/method/methodid/methkey">
								<keyword>
									<xsl:attribute name="keywordType">
										<xsl:value-of select="'theme'"/>
									</xsl:attribute>
									<xsl:value-of select="dataqual/lineage/method/methodid/methkey"/>
								</keyword>					
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/idinfo/keywords/place/placekey!=''">
							<xsl:for-each select="metadata/idinfo/keywords/place/placekey">
								<keyword>
									<xsl:attribute name="keywordType">
										<xsl:value-of select="'place'"/>
									</xsl:attribute>
									<xsl:value-of select="."/>
								</keyword>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/idinfo/keywords/stratum/stratkey!=''">
							<xsl:for-each select="metadata/idinfo/keywords/stratum/stratkey">
								<keyword>
									<xsl:attribute name="keywordType">
										<xsl:value-of select="'stratum'"/>
									</xsl:attribute>
									<xsl:value-of select="."/>
								</keyword>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/idinfo/keywords/temporal/tempkey!=''">
							<xsl:for-each select="metadata/idinfo/keywords/temporal/tempkey">
								<keyword>
									<xsl:attribute name="keywordType">
										<xsl:value-of select="'temporal'"/>
									</xsl:attribute>
									<xsl:value-of select="."/>
								</keyword>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/idinfo/taxonomy/keywtax/taxonkey!=''"><!-- this is mandatory if applicable, im adding a check before attempting to force output -->
							<xsl:for-each select="metadata/idinfo/taxonomy/keywtax/taxonkey"><!--sometimes, there are malformed FGDC, missing some intermidiate tags-->
								<keyword>
									<xsl:attribute name="keywordType">
										<xsl:value-of select="'taxonomic'"/>
									</xsl:attribute>
									<xsl:value-of select="."/>
								</keyword>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/idinfo/keywords/theme">
							<xsl:for-each select="metadata/idinfo/keywords/theme">
								<keywordThesaurus>
									<xsl:value-of select="./themekt"/>
								</keywordThesaurus>
							</xsl:for-each>
						</xsl:if>
					</keywordSet>
				</xsl:if>			
				<xsl:if test="(metadata/idinfo/citation/citeinfo/edition!='') or (metadata/idinfo/citation/citeinfo/geoform!='') or (metadata/idinfo/citation/citeinfo/serinfo/sername!='') or (metadata/idinfo/citation/citeinfo/othercit!='') or (metadata/idinfo/descript/supplinf!='') or (metadata/idinfo/browse/browsen!='') ">
					<additionalInfo>
						<xsl:if test="metadata/idinfo/citation/citeinfo/edition!=''">
							<!--edition optional -->
							<section>
								<title>
									<xsl:value-of select="'Edition: Version of title'"/>
								</title>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/citation/citeinfo/edition"/>
									</literalLayout>
								</para>
							</section>
						</xsl:if>
						<xsl:if test="metadata/idinfo/citation/citeinfo/geoform!=''">
							<!-- geoform optional -->
							<section>
								<title>
									<xsl:value-of select="'Data presentation form'"/>
								</title>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/citation/citeinfo/geoform"/>
									</literalLayout>
								</para>
							</section>
						</xsl:if>
						<xsl:if test="metadata/idinfo/citation/citeinfo/serinfo/sername!=''">
							<section>
								<title>
									<xsl:value-of select="'Series publication Identification and issue'"/>
								</title>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/citation/citeinfo/serinfo/sername"/>
									</literalLayout>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/citation/citeinfo/serinfo/issue"/>
									</literalLayout>
								</para>
							</section>
						</xsl:if>
						<xsl:if test="metadata/idinfo/citation/citeinfo/othercit!=''">
							<section>
								<title>
									<xsl:value-of select="'Other citation details'"/>
								</title>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/citation/citeinfo/othercit"/>
									</literalLayout>
								</para>
							</section>
						</xsl:if>
						<xsl:if test="metadata/idinfo/descript/supplinf!=''">
							<section>
								<title>
									<xsl:value-of select="'Other descriptive Information about the data set'"/>
								</title>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/descript/supplinf"/>
									</literalLayout>
								</para>
							</section>
						</xsl:if>
						<xsl:if test="metadata/idinfo/browse/browsen!=''">
							<section>
								<title>
									<xsl:value-of select="'browse'"/>
								</title>
								<xsl:for-each select="metadata/idinfo/browse">
									<para>
										<literalLayout>
											<xsl:value-of select="browsen"/>
										</literalLayout>
									</para>
									<para>
										<literalLayout>
											<xsl:value-of select="browsed"/>
										</literalLayout>
									</para>
									<para>
										<literalLayout>
											<xsl:value-of select="browset"/>
										</literalLayout>
									</para>
								</xsl:for-each>
							</section>
						</xsl:if>
					</additionalInfo>
				</xsl:if>
					
				<xsl:if test="metadata/idinfo/accconst!=''">
					<intellectualRights>
						<section>
							<title>
								<xsl:value-of select="'Access constraints'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="metadata/idinfo/accconst"/><!-- mandatory in BDP, only once per doc -->
								</literalLayout>
							</para>
						</section>
						<section>
							<title>
								<xsl:value-of select="'Use Constraints'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="metadata/idinfo/useconst"/>
								</literalLayout>
							</para>
						</section>
						<xsl:if test="metadata/idinfo/secinfo/secsys!=''"><!-- optional in BDP, check first -->
							<section>
								<title>
									<xsl:value-of select="'Security Classification'"/>
								</title>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/secinfo/secsys"/>
									</literalLayout>
								</para>
								<para>
									<literalLayout>
										<xsl:value-of select="metadata/idinfo/secinfo/secclass"/>
									</literalLayout>
								</para>
									<para>
										<literalLayout>
											<xsl:value-of select="metadata/idinfo/secinfo/sechandl"/>
										</literalLayout>
								</para>
							</section>
						</xsl:if>
						<xsl:if test="metadata/distinfo/disliab!=''">
							<section>
								<title>
									<xsl:value-of select="'Distribution Liability'"/>
								</title>
								<para>
									<xsl:for-each select="metadata/distinfo">
										<literalLayout>
											<xsl:value-of select="distliab"/>
										</literalLayout>
									</xsl:for-each>
								</para>
							</section>
						</xsl:if>
					</intellectualRights>
				</xsl:if>
				
				<xsl:choose>
					<xsl:when test="/metadata/idinfo/citation/citeinfo[starts-with(onlink,'Server')]">
						<distribution>
							<online>
								<connection>
									<connectionDefinition id="sde.connection1">
										<schemeName system="http://ces.asu.edu/eml/ces/connectionDictionary.xml">Spatial Database Engine</schemeName>
										<description>Connection Definition for ESRI Spatial Database Engine.</description>
										<xsl:for-each select="/metadata/idinfo/citation/citeinfo/onlink">
											<parameterDefinition>
												<name>host</name>
												<description>Host name or ip number of the computer running the service.</description>
												<defaultValue>
													<xsl:value-of select="substring-before(substring-after(.,'Server='),';')"/>
												</defaultValue>
											</parameterDefinition>
											<parameterDefinition>
												<name>port</name>
												<description>The port number where the service is listening.</description>
												<defaultValue>
													<xsl:value-of select="substring-before(substring-after(.,'port:'),';')"/>
												</defaultValue>
											</parameterDefinition>
											<parameterDefinition>
												<name>catalog</name>
												<description>The name of the database or catalog.</description>
												<defaultValue>
													<xsl:value-of select="substring-before(substring-after(.,'Database='),';')"/>
												</defaultValue>
											</parameterDefinition>
											<parameterDefinition>
												<name>owner</name>
												<description>The owner or schema for the object</description>
											</parameterDefinition>
											<parameterDefinition>
												<name>object</name>
												<description>The name of the data object.</description>
											</parameterDefinition>

											<parameterDefinition>
												<name>shapeColumn</name>
												<description>The name of table column containing shape id.</description>
												<defaultValue>
													<xsl:value-of select="substring-before(substring-after(.,'User='),';')"/>
												</defaultValue>
											</parameterDefinition>
										</xsl:for-each>
									</connectionDefinition>
								</connection>
							</online>
						</distribution>
					</xsl:when>
					<xsl:when test="metadata/idinfo/citation/citeinfo/onlink!='' ">
						<xsl:for-each select="metadata/idinfo/citation/citeinfo/onlink">
							<distribution>
								<online>
									<url>
										<xsl:value-of select="."/>
									</url>
								</online>
							</distribution>
						</xsl:for-each>
						<xsl:if test="metadata/distinfo/stdorder/digform/digtopt/onlinopt/computer/networka/networkr!=''">
							<xsl:for-each select="metadata/distinfo/stdorder/digform/digtopt/onlinopt/computer/networka/networkr">
								<distribution>
									<online>
										<url>
											<xsl:value-of select="."/>
										</url>
									</online>
								</distribution>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="metadata/distinfo/stdorder/digform/digtopt/offoptn/offmedia!=''">
							<xsl:for-each select="metadata/distinfo/stdorder/digform/digtopt/offoptn">
								<distribution>
									<offline>
										<mediumName>
											<xsl:value-of select="offmedia"/>
										</mediumName>
										<xsl:if test="reccap/recden!=''">
											<mediumDensity>
												<xsl:value-of select="reccap/recden"/>
											</mediumDensity>
										</xsl:if>
										<xsl:if test="reccap/recdenu!=''">
											<mediumDensityUnits>
												<xsl:value-of select="reccap/recdenu"/>
											</mediumDensityUnits>
										</xsl:if>
										<xsl:if test="recfmt!=''">
											<mediumFormat>
												<xsl:value-of select="recfmt"/>
											</mediumFormat>
										</xsl:if>
										<xsl:if test="compat!=''">
											<mediumNote>
												<xsl:value-of select="compat"/>
											</mediumNote>
										</xsl:if>
									</offline>
								</distribution>
							</xsl:for-each>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
				<coverage>
					<geographicCoverage>
					<!-- mandatory in BDP: description and coordinates-->
						<geographicDescription>
							<xsl:value-of select="metadata/idinfo/spdom/descgeog"/>
						</geographicDescription>
						<boundingCoordinates>
							<westBoundingCoordinate>
								<xsl:value-of select="metadata/idinfo/spdom/bounding/westbc"/>
							</westBoundingCoordinate>
							<eastBoundingCoordinate>
								<xsl:value-of select="metadata/idinfo/spdom/bounding/eastbc"/>
							</eastBoundingCoordinate>
							<northBoundingCoordinate>
								<xsl:value-of select="metadata/idinfo/spdom/bounding/northbc"/>
							</northBoundingCoordinate>
							<southBoundingCoordinate>
								<xsl:value-of select="metadata/idinfo/spdom/bounding/southbc"/>
							</southBoundingCoordinate>
							<xsl:if test="metadata/idinfo/spdom/bounding/boundalt/altmin!=''">
								<boundingAltitudes>
									<altitudeMinimum>
										<xsl:value-of select="metadata/idinfo/spdom/bounding/boundalt/altmin"/>
									</altitudeMinimum>
									<xsl:if test="metadata/idinfo/spdom/bounding/boundalt/altmax!=''">
										<altitudeMaximum>
											<xsl:value-of select="metadata/idinfo/spdom/bounding/boundalt/altmax"/>
										</altitudeMaximum>
									</xsl:if>
									<xsl:if test="metadata/idinfo/spdom/bounding/boundalt/altunits!=''">
										<altitudeUnits>
											<xsl:value-of select="metadata/idinfo/spdom/bounding/boundalt/altunits"/>
										</altitudeUnits>
									</xsl:if>
								</boundingAltitudes>
							</xsl:if>
						</boundingCoordinates>
						<xsl:for-each select="metadata/idinfo/spdom/dsgpoly">
							<datasetGPolygon><!-- this section is pretty much a 1 to 1 correspondence (except syntaxis) between EML and BDP -->
								<datasetGPolygonOuterGRing>
									<xsl:for-each select="dsgpolyo/grngpoin"><!-- cardinality is 4 to infinity in BDP, and 3 to infinity in EML --> 
										<gRingPoint>
											<gRingLatitude>
												<xsl:value-of select="gringlat"/>
											</gRingLatitude>
											<gRingLongitude>
												<xsl:value-of select="gringlon"/>
											</gRingLongitude>
										</gRingPoint>
									</xsl:for-each>
								</datasetGPolygonOuterGRing>
								<!-- exclusion ring optional in both standards -->
								<xsl:if test="dsgpolyx/grngpoin/gringlat!=''">
									<datasetGPolygonExclusionGRing>
										<xsl:for-each select="dsgpolyx/grngpoin">
											<gRingPoint>
												<gRingLatitude>
													<xsl:value-of select="gringlat"/>
												</gRingLatitude>
												<gRingLongitude>
													<xsl:value-of select="gringlon"/>
												</gRingLongitude>
											</gRingPoint>
										</xsl:for-each>
									</datasetGPolygonExclusionGRing>
								</xsl:if>
							</datasetGPolygon>
						</xsl:for-each>
					</geographicCoverage>
					<temporalCoverage>
						<xsl:choose>
							<xsl:when test="metadata/idinfo/timeperd/timeinfo/sngdate/caldate!=''">
								<singleDateTime>
									<!-- mandatory in BDP -->
									<calendarDate><!--FGDC date example 19990429 -->  <!-- defenitely, needs check ups-->
										<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/caldate"/><!-- normalize date type routine call needed-->
									</calendarDate>
									<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/time!=''">
										<time>
											<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/time"/>
										</time>
									</xsl:if>
								</singleDateTime>
							</xsl:when>
							<xsl:when test="metadata/idinfo/timeperd/timeinfo/mdattim/sngdate/caldate!=''">
								<xsl:for-each select="metadata/idinfo/timeperd/timeinfo/mdattim/sngdate">
									<singleDateTime>
										<calendarDate>
											<xsl:value-of select="caldate"/><!-- normalize date type routine call needed-->
										</calendarDate>
										<xsl:if test="time">
											<time>
												<xsl:value-of select="time"/>
											</time>
										</xsl:if>
									</singleDateTime>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolscal!=''">
								<alternativeTimeScale>
									<timeScaleName>
										<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolscal"/>
									</timeScaleName>
									<timeScaleAgeEstimate>
										<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolest"/>
									</timeScaleAgeEstimate>
									<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolun!=''">
										<timeScaleAgeUncertainty>
											<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolun"/>
										</timeScaleAgeUncertainty>
									</xsl:if>
									<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolexpl!=''">
										<timeScaleAgeExplanation>
											<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolexpl"/>
										</timeScaleAgeExplanation>
									</xsl:if>
									<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/title!=''">
										<timeScaleCitation>
											<title>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/title"/>
											</title>
											<creator>
												<!-- the perl code?-->
												<organizationName>
													<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/origin"/>
												</organizationName>
											</creator>
											<pubDate>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubdate"/>
											</pubDate>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/serinfo/sername!=''">
												<series>
													<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/serinfo/sername"/>
												</series>
											</xsl:if>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/onlink!=''">
												<distribution>
													<online>
														<url>
															<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/onlink"/>
														</url>
													</online>
												</distribution>
											</xsl:if>
											<generic>
												<publisher>		<!-- note: this is the only required element for the alternative time scale citation in EML. in BDP is mandatory if applicable, so default to creator value if that doesnt work -->
													<xsl:choose>
														<xsl:when test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/pubplace!=''">
															<organizationName>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
															<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/publish">
																<organizationName>
																	<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/publish"/>
																</organizationName>
															</xsl:if>
														</xsl:when>
														<xsl:otherwise>
															<organizationName>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/origin"/>
															</organizationName>
														</xsl:otherwise>
													</xsl:choose>
												</publisher>
												<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/geoform!=''">
													<referenceType>
														<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/geoform"/>
													</referenceType>
												</xsl:if>
												<xsl:if test="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/edition!=''">
													<edition>
														<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/edition"/>
													</edition>
												</xsl:if>
											</generic>
										</timeScaleCitation>
									</xsl:if>
								</alternativeTimeScale>
							</xsl:when>
							<xsl:when test="metadata/idinfo/timeperd/timeinfo/mdattim/sngdate/geolage/geolscal!=''">
								<xsl:for-each select="metadata/idinfo/timeperd/timeinfo/mdattim">
									<alternativeTimeScale>
										<timeScaleName>
											<xsl:value-of select="sngdate/geolage/geolscal"/>
										</timeScaleName>
										<timeScaleAgeEstimate>
											<xsl:value-of select="sngdate/geolage/geolest"/>
										</timeScaleAgeEstimate>
										<xsl:if test="sngdate/geolage/geolun!=''">
											<timeScaleAgeUncertainty>
												<xsl:value-of select="sngdate/geolage/geolun"/>
											</timeScaleAgeUncertainty>
										</xsl:if>								
										<xsl:if test="sngdate/geolage/geolexpl!=''">
											<timeScaleAgeExplanation>
												<xsl:value-of select="sngdate/geolage/geolexpl"/>
											</timeScaleAgeExplanation>
										</xsl:if>	
										<xsl:if test="sngdate/geolage/geolcit/citeinfo/title!=''">
											<timeScaleCitation>
												<title>
													<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/title"/>
												</title>
												<creator>
													<organizationName>
														<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/origin"/>
													</organizationName>
												</creator>
												<pubDate>
													<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/pubdate"/>
												</pubDate>
												<xsl:if test="sngdate/geolage/geolcit/citeinfo/serinfo/sername!=''">
													<series>
														<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/serinfo/sername"/>
													</series>
												</xsl:if>
												<xsl:if test="sngdate/geolage/geolcit/citeinfo/onlink!=''">
													<distribution>
														<online>
															<url>
																<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/onlink"/>
															</url>
														</online>
													</distribution>
												</xsl:if>
												<generic>
													<publisher>
														<xsl:choose>
															<xsl:when test="sngdate/geolage/geolcit/citeinfo/pubinfo/pubplace!=''">
																<organizationName>
																	<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
																</organizationName>
															</xsl:when>
															<xsl:when  test="sngdate/geolage/geolcit/citeinfo/pubinfo/publish!=''">
																<organizationName>
																	<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/pubinfo/publish"/>
																</organizationName>
															</xsl:when>
															<xsl:otherwise>
																<organizationName>
																	<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/origin"/>
																</organizationName>
															</xsl:otherwise>
														</xsl:choose>
													</publisher>
													<xsl:if test="sngdate/geolage/geolcit/citeinfo/geoform!=''">
														<referenceType>
															<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/geoform"/>
														</referenceType>
													</xsl:if>
													<xsl:if test="sngdate/geolage/geolcit/citeinfo/edition!=''">
														<edition>
															<xsl:value-of select="sngdate/geolage/geolcit/citeinfo/edition"/>
														</edition>
													</xsl:if>
												</generic>
											</timeScaleCitation>						
										</xsl:if>
									</alternativeTimeScale>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="metadata/idinfo/timeperd/timeinfo/rngdates/begdate!=''">
								<rangeOfDates>
									<beginDate>
										<calendarDate>
											<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/begdate"/><!-- normalize date type routine call needed-->
										</calendarDate>
										<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/begtime!=''">
											<time>
												<xsl:value-of select="."/>
											</time>
										</xsl:if>
									</beginDate>
									<endDate>
										<calendarDate>
											<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/enddate"/><!-- normalize date type routine call neededFRequently is "present" "ongoing" and the like-->
										</calendarDate>
										<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endtime!=''">
											<time>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endtime"/>
											</time>
										</xsl:if>
									</endDate>
								</rangeOfDates>
							</xsl:when>
							<xsl:when test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolscal!=''"><!-- it will get to this case when hell freezes over, but... -->
								<rangeOfDates>
									<beginDate>
										<alternativeTimeScale>
											<timeScaleName>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolscal"/>
											</timeScaleName>
											<timeScaleAgeEstimate>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolest"/>
											</timeScaleAgeEstimate>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolun!=''">
												<timeScaleAgeUncertainty>
													<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolun"/>
												</timeScaleAgeUncertainty>
											</xsl:if>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolexpl!=''">
												<timeScaleAgeExplanation>
													<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolexpl"/>
												</timeScaleAgeExplanation>
											</xsl:if>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/title">
												<timeScaleCitation>
													<title>
														<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/title"/>
													</title>
													<creator>
														<organizationName>
															<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/origin"/>
														</organizationName>
													</creator>
													<pubDate>
														<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/pubdate"/>
													</pubDate>
													<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/serinfo/sername!=''">
														<series>
															<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/serinfo/sername"/>
														</series>
													</xsl:if>
													<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/onlink!=''">
														<distribution>
															<online>
																<url>
																	<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/onlink"/>
																</url>
															</online>
														</distribution>
													</xsl:if>
													<generic>
														<publisher>
															<organizationName>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/pubinfo/publish"/>
															</organizationName>
															<organizationName>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
														</publisher>
														<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/geoform!=''">
															<referenceType>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/geoform"/>
															</referenceType>
														</xsl:if>
														<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/edition!=''">
															<edition>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/edition"/>
															</edition>
														</xsl:if>
													</generic>
												</timeScaleCitation>
											</xsl:if>
										</alternativeTimeScale>
									</beginDate>
									<endDate>
										<alternativeTimeScale>
											<timeScaleName>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolscal"/>
											</timeScaleName>
											<timeScaleAgeEstimate>
												<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolest"/>
											</timeScaleAgeEstimate>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolun!=''">
												<timeScaleAgeUncertainty>
													<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolun"/>
												</timeScaleAgeUncertainty>
											</xsl:if>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolexpl!=''">
												<timeScaleAgeExplanation>
													<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolexpl"/>
												</timeScaleAgeExplanation>
											</xsl:if>
											<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/title!=''">
												<timeScaleCitation>									
													<title>
														<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/title"/>
													</title>
													<creator>
														<organizationName>
															<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/origin"/>
														</organizationName>
													</creator>
													<pubDate>
														<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/pubdate"/>
													</pubDate>
													<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/serinfo/sername!=''">
														<series>
															<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/serinfo/sername"/>
														</series>
													</xsl:if>
													<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/onlink!=''">
														<distribution>
															<online>
																<url>
																	<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/onlink"/>
																</url>
															</online>
														</distribution>
													</xsl:if>
													<generic>
														<publisher>
															<organizationName>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/pubinfo/publish"/>
															</organizationName>
															<organizationName>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
														</publisher>
														<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/geoform!=''">
															<referenceType>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/geoform"/>
															</referenceType>
														</xsl:if>
														<xsl:if test="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/edition!=''">
															<edition>
																<xsl:value-of select="metadata/idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/edition"/>
															</edition>
														</xsl:if>
													</generic>
												</timeScaleCitation>		
											</xsl:if>
										</alternativeTimeScale>							
									</endDate>
								</rangeOfDates>							
							</xsl:when>
						</xsl:choose>
					</temporalCoverage>
				</coverage>
				
				<xsl:if test="metadata/idinfo/descript/purpose!='' ">
					<xsl:for-each select="metadata/idinfo/descript/purpose">
						<purpose>
							<para>
								<xsl:value-of select="."/>
							</para>
						</purpose>
					</xsl:for-each>
				</xsl:if>
				
				<xsl:if test="metadata/idinfo/status/progress!=''">
					<maintenance><!--this is mandatory in BDP , but I placed a conditional just in case-->
						<description>
							<section>
							<title><xsl:value-of select="'Progress'"/></title>
							<para>
								<xsl:for-each select="metadata/idinfo/status/progress">
									<literalLayout>
										<xsl:value-of select="."/>
									</literalLayout>
								</xsl:for-each>
							</para>
							</section>
							<section>
								<title><xsl:value-of select="'Update'"/>  </title>
								<para>
									<xsl:for-each select="metadata/idinfo/status/update">
										<literalLayout>
											<xsl:value-of select="."/>
										</literalLayout>
									</xsl:for-each>
								</para>
							</section>
						</description>
						<xsl:for-each select="metadata/idinfo/status/update"><!-- weak proposal here, should review: EML has enumerated fields -->
							<maintenanceUpdateFrequency><xsl:value-of select="'otherMaintenancePeriod'"/></maintenanceUpdateFrequency>
						</xsl:for-each>
					</maintenance>
				</xsl:if>
				<!--contact revisited in feb 07: EML needs one -->
				<xsl:choose>
					<xsl:when test="metadata/idinfo/ptcontac!='' "><!-- it is really optional in fgdc/bdp.esri CHECK first-->
						<xsl:for-each select="metadata/idinfo/ptcontac">
							<contact>
								<xsl:for-each select="./cntinfo/cntorgp/cntorg">
									<organizationName>
										<xsl:value-of select="."/>
									</organizationName>
								</xsl:for-each>
		
								<xsl:if test="./cntinfo/cntperp/cntper">
									<individualName>
										<surName>
											<xsl:value-of select="./cntinfo/cntperp/cntper"/>
										</surName>
									</individualName>
									<xsl:for-each select="./cntinfo/cntperp/cntorg">
										<organizationName>
											<xsl:value-of select="."/>
										</organizationName>
									</xsl:for-each>
								</xsl:if>
								<xsl:for-each select="./cntinfo/cntpos">
									<positionName>
										<xsl:value-of select="."/>
									</positionName>
								</xsl:for-each>
		
								<xsl:if test="./cntinfo/cntaddr!=''">
									<address>
										<deliveryPoint>
											<xsl:value-of select="./cntinfo/cntaddr/address"/>
										</deliveryPoint>
										<xsl:if test="./cntinfo/cntaddr/city!=''">
											<city>
												<xsl:value-of select="./cntinfo/cntaddr/city"/>
											</city>
										</xsl:if>
										<xsl:if test="./cntinfo/cntaddr/state!=''">
											<administrativeArea>
												<xsl:value-of select="./cntinfo/cntaddr/state"/>
											</administrativeArea>
										</xsl:if>
										<xsl:if test="./cntinfo/cntaddr/postal!=''">
											<postalCode>
												<xsl:value-of select="./cntinfo/cntaddr/postal"/>
											</postalCode>
										</xsl:if>
										<xsl:if test="./cntinfo/cntaddr/country!=''">
											<country>
												<xsl:value-of select="./cntinfo/cntaddr/country"/>
											</country>
										</xsl:if>
									</address>
								</xsl:if>
								<xsl:if test="./cntinfo/cntvoice!=''">
									<xsl:for-each select="./cntinfo/cntvoice">
										<phone>
											<xsl:attribute name="phonetype"><xsl:value-of select="'voice'"/></xsl:attribute>
											<xsl:value-of select="."/>
										</phone>
									</xsl:for-each>
								</xsl:if>
							</contact>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="metadata/distinfo/distrib/cntinfo!=''">
						<xsl:for-each select="metadata/distinfo/distrib/cntinfo">
							<contact>
								<xsl:for-each select="./cntperp/cntper">
									<individualName>
										<surName>
											<xsl:value-of select="."/>
										</surName>
									</individualName>
								</xsl:for-each>
								<xsl:for-each select="./cntorgp/cntorg">
									<organizationName>
										<xsl:value-of select="."/>
									</organizationName>
								</xsl:for-each>
								<xsl:for-each select="./cntpos">
									<positionName>
										<xsl:value-of select="."/>
									</positionName>
								</xsl:for-each>
								<address>
									<xsl:for-each select="./cntaddr/address">
										<deliveryPoint>
											<xsl:value-of select="."/>
										</deliveryPoint>
									</xsl:for-each>
									<xsl:for-each select="./cntaddr/city">
										<city>
											<xsl:value-of select="."/>
										</city>
									</xsl:for-each>
									<xsl:for-each select="./cntaddr/state">
										<administrativeArea>
											<xsl:value-of select="."/>
										</administrativeArea>
									</xsl:for-each>
									<xsl:for-each select="./cntaddr/postal">
										<postalCode>
											<xsl:value-of select="."/>
										</postalCode>
									</xsl:for-each>
									<xsl:for-each select="./cntaddr/country">
										<country>
											<xsl:value-of select="."/>
										</country>
									</xsl:for-each>
								</address>
								<xsl:for-each select="./cntvoice">
									<phone phonetype="voice">
										<xsl:value-of select="."/>
									</phone>
								</xsl:for-each>
								<xsl:for-each select="./cntfax">
									<phone phonetype="fax">
										<xsl:value-of select="."/>
									</phone>
								</xsl:for-each>
								<xsl:for-each select="./cntemail">
									<electronicMailAddress>
										<xsl:value-of select="."/>
									</electronicMailAddress>
								</xsl:for-each>
							</contact>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="metadata/idinfo/citation/citeinfo/pubinfo/publish!=''"><!-- info gathered from ESRI doc -->
						<xsl:for-each select="metadata/idinfo/citation/citeinfo/pubinfo/publish">
							<publisher>
								<organizationName>
									<xsl:value-of select="."/>
								</organizationName>
							</publisher>
						</xsl:for-each>
					</xsl:when>				
					<xsl:when test="metadata/publisher"><!-- this comes from the perl script aiding the transform -->
						<xsl:copy-of select="metadata/publisher"/>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="metadata/idinfo/citation/citeinfo/pubinfo/pubplace!=''">
					<xsl:for-each select="metadata/idinfo/citation/citeinfo/pubinfo/pubplace">
						<pubPlace>
							<xsl:value-of select="."/>
						</pubPlace>
					</xsl:for-each>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="metadata/access">
						<xsl:copy-of select="metadata/access"/>
					</xsl:when>
					<xsl:otherwise><!-- we do not have precise information about the data set owner -->
						<access>
						    <xsl:attribute name="scope">
								<xsl:value-of select="'document'"/>
							</xsl:attribute>
							<xsl:attribute name="order">
								<xsl:value-of select="'allowFirst'"/>
							</xsl:attribute>
							<xsl:attribute name="authSystem">
								<xsl:value-of select="'knb'"/>
							</xsl:attribute>
							<allow>
								<principal>public</principal>
								<permission>read</permission>
							</allow>
						</access>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>

					<xsl:when test="/metadata/spdoinfo/direct = 'Vector'">

						<spatialVector>

							<xsl:attribute name="id">
								<xsl:value-of select="metadata/eainfo/detailed/@Name"/>
							</xsl:attribute>

							<xsl:for-each select="metadata/eainfo/detailed/@Name">
								<entityName>
									<xsl:value-of select="."/>
								</entityName>
							</xsl:for-each>
							
							<xsl:call-template name="physical"/>

							<xsl:call-template name="method"/>

							<xsl:call-template name="attr"/>

							<geometry>
								<xsl:choose>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'string' )">
										<xsl:value-of select="'LineString'"/>
									</xsl:when>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'ring' )">
										<xsl:value-of select="'LinearRing'"/>
									</xsl:when>
									
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'olygon') ">
										<xsl:value-of select="'Polygon'"/>
									</xsl:when>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'chain' )">
										<xsl:value-of select="'Polygon'"/>
									</xsl:when>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'point' )">
										<xsl:value-of select="'Point'"/>
									</xsl:when>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'node' )">
										<xsl:value-of select="'Point'"/>
									</xsl:when>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'link' )">
										<xsl:value-of select="'LinearRing'"/>
									</xsl:when>
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'pline') "><!-- for Spline-->
										<xsl:value-of select="'Polygon'"/>
									</xsl:when>			
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'arc' )">
										<xsl:value-of select="'Polygon'"/>
									</xsl:when>						
									<xsl:when test="contains(metadata/spdoinfo/ptvctinf/sdtsterm/sdtstype,'ezier') "><!-- for Bezier-->
										<xsl:value-of select="'Polygon'"/>
									</xsl:when>		
								</xsl:choose>
							</geometry>
							<!-- cardinality in EML just 1 THIS needs to be address in next version of EML eml-2.0.X-->
                            <!-- for now, we will put only the geometriObjectCount of the first object.. commenting the foreach-->
							<!-- <xsl:for-each select="metadata/spdoinfo/ptvctinf/sdtsterm/ptvctcnt">-->

								<geometricObjectCount>
								    <xsl:value-of select="metadata/spdoinfo/ptvctinf/sdtsterm/ptvctcnt"/>
									<!-- <xsl:value-of select="."/> -->
								</geometricObjectCount>
   							<!-- </xsl:for-each> -->

							<xsl:call-template name="spref"/>
							
							<xsl:if test="/metadata/dataqual/posacc/horizpa/horizpar!=''">
								<xsl:call-template name="horizAccuracy"/>
							</xsl:if>
							<xsl:if test="/metadata/dataqual/posacc/vertacc">
								<xsl:call-template name="vertAccuracy"/>
		                    </xsl:if>
						</spatialVector>

					</xsl:when>

					<xsl:when test="metadata/spdoinfo/direct = 'Raster'">

						<spatialRaster>
							<xsl:for-each select="/metadata/eainfo/detailed/@Name">
								<xsl:attribute name="id">
									<xsl:value-of select="."/>
								</xsl:attribute>
								<entityName>
									<xsl:value-of select="."/>
								</entityName>
							</xsl:for-each>
							<xsl:call-template name="physical"/>

							<xsl:call-template name="method"/>

							<xsl:call-template name="attr"/>

							<xsl:call-template name="spref"/>
							<xsl:if test="/metadata/dataqual/posacc/horizpa/horizpar!=''">
								<xsl:call-template name="horizAccuracy"/>
							</xsl:if>
					        <xsl:if test="/metadata/dataqual/posacc/vertacc">
								<xsl:call-template name="vertAccuracy"/>
						     </xsl:if>

							<xsl:for-each select="metadata/spdoinfo/rastinfo/rastxsz">

								<cellSizeXDirection>
									<xsl:value-of select="."/>
								</cellSizeXDirection>

							</xsl:for-each>

							<xsl:for-each select="metadata/spdoinfo/rastinfo/rastysz">

								<cellSizeYDirection>
									<xsl:value-of select="."/>
								</cellSizeYDirection>

							</xsl:for-each>

							<xsl:for-each select="metadata/spdoinfo/rastinfo/rastband">
								<numberOfBands>
									<xsl:value-of select="."/>
								</numberOfBands>
							</xsl:for-each>
							<xsl:for-each select="metadata/spdoinfo/rastinfo/rastorig">
								<rasterOrigin>
									<xsl:value-of select="."/>
								</rasterOrigin>
							</xsl:for-each>
							<xsl:for-each select="metadata/spdoinfo/rastinfo/rowcount">
								<rows>
									<xsl:value-of select="."/>
								</rows>
							</xsl:for-each>
							<xsl:for-each select="metadata/spdoinfo/rastinfo/colcount">
								<columns>
									<xsl:value-of select="."/>
								</columns>
							</xsl:for-each>
							<xsl:for-each select="metadata/spdoinfo/rastinfo/vrtcount">
								<verticals>
									<xsl:value-of select="."/>
								</verticals>
							</xsl:for-each>

							<cellGeometry>
								<xsl:choose>
									<xsl:when test="/metadata/spdoinfo/rastinfo/rasttype ='Grid Cell'">
										<xsl:value-of select="'matrix'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'pixel'"/>
									</xsl:otherwise>
								</xsl:choose>
							</cellGeometry>
						</spatialRaster>
					</xsl:when>
				</xsl:choose>
			</dataset>
		</xsl:element>
	</xsl:template>
	
<!-- templates begin here -->

<!-- methods template -->

	<xsl:template name="method" match="/metadata/dataqual">
		<xsl:for-each select="./lineage">
			<methods>
				<methodStep>
					<xsl:value-of select="procstep"/>
					<xsl:for-each select="procstep/procdesc">
						<description>
							<para>
								<xsl:value-of select="."/>
							</para>
						</description>
					</xsl:for-each>
					<xsl:for-each select="procstep/srcused">
						<dataSource>
							<title>
								<xsl:value-of select="."/>
							</title>
						</dataSource>
					</xsl:for-each>
				</methodStep>
			</methods>
		</xsl:for-each>
	</xsl:template>

<!-- attributeList template -->

	<xsl:template name="attr" match="/metadata/eainfo/detailed">
		<attributeList>
			<xsl:for-each select="/metadata/eainfo/detailed/attr">

				<attribute>

					<xsl:attribute name="id">
						<xsl:value-of select="attrlabl"/>
					</xsl:attribute>

					<xsl:for-each select="./attrlabl">
						<attributeName>
							<xsl:value-of select="."/>
						</attributeName>
					</xsl:for-each>
					
					<xsl:choose>
						<xsl:when test="./attrdef">
							<attributeDefinition>
								<xsl:value-of select="./attrdef"/>
							</attributeDefinition>
						</xsl:when>						
						<xsl:otherwise>
							<attributeDefinition>
								<xsl:value-of select="./attrlabl"/>
							</attributeDefinition>
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:choose><!-- storageSystem: not critical -->
						<xsl:when test="attrtype='Number'">
							<xsl:choose>
								<xsl:when test="./atnumdec &gt; 1">
									<storageType typeSystem="http://www.w3.org/2001/XMLSchema-datatypes">float</storageType>
								</xsl:when>
								<xsl:otherwise>
									<storageType typeSystem="http://www.w3.org/2001/XMLSchema-datatypes">integer</storageType>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="attrtype = 'String'">
							<storageType typeSystem="http://www.w3.org/2001/XMLSchema-datatypes">string</storageType>
						</xsl:when>
						<xsl:otherwise>
							<storageType typeSystem="http://www.esri.com/metadata/esriprof80.html">
								<xsl:value-of select="./attrtype"/>
							</storageType>
						</xsl:otherwise>
					</xsl:choose>
				
					<xsl:choose>
						<xsl:when test="./attrdomv">
		                    <xsl:for-each select="./attrdomv">
								<xsl:choose>
									<xsl:when test="./edom"><!-- the attribute is an "enumerated domain", say nominal/nonNumericDomain/enumeratedDomain (or testDomain) -->
										<measurementScale>
											<nominal>
												<nonNumericDomain>
													<enumeratedDomain>
														<xsl:for-each select="./edom">
															<codeDefinition>
																<xsl:for-each select="./edomv">
																	<code>
																		<xsl:value-of select="."/>
																	</code>
																</xsl:for-each>
																<xsl:for-each select="./edomvd">
																	<definition>
																		<xsl:value-of select="."/>
																	</definition>
																</xsl:for-each>
																<xsl:for-each select="metadata/eainfo/detailed/attr/attrdomv/edom/edomvds">
																	<source>
																		<xsl:value-of select="."/>
																	</source>
																</xsl:for-each>
															</codeDefinition>
														</xsl:for-each>
													</enumeratedDomain>
												</nonNumericDomain>
											</nominal>
										</measurementScale>
									</xsl:when>
		
									<xsl:when test="./rdom"><!-- it is a number, with units. however, units are optional in FGDC, cross your fingers -->
		
										<measurementScale>
											<xsl:choose>
												<xsl:when test="./rdom/rdommin &lt; 0">
													<interval>
														<xsl:for-each select="./rdom/unit">
															<unit>
																<customUnit>
																	<xsl:value-of select="."/>
																</customUnit>
															</unit>
														</xsl:for-each>
														<xsl:for-each select="../atprecis">
															<precision>
																<xsl:value-of select="."/>
															</precision>
														</xsl:for-each>
														<numericDomain>
															<numberType>
																<xsl:choose>
																	<xsl:when test="../atprecis = 0">whole</xsl:when>
																	<xsl:otherwise>real</xsl:otherwise>
																</xsl:choose>
															</numberType>
															<bounds>
																<xsl:for-each select="./rdom/rdommin">
																	<minimum inclusive="true">
																		<xsl:value-of select="."/>
																	</minimum>
																</xsl:for-each>
																<xsl:for-each select="./rdom/rdommax">
																	<maximum inclusive="true">
																		<xsl:value-of select="."/>
																	</maximum>
																</xsl:for-each>
															</bounds>
														</numericDomain>
													</interval>
												</xsl:when>
												<xsl:otherwise>
													<ratio>
														<xsl:for-each select="./rdom/unit">
															<unit>
																<customUnit>
																	<xsl:value-of select="."/>
																</customUnit>
															</unit>
														</xsl:for-each>
														<xsl:for-each select="./rdom/attrres">
															<precision>
																<xsl:value-of select="."/>
															</precision>
														</xsl:for-each>
														<numericDomain>
															<xsl:choose>
																<xsl:when test="../atprecis = 0">whole</xsl:when>
																<xsl:otherwise>real</xsl:otherwise>
															</xsl:choose>
															<bounds>
																<xsl:for-each select="./rdom/rdommin">
																	<minimum inclusive="true">
																		<xsl:value-of select="."/>
																	</minimum>
																</xsl:for-each>
																<xsl:for-each select="./rdom/rdommax">
																	<maximum inclusive="true">
																		<xsl:value-of select="."/>
																	</maximum>
																</xsl:for-each>
															</bounds>
														</numericDomain>
													</ratio>
												</xsl:otherwise>
											</xsl:choose>
										</measurementScale>
									</xsl:when>
									<xsl:when test="./codesetd">
										<measurementScale>
											<nominal>
												<nonNumericDomain>
													<enumeratedDomain>
														<externalCodeset>
															<codesetName>
																<xsl:value-of select="./codesetn"/>
															</codesetName>
															<citation>
																<xsl:value-of select="./codesets"/>
															</citation>
														</externalCodeset>
													</enumeratedDomain>
												</nonNumericDomain>
											</nominal>
										</measurementScale>
									</xsl:when>
									<xsl:when test="./udom">
										<measurementScale>
											<nominal>
												<nonNumericDomain>
													<textDomain>
														<definition>
															<xsl:value-of select="."/>
														</definition>
													</textDomain>
												</nonNumericDomain>
											</nominal>
										</measurementScale>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>	<!-- end of for each "attrdomv"-->			
						</xsl:when>
					    <xsl:otherwise><!-- inspite of being mandatory, this attribute was not documented to the domain level-->
							  <measurementScale>
									<nominal>
										<nonNumericDomain>
											<textDomain>
												<definition>
													<xsl:value-of select="./attrdef"/>
												</definition>
											</textDomain>
										</nonNumericDomain>
									</nominal>
								</measurementScale>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="./begdatea">
						<coverage>
							<temporalCoverage>
								<rangeOfDates>
									<xsl:for-each select=".">
										<calendarDate>
											<xsl:value-of select="."/>
										</calendarDate>
									</xsl:for-each>
									<xsl:for-each select="../enddatea">
										<calendarDate>
											<xsl:value-of select="."/>
										</calendarDate>
									</xsl:for-each>
								</rangeOfDates>
							</temporalCoverage>
						</coverage>
					</xsl:for-each>
					<xsl:for-each select="metadata/dataqual/attrac">
						<attributeAccuracy>
							<xsl:for-each select="./attraccr">
								<accuracyReport>
									<xsl:value-of select="."/>
								</accuracyReport>
							</xsl:for-each>
							<xsl:for-each select="qattrac">
								<quantitativeAccuracyReport>
									<xsl:for-each select="attracv">
										<attributeAccuracyValue>
											<xsl:value-of select="."/>
										</attributeAccuracyValue>
									</xsl:for-each>
									<xsl:for-each select="attrace">
										<attributeAccuracyMethod>
											<xsl:value-of select="."/>
										</attributeAccuracyMethod>
									</xsl:for-each>
								</quantitativeAccuracyReport>
							</xsl:for-each>
						</attributeAccuracy>
					</xsl:for-each>
				</attribute>
			</xsl:for-each>
		</attributeList>
	</xsl:template>

<!-- spatialReference template -->

	<xsl:template name="spref" match="/metadata/spref">
		<spatialReference>
			<xsl:choose>
				<xsl:when test="//horizsys/cordsysn/projcsn">
					<horizCoordSysName>
						<xsl:value-of select=".//projcsn"/>
					</horizCoordSysName>
				</xsl:when>
				<xsl:otherwise>
					<horizCoordSysName>
						<xsl:value-of select=".//geogcsn"/>
					</horizCoordSysName>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:for-each select="vertdef">
				<vertCoordSys>
					<xsl:for-each select="altsys">
						<altitudeSysDef>
							<xsl:for-each select="altdatum">
								<altitudeDatumName>
									<xsl:value-of select="."/>
								</altitudeDatumName>
							</xsl:for-each>
							<xsl:for-each select="altres">
								<altitudeResolution>
									<xsl:value-of select="."/>
								</altitudeResolution>
							</xsl:for-each>
							<xsl:for-each select="altunits">
								<altitudeDistanceUnits>
									<xsl:value-of select="."/>
								</altitudeDistanceUnits>
							</xsl:for-each>
							<xsl:for-each select="altenc">
								<altitudeEncodingMethod>
									<xsl:value-of select="."/>
								</altitudeEncodingMethod>
							</xsl:for-each>
						</altitudeSysDef>
					</xsl:for-each>
					<xsl:for-each select="depthsys">
						<depthSysDef>
							<xsl:for-each select="depthdn">
								<depthDatumName>
									<xsl:value-of select="."/>
								</depthDatumName>
							</xsl:for-each>
							<xsl:for-each select="depthres">
								<depthResolution>
									<xsl:value-of select="."/>
								</depthResolution>
							</xsl:for-each>
							<xsl:for-each select="depthdu">
								<depthDistanceUnits>
									<xsl:value-of select="."/>
								</depthDistanceUnits>
							</xsl:for-each>
							<xsl:for-each select="depthem">
								<depthEncodingMethod>
									<xsl:value-of select="."/>
								</depthEncodingMethod>
							</xsl:for-each>
						</depthSysDef>
					</xsl:for-each>
				</vertCoordSys>
			</xsl:for-each>
		</spatialReference>
	</xsl:template>
	
	<!-- vertical accuracy template -->
	
	<xsl:template name="vertAccuracy" match="/metadata/dataqual/posacc/vertacc">
		<verticalAccuracy>
			<xsl:for-each select="vertaccr">
				<accuracyReport>
					<xsl:value-of select="."/>
				</accuracyReport>
			</xsl:for-each>
			<xsl:for-each select="qvertpa">
				<quantAccReport>
					<xsl:for-each select="vertaccv">
						<quantAccVal>
							<xsl:value-of select="."/>
						</quantAccVal>
					</xsl:for-each>
					<xsl:for-each select="vertacce">
						<quantAccMethod>
							<xsl:value-of select="."/>
						</quantAccMethod>
					</xsl:for-each>
				</quantAccReport>
			</xsl:for-each>
		</verticalAccuracy>
	</xsl:template>

   <!-- horizontal accuracy template -->
   	
	<xsl:template name="horizAccuracy" match="/metadata/dataqual/posacc/horizpa">
		<horizontalAccuracy>
			<xsl:for-each select="/metadata/dataqual/posacc/horizpa/horizpar">
				<accuracyReport>
					<xsl:value-of select="."/>
				</accuracyReport>
			</xsl:for-each>
			<xsl:for-each select="/metadata/dataqual/posacc/horizpa/qhorizpa">
				<quantAccReport>
					<xsl:for-each select="./horizpav">
						<quantAccVal>
							<xsl:value-of select="."/>
						</quantAccVal>
					</xsl:for-each>
					<xsl:for-each select="./horizpae">
						<quantAccMethod>
							<xsl:value-of select="."/>
						</quantAccMethod>
					</xsl:for-each>
				</quantAccReport>
			</xsl:for-each>
		</horizontalAccuracy>
	</xsl:template>

<!-- physical template -->

	<xsl:template name="physical" match="/metadata">
		<physical>
			<xsl:for-each select="/metadata/eainfo/detailed/@Name">
				<objectName>
					<xsl:value-of select="."/>
				</objectName>
			</xsl:for-each>

			<dataFormat>
				<xsl:choose>

					<xsl:when test="//idinfo/natvform">
						<externallyDefinedFormat>
							<formatName>
								<xsl:value-of select="//idinfo/natvform"/>
							</formatName>
						</externallyDefinedFormat>
					</xsl:when>

					<xsl:when test="//distributor/distorFormat/formatName">
						<externallyDefinedFormat>
							<formatType>
								<xsl:value-of select="//distributor/distorFormat/formatName"/>
							</formatType>
						</externallyDefinedFormat>
					</xsl:when>
					<xsl:when test="/metadata/distinfo/stdorder/digform/formName">
						<xsl:for-each select="/metadata/distinfo/stdorder/digform">
							<externallyDefinedFormat>
								<formatName>
									<xsl:value-of select="./formName"/>
								</formatName>
								<xsl:for-each select="./formvern">
									<formatVersion>
										<xsl:value-of select="."/>
									</formatVersion>
								</xsl:for-each>
								<!--
						<xsl:for-each select="formverd">
							<documentation>
								<xsl:value-of select="."/>
							</documentation>
						</xsl:for-each>
-->
							</externallyDefinedFormat>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</dataFormat>
			<distribution>
				<xsl:choose>
					<xsl:when test="/metadata/idinfo/citation/citeinfo[starts-with(onlink, 'Server')] ">
						<online>
							<connection>
								<connectionDefinition>
									<references>sde.connection1</references>
								</connectionDefinition>
								<parameter>
									<name>owner</name>
									<value>
										<xsl:value-of select="substring-before(substring-after(//citeinfo/onlink,'User='),';')"/>
									</value>
								</parameter>
								<parameter>
									<name>object</name>
									<value>
										<xsl:value-of select="substring-after(substring-after(//citeinfo/ftname,'.'),'.')"/>
									</value>
								</parameter>
								<parameter>
									<name>shapeColumn</name>
									<value>
										<xsl:value-of select="/metadata/eainfo/detailed/attr/attalias[../attrdef = 'Feature geometry.']"/>
									</value>
								</parameter>
							</connection>
						</online>
					</xsl:when>
					<xsl:otherwise>
						<online>
							<url>
								<xsl:value-of select="/metadata/idinfo/citation/citeinfo/onlink"/>
							</url>
						</online>
					</xsl:otherwise>
				</xsl:choose>
			</distribution>
		</physical>
	</xsl:template>

</xsl:stylesheet>
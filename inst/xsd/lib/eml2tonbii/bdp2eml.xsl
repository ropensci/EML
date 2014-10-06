<?xml version="1.0" encoding="UTF-8"?>
<!--
  *  '$RCSfile: bdp2eml.xsl,v $'
  *    Copyright: 2007 University of New Mexico 
  *
  *   '$Author: jones $'
  *     '$Date: 2007-03-01 17:00:22 $'
  * '$Revision: 1.1 $'
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
  *
This is the metadata standard crosswalk stylesheet that transforms a Biological Data Profile (an extension of the FGDC, the Federal Geographic Data Committee) into the Ecological Metadata Language.
Inigo San Gil

This code would work best in conjuction with a Perl script that attempt to granularize some of the BDP fields deemed ambiguos by EML standards, such as the originator field (<origin>) and the like. It will also aid on the creation of a best practice compliant packageId.

Note: This stylesheet assumes that there is non-empty valid content for mandatory fields in the BDP standard. However, the clearing houses do not have a perfect system to verify the validity of the BDP document contents. As a result, some of the EML produced by this stylesheet may not be schema-rules compliant.

Any improvements, suggestions, flames that you wish to share with the author should be sent to isangil@lternet.edu. Good luck!!
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eml="eml://ecoinformatics.org/eml-2.0.1" xmlns:stmml="http://www.xml-cml.org/schema/stmml" xmlns:sw="eml://ecoinformatics.org/software-2.0.1" xmlns:cit="eml://ecoinformatics.org/literature-2.0.1" xmlns:ds="eml://ecoinformatics.org/dataset-2.0.1" xmlns:prot="eml://ecoinformatics.org/protocol-2.0.1" xmlns:doc="eml://ecoinformatics.org/documentation-2.0.1" xmlns:res="eml://ecoinformatics.org/resource-2.0.1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/metadata">
		<eml:eml>
			<xsl:attribute name="xsi:schemaLocation">eml://ecoinformatics.org/eml-2.0.1 C:/eml-2.0.1/eml.xsd</xsl:attribute>
			<xsl:choose>
				<xsl:when test="packageid!=''"><!-- has the packageId been added to the BDP document? -->
					<xsl:attribute name="packageId">
						<xsl:value-of select="packageid"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="packageId">
						<xsl:value-of select="concat('Standard_',metainfo/metstdn,'StandardVersion_',metainfo/metstdv,'Title_',idinfo/citation/citeinfo/title)"/><!-- default added: need to be changed manually to best practices compliant values. -->
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="system">
				<xsl:value-of select="'knb'"/>
			</xsl:attribute>
			<xsl:attribute name="scope">
				<xsl:value-of select="'system'"/>
			</xsl:attribute>
			<dataset>
				<xsl:for-each select="idinfo/citation/citeinfo/title">
					<title>
						<xsl:value-of select="."/>
					</title>
				</xsl:for-each>
				<creator>		               <!-- the originator field is mandatory in the BDP, so it should be OK here. -->
					<xsl:choose>
						<xsl:when test="idinfo/citation/citeinfo/originIndividualName/originLastName!=''">
							<xsl:for-each select="idinfo/citation/citeinfo/originIndividualName">		
								<individualName>								
								    <xsl:for-each select="originGivenName"><!-- first names AND middle names-->
										<givenName>
											<xsl:value-of select="."/>
										</givenName>
									</xsl:for-each>
									<surName>						     <!-- one last name per individual -->
										<xsl:value-of select="originLastName"/>
									</surName>	
								</individualName>		
							</xsl:for-each>			
						</xsl:when>
						<xsl:when test="idinfo/citation/citeinfo/originOrg!=''">
							<xsl:for-each select="idinfo/citation/citeinfo/originOrg">
								<organizationName>
									<xsl:value-of select="."/>
								</organizationName>
							</xsl:for-each>
						</xsl:when>					
						<xsl:when test="idinfo/citation/citeinfo/origin"><!-- Perl did not break this up, try your best -->
							<organizationName>
								<xsl:value-of select="idinfo/citation/citeinfo/origin"/>
							</organizationName>
						</xsl:when>
					</xsl:choose>
					<!-- sadly, the BDP does not have an address for the originator -->
				</creator>
				<metadataProvider><!-- choice in FGDC either person or organization , but each branch contemplates a sister complimentary element of organization or person-->
					<xsl:choose>
						<xsl:when test="metainfo/metc/cntinfo/cntperp/cntper/lastName!=''"><!-- we should granularize the content  Perl script -->
							<individualName>
								<xsl:if test="metainfo/metc/cntinfo/cntperp/cntper/firstName!=''">
									<xsl:for-each select="metainfo/metc/cntinfo/cntperp/cntper/firstName">
										<givenName>
											<xsl:value-of select="."/>
										</givenName>
									</xsl:for-each>
									<surName>
										<xsl:value-of select="metainfo/metc/cntinfo/cntperp/cntper/lastName"/>
									</surName>
								</xsl:if>
							</individualName>
							<xsl:if test="metainfo/metc/cntinfo/cntperp/cntorg!=''"><!-- this is an optional brother in cntperp -->
								<organizationName>
									<xsl:value-of select="metainfo/metc/cntinfo/cntperp/cntorg"/>
								</organizationName>
							</xsl:if>
						</xsl:when>
						<xsl:when test="metainfo/metc/cntinfo/cntorgp/cntorg!=''">
							<organizationName>
								<xsl:value-of select="metainfo/metc/cntinfo/cntorgp/cntorg"/>
							</organizationName>
							<xsl:if test="metainfo/metc/cntinfo/cntorgp/cntper/lastName!=''"><!-- optional companion to Org Name in FGDC -->
								 <individualName>
									 <xsl:if test="metainfo/metc/cntinfo/cntorgp/cntper/firstName!=''">
										 <xsl:for-each select="metainfo/metc/cntinfo/cntorgp/cntper/firstName">
											<givenName>
												<xsl:value-of select="."/>
											</givenName>
										 </xsl:for-each>
									 </xsl:if>
									 <surName>
										 <xsl:value-of select="metainfo/metc/cntinfo/cntorgp/cntper/lastName"/>
									 </surName>
								 </individualName>
							</xsl:if>
							<xsl:if test="etainfo/metc/cntinfo/cntorgp/cntper">
								<individualName>
									<surName>
										 <xsl:value-of select="metainfo/metc/cntinfo/cntorgp/cntper"/>
									 </surName>
								</individualName>
							</xsl:if>
						</xsl:when>
						<xsl:when test="metainfo/metc/cntinfo/cntperp/cntper">
							<individualName>
								<surName>
									<xsl:value-of select="metainfo/metc/cntinfo/cntperp/cntper"/>
								</surName>
							</individualName>
							<xsl:if test="metainfo/metc/cntinfo/cntperp/cntorg">
								<organizationName>
									<xsl:value-of select="metainfo/metc/cntinfo/cntperp/cntorg"/>
								</organizationName>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
					<xsl:if test="metainfo/metc/cntinfo/cntpos!=''"><!-- optional in FGDC -->
						<positionName>
							<xsl:value-of select="metainfo/metc/cntinfo/cntpos"/>
						</positionName>
					</xsl:if>
				    <xsl:if test="metainfo/metc/cntinfo/cntaddr/addrtype">
						<xsl:for-each select="metainfo/metc/cntinfo/cntaddr">
							<address>	<!-- This is a mandatory element in FGDC (except a children or two) but not in EML . winwin --> 
								<xsl:if test="address!=''">
									<xsl:for-each select="address">
										<deliveryPoint>
											<xsl:value-of select="."/>
										</deliveryPoint>
									</xsl:for-each>
								</xsl:if>
								<city>
									<xsl:value-of select="city"/>
								</city>
								<administrativeArea>
									<xsl:value-of select="state"/>
								</administrativeArea>
								<postalCode>
									<xsl:value-of select="postal"/>
								</postalCode>
								<xsl:if test="country">
									<country>
										<xsl:value-of select="country"/>
									</country>
								</xsl:if>
							</address>
						</xsl:for-each>
					</xsl:if>
					<phone>
						<xsl:attribute name="phonetype">
							<xsl:value-of select="'voice'"/>
						</xsl:attribute>
						<xsl:value-of select="metainfo/metc/cntinfo/cntvoice"/>
					</phone>
					<xsl:if test="metainfo/metc/cntinfo/cntfax!=''">
						<phone>
							<xsl:attribute name="phonetype">
								<xsl:value-of select="'fax'"/>
							</xsl:attribute>
							<xsl:value-of select="metainfo/metc/cntinfo/cntfax"/>
						</phone>
					</xsl:if>
					<xsl:if test="metainfo/metc/cntinfo/cntemail!=''">
						<electronicMailAddress>
							<xsl:value-of select="metainfo/metc/cntinfo/cntemail"/>
						</electronicMailAddress>
					</xsl:if>
				</metadataProvider>
				<xsl:if test="idinfo/datacred">
					<associatedParty>
						<xsl:for-each select="idinfo/datacred"><!-- this correspondence drawn from G. Lienkamper experience: no address associated -->
							<organizationName>
								<xsl:value-of select="."/>
							</organizationName>
						</xsl:for-each>
						<role><xsl:value-of select="'Credit for the dataset'"/> </role>
					</associatedParty>
				</xsl:if>
				<pubDate>
					<xsl:value-of select="idinfo/citation/citeinfo/pubdate"/><!-- pubDate is mandatory in BDP, no room in EML for pubTime. -->
				</pubDate>	       
				<abstract>
					<para>
						<literalLayout>
							<xsl:value-of select="idinfo/descript/abstract"/> <!-- abstract is mandatory in BDP,so is purpose-->
						</literalLayout>
					</para>
				</abstract>
				
				<keywordSet>	<!-- do they come comma separated? -->
				
					<xsl:for-each select="idinfo/keywords/theme/themekey"><!-- theme kywds are mandatory, but the rest are optional, we'll put an if clause before print -->
						<keyword>
							<xsl:attribute name="keywordType">
								<xsl:value-of select="'theme'"/>
							</xsl:attribute>
							<xsl:value-of select="."/>
						</keyword>
					</xsl:for-each>

					<xsl:if test="dataqual/lineage/method/methodid/methkt!=''"><!-- are there methodology keywords?-->
						<keyword>
							<xsl:attribute name="keywordType">
								<xsl:value-of select="'theme'"/>
							</xsl:attribute>
							<xsl:value-of select="dataqual/lineage/method/methodid/methkt"/>
						</keyword>
					</xsl:if>
					<xsl:if test="dataqual/lineage/method/methodid/methkey">
						<keyword>
							<xsl:attribute name="keywordType">
								<xsl:value-of select="'theme'"/>
							</xsl:attribute>
							<xsl:value-of select="dataqual/lineage/method/methodid/methkey"/>
						</keyword>					
					</xsl:if>
							

					<xsl:if test="idinfo/keywords/place/placekey!=''">
						<xsl:for-each select="idinfo/keywords/place/placekey">
							<keyword>
								<xsl:attribute name="keywordType">
									<xsl:value-of select="'place'"/>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</keyword>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="idinfo/keywords/stratum/stratkey!=''">
						<xsl:for-each select="idinfo/keywords/stratum/stratkey">
							<keyword>
								<xsl:attribute name="keywordType">
									<xsl:value-of select="'stratum'"/>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</keyword>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="idinfo/keywords/temporal/tempkey!=''">
						<xsl:for-each select="idinfo/keywords/temporal/tempkey">
							<keyword>
								<xsl:attribute name="keywordType">
									<xsl:value-of select="'temporal'"/>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</keyword>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="idinfo/taxonomy/keywtax/taxonkey!=''"><!-- this is mandatory if applicable, im adding a check before attempting to force output -->
						<xsl:for-each select="idinfo/taxonomy/keywtax/taxonkey"><!--sometimes, there are malformed FGDC, missing some intermidiate tags-->
							<keyword>
								<xsl:attribute name="keywordType">
									<xsl:value-of select="'taxonomic'"/>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</keyword>
						</xsl:for-each>
					</xsl:if>
				</keywordSet>
				<additionalInfo><!-- all here is optional, may need to check before placing this EML element whether at least one of the fields therein is populated in BDP, a if (  this OR this OR this OR..) typoe of statement -->
					<xsl:if test="idinfo/citation/citeinfo/edition!=''">
						<!--edition optional -->
						<section>
							<title>
								<xsl:value-of select="'Edition: Version of title'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/citation/citeinfo/edition"/>
								</literalLayout>
							</para>
						</section>
					</xsl:if>
				    <xsl:if test="idinfo/citation/citeinfo/geoform!=''">
						<!-- geoform optional -->
						<section>
							<title>
								<xsl:value-of select="'Data presentation form'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/citation/citeinfo/geoform"/>
								</literalLayout>
							</para>
						</section>
					</xsl:if>
					<xsl:if test="idinfo/citation/citeinfo/serinfo/sername!=''">
						<section>
							<title>
								<xsl:value-of select="'Series publication Identification and issue'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/citation/citeinfo/serinfo/sername"/>
								</literalLayout>
								<literalLayout>
									<xsl:value-of select="idinfo/citation/citeinfo/serinfo/issue"/>
								</literalLayout>
							</para>
						</section>
					</xsl:if>
					<xsl:if test="idinfo/citation/citeinfo/othercit!=''">
						<section>
							<title>
								<xsl:value-of select="'Other citation details'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/citation/citeinfo/othercit"/>
								</literalLayout>
							</para>
						</section>
					</xsl:if>
				    <xsl:if test="idinfo/descript/supplinf!=''">
						<section>
							<title>
								<xsl:value-of select="'Other descriptive Information about the data set'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/descript/supplinf"/>
								</literalLayout>
							</para>
						</section>
				    </xsl:if>
				    <xsl:if test="idinfo/browse/browsen!=''">
						<section>
							<title>
								<xsl:value-of select="'browse'"/>
							</title>
							<xsl:for-each select="idinfo/browse">
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
				<intellectualRights>
					<section>
						<title>
							<xsl:value-of select="'Access constraints'"/>
						</title>
						<para>
							<literalLayout>
								<xsl:value-of select="idinfo/accconst"/><!-- mandatory in BDP, only once per doc -->
							</literalLayout>
						</para>
					</section>
					<section>
						<title>
							<xsl:value-of select="'Use Constraints'"/>
						</title>
						<para>
							<literalLayout>
								<xsl:value-of select="idinfo/useconst"/>
							</literalLayout>
						</para>
					</section>
					<xsl:if test="idinfo/secinfo/secsys!=''"><!-- optional in BDP, check first -->
						<section>
							<title>
								<xsl:value-of select="'Security Classification'"/>
							</title>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/secinfo/secsys"/>
								</literalLayout>
							</para>
							<para>
								<literalLayout>
									<xsl:value-of select="idinfo/secinfo/secclass"/>
								</literalLayout>
							</para>
								<para>
									<literalLayout>
										<xsl:value-of select="idinfo/secinfo/sechandl"/>
									</literalLayout>
							</para>
						</section>
					</xsl:if>
					<xsl:if test="distinfo/disliab!=''">
						<section>
							<title>
								<xsl:value-of select="'Distribution Liability'"/>
							</title>
							<para>
								<xsl:for-each select="distinfo">
									<literalLayout>
										<xsl:value-of select="distliab"/>
									</literalLayout>
								</xsl:for-each>
							</para>
						</section>
					</xsl:if>
				</intellectualRights>
				<xsl:for-each select="idinfo/citation/citeinfo/onlink"><!-- repeatable-->
					<distribution>
						<online>
							<url>
								<xsl:value-of select="."/><!-- it may be wise to actually check for http, ftp, within the content before trying to translate it?..-->
							</url>
						</online>
					</distribution>
				</xsl:for-each>
				<xsl:if test="distinfo/stdorder/digform/digtopt/onlinopt/computer/networka/networkr!=''">
					<xsl:for-each select="distinfo/stdorder/digform/digtopt/onlinopt/computer/networka/networkr">
						<distribution>
							<online>
								<url>
									<xsl:value-of select="."/>
								</url>
							</online>
						</distribution>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="distinfo/stdorder/digform/digtopt/offoptn/offmedia!=''">
					<xsl:for-each select="distinfo/stdorder/digform/digtopt/offoptn">
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
				<coverage>
					<geographicCoverage>
					<!-- mandatory in BDP: description and coordinates-->
						<geographicDescription>
							<xsl:value-of select="idinfo/spdom/descgeog"/>
						</geographicDescription>
						<boundingCoordinates>
							<westBoundingCoordinate>
								<xsl:value-of select="idinfo/spdom/bounding/westbc"/>
							</westBoundingCoordinate>
							<eastBoundingCoordinate>
								<xsl:value-of select="idinfo/spdom/bounding/eastbc"/>
							</eastBoundingCoordinate>
							<northBoundingCoordinate>
								<xsl:value-of select="idinfo/spdom/bounding/northbc"/>
							</northBoundingCoordinate>
							<southBoundingCoordinate>
								<xsl:value-of select="idinfo/spdom/bounding/southbc"/>
							</southBoundingCoordinate>
							<xsl:if test="idinfo/spdom/bounding/boundalt/altmin!=''">
								<boundingAltitudes>
									<altitudeMinimum>
										<xsl:value-of select="idinfo/spdom/bounding/boundalt/altmin"/>
									</altitudeMinimum>
									<xsl:if test="idinfo/spdom/bounding/boundalt/altmax!=''">
										<altitudeMaximum>
											<xsl:value-of select="idinfo/spdom/bounding/boundalt/altmax"/>
										</altitudeMaximum>
									</xsl:if>
									<xsl:if test="idinfo/spdom/bounding/boundalt/altunits!=''">
										<altitudeUnits>
											<xsl:value-of select="idinfo/spdom/bounding/boundalt/altunits"/>
										</altitudeUnits>
									</xsl:if>
								</boundingAltitudes>
							</xsl:if>
						</boundingCoordinates>
						<xsl:for-each select="idinfo/spdom/dsgpoly">
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
							<xsl:when test="idinfo/timeperd/timeinfo/sngdate/caldate!=''">
								<singleDateTime>
									<!-- mandatory in BDP -->
									<calendarDate><!--FGDC date example 19990429 -->  <!-- defenitely, needs check ups-->
										<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/caldate"/><!-- normalize date type routine call needed-->
									</calendarDate>
									<xsl:if test="idinfo/timeperd/timeinfo/sngdate/time!=''">
										<time>
											<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/time"/>
										</time>
									</xsl:if>
								</singleDateTime>
							</xsl:when>
							<xsl:when test="idinfo/timeperd/timeinfo/mdattim/sngdate/caldate!=''">
								<xsl:for-each select="idinfo/timeperd/timeinfo/mdattim/sngdate">
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
							<xsl:when test="idinfo/timeperd/timeinfo/sngdate/geolage/geolscal!=''">
								<alternativeTimeScale>
									<timeScaleName>
										<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolscal"/>
									</timeScaleName>
									<timeScaleAgeEstimate>
										<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolest"/>
									</timeScaleAgeEstimate>
									<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolun!=''">
										<timeScaleAgeUncertainty>
											<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolun"/>
										</timeScaleAgeUncertainty>
									</xsl:if>
									<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolexpl!=''">
										<timeScaleAgeExplanation>
											<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolexpl"/>
										</timeScaleAgeExplanation>
									</xsl:if>
									<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/title!=''">
										<timeScaleCitation>
											<title>
												<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/title"/>
											</title>
											<creator>
												<!-- the perl code?-->
												<organizationName>
													<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/origin"/>
												</organizationName>
											</creator>
											<pubDate>
												<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubdate"/>
											</pubDate>
											<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/serinfo/sername!=''">
												<series>
													<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/serinfo/sername"/>
												</series>
											</xsl:if>
											<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/onlink!=''">
												<distribution>
													<online>
														<url>
															<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/onlink"/>
														</url>
													</online>
												</distribution>
											</xsl:if>
											<generic>
												<publisher>		<!-- note: this is the only required element for the alternative time scale citation in EML. in BDP is mandatory if applicable, so default to creator value if that doesnt work -->
													<xsl:choose>
														<xsl:when test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/pubplace!=''">
															<organizationName>
																<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
															<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/publish">
																<organizationName>
																	<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/pubinfo/publish"/>
																</organizationName>
															</xsl:if>
														</xsl:when>
														<xsl:otherwise>
															<organizationName>
																<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/origin"/>
															</organizationName>
														</xsl:otherwise>
													</xsl:choose>
												</publisher>
												<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/geoform!=''">
													<referenceType>
														<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/geoform"/>
													</referenceType>
												</xsl:if>
												<xsl:if test="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/edition!=''">
													<edition>
														<xsl:value-of select="idinfo/timeperd/timeinfo/sngdate/geolage/geolcit/citeinfo/edition"/>
													</edition>
												</xsl:if>
											</generic>
										</timeScaleCitation>
									</xsl:if>
								</alternativeTimeScale>
							</xsl:when>
							<xsl:when test="idinfo/timeperd/timeinfo/mdattim/sngdate/geolage/geolscal!=''">
								<xsl:for-each select="idinfo/timeperd/timeinfo/mdattim">
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
							<xsl:when test="idinfo/timeperd/timeinfo/rngdates/begdate!=''">
								<rangeOfDates>
									<beginDate>
										<calendarDate>
											<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/begdate"/><!-- normalize date type routine call needed-->
										</calendarDate>
										<xsl:if test="idinfo/timeperd/timeinfo/rngdates/begtime!=''">
											<time>
												<xsl:value-of select="."/>
											</time>
										</xsl:if>
									</beginDate>
									<endDate>
										<calendarDate>
											<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/enddate"/><!-- normalize date type routine call neededFRequently is "present" "ongoing" and the like-->
										</calendarDate>
										<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endtime!=''">
											<time>
												<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endtime"/>
											</time>
										</xsl:if>
									</endDate>
								</rangeOfDates>
							</xsl:when>
							<xsl:when test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolscal!=''"><!-- it will get to this case when hell freezes over, but... -->
								<rangeOfDates>
									<beginDate>
										<alternativeTimeScale>
											<timeScaleName>
												<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolscal"/>
											</timeScaleName>
											<timeScaleAgeEstimate>
												<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolest"/>
											</timeScaleAgeEstimate>
											<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolun!=''">
												<timeScaleAgeUncertainty>
													<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolun"/>
												</timeScaleAgeUncertainty>
											</xsl:if>
											<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolexpl!=''">
												<timeScaleAgeExplanation>
													<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolexpl"/>
												</timeScaleAgeExplanation>
											</xsl:if>
											<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/title">
												<timeScaleCitation>
													<title>
														<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/title"/>
													</title>
													<creator>
														<organizationName>
															<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/origin"/>
														</organizationName>
													</creator>
													<pubDate>
														<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/pubdate"/>
													</pubDate>
													<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/serinfo/sername!=''">
														<series>
															<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/serinfo/sername"/>
														</series>
													</xsl:if>
													<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/onlink!=''">
														<distribution>
															<online>
																<url>
																	<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/onlink"/>
																</url>
															</online>
														</distribution>
													</xsl:if>
													<generic>
														<publisher>
															<organizationName>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/pubinfo/publish"/>
															</organizationName>
															<organizationName>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
														</publisher>
														<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/geoform!=''">
															<referenceType>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/geoform"/>
															</referenceType>
														</xsl:if>
														<xsl:if test="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/edition!=''">
															<edition>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/beggeol/geolage/geolcit/citeinfo/edition"/>
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
												<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolscal"/>
											</timeScaleName>
											<timeScaleAgeEstimate>
												<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolest"/>
											</timeScaleAgeEstimate>
											<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolun!=''">
												<timeScaleAgeUncertainty>
													<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolun"/>
												</timeScaleAgeUncertainty>
											</xsl:if>
											<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolexpl!=''">
												<timeScaleAgeExplanation>
													<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolexpl"/>
												</timeScaleAgeExplanation>
											</xsl:if>
											<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/title!=''">
												<timeScaleCitation>									
													<title>
														<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/title"/>
													</title>
													<creator>
														<organizationName>
															<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/origin"/>
														</organizationName>
													</creator>
													<pubDate>
														<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/pubdate"/>
													</pubDate>
													<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/serinfo/sername!=''">
														<series>
															<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/serinfo/sername"/>
														</series>
													</xsl:if>
													<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/onlink!=''">
														<distribution>
															<online>
																<url>
																	<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/onlink"/>
																</url>
															</online>
														</distribution>
													</xsl:if>
													<generic>
														<publisher>
															<organizationName>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/pubinfo/publish"/>
															</organizationName>
															<organizationName>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
														</publisher>
														<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/geoform!=''">
															<referenceType>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/geoform"/>
															</referenceType>
														</xsl:if>
														<xsl:if test="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/edition!=''">
															<edition>
																<xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/endgeol/geolage/geolcit/citeinfo/edition"/>
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
					<xsl:if test="idinfo/taxonomy/taxoncl/taxonrn">
						<taxonomicCoverage>
							<xsl:if test="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/title!=''">	
								<taxonomicSystem>
									<classificationSystem>
										<classificationSystemCitation>
											<title>
												<xsl:value-of select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/title"/>
											</title>
											<creator>
												<organizationName>
													<xsl:value-of select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/origin"/>
												</organizationName>
											</creator>
											<pubDate>
												<xsl:value-of select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/pubdate"/>
											</pubDate>
											<xsl:if test="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/serinfo/sername!=''">
												<series>
													<xsl:value-of select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/serinfo/sername"/>
												</series>
											</xsl:if>
											<generic>
												<publisher>
													<xsl:choose>
														<xsl:when test="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/pubinfo/pubplace!=''">
															<organizationName>
																<xsl:value-of select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/pubinfo/pubplace"/>
															</organizationName>
															<xsl:if test="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/pubinfo/publish!=''">
																<organizationName>
																	<xsl:value-of select="."/>
																</organizationName>
															</xsl:if>														
														</xsl:when>
														<xsl:otherwise>
															<organizationName>
																<xsl:value-of select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo/origin"/>
															</organizationName>														
														</xsl:otherwise>
													</xsl:choose>
												</publisher>
											</generic>
										</classificationSystemCitation>
									</classificationSystem>
									<xsl:if test="idinfo/taxonomy/taxonsys/idref/citeinfo/title!=''"><!-- this is OK cause is optional in EML -->
										<identificationReference>
											<title>
												<xsl:value-of select="idinfo/taxonomy/taxonsys/idref/citeinfo/title"/>
											</title>
											<creator>
												<organizationName>
													<xsl:value-of select="idinfo/taxonomy/taxonsys/idref/citeinfo/origin"/>
												</organizationName>
											</creator>
											<pubDate>
												<xsl:value-of select="idinfo/taxonomy/taxonsys/idref/citeinfo/pubdate"/>
											</pubDate>
											<xsl:if test="idinfo/taxonomy/taxonsys/idref/citeinfo/serinfo/sername!=''">
												<series>
													<xsl:value-of select="idinfo/taxonomy/taxonsys/idref/citeinfo/serinfo/sername"/>
												</series>
											</xsl:if>
										</identificationReference>
									</xsl:if>
									<xsl:choose><!-- Identifier mandatory in EML, while it is optional in EML, choose alternative -->
										<xsl:when test="idinfo/taxonomy/taxonsys/ider/citeinfo/origin!=''">
											<identifierName>
												<organizationName>
													<xsl:value-of select="idinfo/taxonomy/taxonsys/ider/citeinfo/origin"/>
												</organizationName>
												<xsl:if test="idinfo/taxonomy/taxonsys/ider/citeinfo/pubdate">
													<pubDate>
														<xsl:value-of select="idinfo/taxonomy/taxonsys/ider/citeinfo/pubdate"/>
													</pubDate>
												</xsl:if>
												<xsl:if test="idinfo/taxonomy/taxonsys/ider/citeinfo/serinfo/sername!=''">
													<series>
														<xsl:value-of select="idinfo/taxonomy/taxonsys/ider/citeinfo/serinfo/sername"/>
													</series>
												</xsl:if>
											</identifierName>
										</xsl:when>
										<xsl:otherwise>
											<identifierName>
												<organizationName>
													<xsl:value-of select="'Identifier Not provided in Original Metadata Document'"/>
												</organizationName>
											</identifierName>
										</xsl:otherwise>
									</xsl:choose>
				
									
									<xsl:if test="idinfo/taxonomy/taxonsys/taxonpro!=''">
										<taxonomicProcedures>
											<xsl:value-of select="idinfo/taxonomy/taxonsys/taxonpro"/>
										</taxonomicProcedures>
									</xsl:if>
									<xsl:if test="idinfo/taxonomy/taxonsys/taxoncom!=''">
										<taxonomicCompleteness>
											<xsl:value-of select="idinfo/taxonomy/taxonsys/taxoncom"/>
										</taxonomicCompleteness>
									</xsl:if>
									<xsl:if test="idinfo/taxonomy/taxonsys/vouchers/specimen!=''">
										<vouchers>
											<specimen>
												<xsl:value-of select="idinfo/taxonomy/taxonsys/vouchers/specimen"/>
											</specimen>
											<xsl:if test="idinfo/taxonomy/taxonsys/vouchers/reposit!=''">
												<xsl:for-each select="idinfo/taxonomy/taxonsys/vouchers/reposit">
													<repository>
														<originator>
															<xsl:if test="cntinfo/cntperp/cntper!=''">
																<individualName>
																	<!-- perl here-->
																	<surName>
																		<xsl:value-of select="cntinfo/cntperp/cntper"/>
																	</surName>
																</individualName>
															</xsl:if>
															<xsl:if test="cntinfo/cntperp/cntorg!=''">
																<organizationName>
																	<xsl:value-of select="cntinfo/cntperp/cntorg"/>
																</organizationName>
															</xsl:if>
															<xsl:if test="cntinfo/cntorgp/cntorg!=''">
																<organizationName>
																	<xsl:value-of select="cntinfo/cntorgp/cntorg"/>
																</organizationName>
															</xsl:if>
															<xsl:if test="cntinfo/cntpos!=''">
																<positionName>
																	<xsl:value-of select="cntinfo/cntpos"/>
																</positionName>
															</xsl:if>
															<address>
																<xsl:if test="cntinfo/cntaddr/address!=''">
																	<deliveryPoint>
																		<xsl:value-of select="cntinfo/cntaddr/address"/>
																	</deliveryPoint>
																</xsl:if>
																<city>
																	<xsl:value-of select="cntinfo/cntaddr/city"/>
																</city>
																<administrativeArea>
																	<xsl:value-of select="cntinfo/cntaddr/state"/>
																</administrativeArea>
																<postalCode>
																	<xsl:value-of select="cntinfo/cntaddr/postal"/>
																</postalCode>
																<xsl:if test="cntinfo/cntaddr/country">
																	<country>
																		<xsl:value-of select="cntinfo/cntaddr/country"/>
																	</country>
																</xsl:if>
															</address>
															<xsl:if test="cntinfo/cntvoice!=''">
																<phone>
																	<xsl:attribute name="phonetype">
																		<xsl:value-of select="'voice'"/>
																	</xsl:attribute>
																	<xsl:value-of select="cntinfo/cntvoice"/>
																</phone>
															</xsl:if>
															<xsl:if test="cntinfo/cntfax!=''">
																<phone>
																	<xsl:attribute name="phonetype">
																		<xsl:value-of select="'fax'"/>
																	</xsl:attribute>
																	<xsl:value-of select="cntinfo/cntfax"/>
																</phone>
															</xsl:if>
															<xsl:if test="cntinfo/cntemail!=''">
																<electronicMailAddress>
																	<xsl:value-of select="cntinfo/cntemail"/>
																</electronicMailAddress>
															</xsl:if>
														</originator>
													</repository>
												</xsl:for-each>
											</xsl:if>
										</vouchers>
									</xsl:if>
								</taxonomicSystem>
							</xsl:if>
							<xsl:for-each select="idinfo/taxonomy/taxoncl">
								<taxonomicClassification>
									<taxonRankName>
										<xsl:value-of select="taxonrn"/>
									</taxonRankName>
									<taxonRankValue>
										<xsl:value-of select="taxonrv"/>
									</taxonRankValue>
									<xsl:if test="common!=''">
										<xsl:for-each select="common">
											<commonName>
												<xsl:value-of select="."/>
											</commonName>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="taxoncl/taxonrn!=''">
										<xsl:for-each select="taxoncl">
											<taxonomicClassification>
												<taxonRankName>
													<xsl:value-of select="taxonrn"/>
												</taxonRankName>
												<taxonRankValue>
													<xsl:value-of select="taxonrv"/>
												</taxonRankValue>
												<xsl:if test="common!=''">
													<xsl:for-each select="common">
														<commonName>
															<xsl:value-of select="."/>
														</commonName>
													</xsl:for-each>
												</xsl:if>
											</taxonomicClassification>
										</xsl:for-each>
									</xsl:if>
								</taxonomicClassification>
							</xsl:for-each>
						</taxonomicCoverage>
					</xsl:if>
				</coverage>
				<purpose>
					<para>
						<xsl:for-each select="idinfo/descript/purpose"><!-- mandatory in DBP-->
							<literalLayout>
								<xsl:value-of select="."/>
							</literalLayout>
						</xsl:for-each>
					</para>
				</purpose>
				<maintenance><!--this is mandatory in BDP -->
					<description>
						<section>
						<title><xsl:value-of select="'Progress'"/></title>
						<para>
							<xsl:for-each select="idinfo/status/progress">
								<literalLayout>
									<xsl:value-of select="."/>
								</literalLayout>
							</xsl:for-each>
						</para>
						</section>
						<section>
							<title><xsl:value-of select="'Update'"/>  </title>
							<para>
								<xsl:for-each select="idinfo/status/update">
									<literalLayout>
										<xsl:value-of select="."/>
									</literalLayout>
								</xsl:for-each>
							</para>
						</section>
					</description>
					<xsl:for-each select="idinfo">
						<xsl:for-each select="status">
							<xsl:for-each select="update"><!-- weak proposal here, should review: EML has enumerated fields -->
								<maintenanceUpdateFrequency><xsl:value-of select="'otherMaintenancePeriod'"/></maintenanceUpdateFrequency>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:for-each>
				</maintenance>
				<!-- here it comes the first major trouble: point of contact is "optional" in BDP, yet mandatory in EML. give second choices (creator, or met. provider) -->
				
				<contact>
					<xsl:choose>
						<xsl:when test="idinfo/ptcontac/cntinfo/cntperp/cntper!=''">
							<individualName>
								<surName>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntperp/cntper"/><!-- perl code here-->
								</surName>
							</individualName>						
						</xsl:when>
						<xsl:when test="idinfo/ptcontac/cntinfo/cntperp/cntorg!=''">
							<organizationName>
								<xsl:value-of select="idinfo/ptcontac/cntinfo/cntperp/cntorg"/>
							</organizationName>
						</xsl:when>
						<xsl:when test="idinfo/ptcontac/cntinfo/cntorgp/cntorg!=''">
							<organizationName>
								<xsl:value-of select="idinfo/ptcontac/cntinfo/cntorgp/cntorg"/>
							</organizationName>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntorgp/cntper!=''">
								<individualName>
									<surName><xsl:value-of select="idinfo/ptcontac/cntinfo/cntorgp/cntper"/></surName><!-- perl code here-->
								</individualName>
							</xsl:if>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntpos!=''">
								<positionName>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntpos"/>
								</positionName>
							</xsl:if>
						</xsl:when>
						<xsl:when test="idinfo/ptcontac/cntinfo/cntpos!=''">
							<positionName>
								<xsl:value-of select="idinfo/ptcontac/cntinfo/cntpos"/>
							</positionName>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="idinfo/citation/citeinfo/originIndividualName/originLastName!=''">
								<xsl:for-each select="idinfo/citation/citeinfo/originIndividualName">		
									<individualName>								
										<xsl:for-each select="originGivenName"><!-- first names AND middle names-->
											<givenName>
												<xsl:value-of select="."/>
											</givenName>
										</xsl:for-each>
										<surName>						     <!-- one last name per individual -->
											<xsl:value-of select="originLastName"/>
										</surName>	
									</individualName>		
								</xsl:for-each>			
							</xsl:if>
							<xsl:if test="idinfo/citation/citeinfo/originOrg!=''">
								<xsl:for-each select="idinfo/citation/citeinfo/originOrg">
									<organizationName>
										<xsl:value-of select="."/>
									</organizationName>
								</xsl:for-each>
							</xsl:if>					
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:if test="idinfo/ptcontac/cntinfo/cntaddr/city!=''">			
						<address>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntaddr/address!=''">
								<deliveryPoint>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/address"/>
								</deliveryPoint>
							</xsl:if>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntaddr/city!=''">
								<city>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/city"/>
								</city>
							</xsl:if>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntaddr/state!=''">
								<administrativeArea>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/state"/>
								</administrativeArea>
							</xsl:if>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntaddr/postal!=''">
								<postalCode>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/postal"/>
								</postalCode>
							</xsl:if>
							<xsl:if test="idinfo/ptcontac/cntinfo/cntaddr/country!=''">
								<country>
									<xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/country"/>
								</country>
							</xsl:if>
						</address>
					</xsl:if>

					<xsl:if test="idinfo/ptcontac/cntinfo/cntvoice!=''">
						<phone>
							<xsl:attribute name="phonetype">
								<xsl:value-of select="'voice'"/>
							</xsl:attribute>
							<xsl:value-of select="idinfo/ptcontac/cntinfo/cntvoice"/>
						</phone>
					</xsl:if>
					<xsl:if test="idinfo/ptcontac/cntinfo/cntfax!=''">
						<phone>
							<xsl:attribute name="phonetype">
								<xsl:value-of select="'fax'"/>
							</xsl:attribute>
							<xsl:value-of select="idinfo/ptcontac/cntinfo/cntfax"/>
						</phone>
					</xsl:if>
					<xsl:if test="idinfo/ptcontac/cntinfo/cntemail!=''">
						<electronicMailAddress>
							<xsl:value-of select="idinfo/ptcontac/cntinfo/cntemail"/>
						</electronicMailAddress>
					</xsl:if>
				</contact>
				<xsl:choose>
					<xsl:when test="distinfo/distrib/cntinfo/cntperp/cntper">
						<contact><!-- put big if around this, then movr on to publisher hEEERRREEE-->
							<xsl:for-each select="distinfo/distrib/cntinfo/cntperp">
								<individualName>
									<surName>
										<xsl:value-of select="cntpe"/>
									</surName>
								</individualName>
								<xsl:if test="cntorg">
									<organizationName>
										<xsl:value-of select="cntorg"/>
									</organizationName>
								</xsl:if>
								<xsl:if test="../cntpos">
									<positionName>
										<xsl:value-of select="../cntpos"/>
									</positionName>
								</xsl:if>
							</xsl:for-each>
							<address>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/address!=''">
									<deliveryPoint>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/address"/>
									</deliveryPoint>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/city!=''">
									<city>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/city"/>
									</city>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/state!=''">
									<administrativeArea>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/state"/>
									</administrativeArea>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/postal!=''">
									<postalCode>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/postal"/>
									</postalCode>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/country!=''">
									<country>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/country"/>
									</country>
								</xsl:if>
							</address>
							<xsl:if test="distinfo/distrib/cntinfo/cntvoice!=''">
								<phone>
									<xsl:attribute name="phonetype">
										<xsl:value-of select="'voice'"/>
									</xsl:attribute>
									<xsl:value-of select="distinfo/distrib/cntinfo/cntvoice"/>
								</phone>
							</xsl:if>
							<xsl:if test="distinfo/distrib/cntinfo/cntfax!=''">
								<phone>
									<xsl:attribute name="phonetype">
										<xsl:value-of select="'fax'"/>
									</xsl:attribute>
									<xsl:value-of select="distinfo/distrib/cntinfo/cntfax"/>
								</phone>
							</xsl:if>
							<xsl:if test="distinfo/distrib/cntinfo/cntemail!=''">
								<electronicMailAddress>
									<xsl:value-of select="distinfo/distrib/cntinfo/cntemail"/>
								</electronicMailAddress>
							</xsl:if>
						</contact>
					</xsl:when>
					<xsl:when test="distinfo/distrib/cntinfo/cntorgp/cntorg">
						<contact>
							<xsl:for-each select="distinfo/distrib/cntinfo/cntorgp">
								<xsl:if test="cntper">
									<individualName>
										<surName><xsl:value-of select="cntper"/></surName>
									</individualName>
								</xsl:if>
								<organizationName>
									<xsl:value-of select="cntorg"/>
								</organizationName>
								<xsl:if test="../cntpos">
									<positionName>
										<xsl:value-of select="../cntpos"/>
									</positionName>
								</xsl:if>
							</xsl:for-each>
							<address>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/address!=''">
									<deliveryPoint>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/address"/>
									</deliveryPoint>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/city!=''">
									<city>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/city"/>
									</city>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/state!=''">
									<administrativeArea>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/state"/>
									</administrativeArea>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/postal!=''">
									<postalCode>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/postal"/>
									</postalCode>
								</xsl:if>
								<xsl:if test="distinfo/distrib/cntinfo/cntaddr/country!=''">
									<country>
										<xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/country"/>
									</country>
								</xsl:if>
							</address>
							<xsl:if test="distinfo/distrib/cntinfo/cntvoice!=''">
								<phone>
									<xsl:attribute name="phonetype">
										<xsl:value-of select="'voice'"/>
									</xsl:attribute>
									<xsl:value-of select="distinfo/distrib/cntinfo/cntvoice"/>
								</phone>
							</xsl:if>
							<xsl:if test="distinfo/distrib/cntinfo/cntfax!=''">
								<phone>
									<xsl:attribute name="phonetype">
										<xsl:value-of select="'fax'"/>
									</xsl:attribute>
									<xsl:value-of select="distinfo/distrib/cntinfo/cntfax"/>
								</phone>
							</xsl:if>
							<xsl:if test="distinfo/distrib/cntinfo/cntemail!=''">
								<electronicMailAddress>
									<xsl:value-of select="distinfo/distrib/cntinfo/cntemail"/>
								</electronicMailAddress>
							</xsl:if>
						</contact>
					</xsl:when>
				</xsl:choose>
				<publisher>
					<individualName>
						<xsl:for-each select="idinfo/citation/citeinfo/pubinfo/publish"><!--  break in parts? perl?-->
							<surName>
								<xsl:value-of select="."/>
							</surName>
						</xsl:for-each>
					</individualName>
					<xsl:for-each select="idinfo/citation/citeinfo/pubinfo/publish">
						<organizationName>
							<xsl:value-of select="."/>
						</organizationName>
					</xsl:for-each>
					<address>
						<xsl:for-each select="idinfo/citation/citeinfo/pubinfo/pubplace"><!-- according to FGDC, the city or the city AND state, zip,etc -->
							<city>
								<xsl:value-of select="."/>
							</city>
						</xsl:for-each><!-- may want to attempt to break up into state, ZIP and country, need be. Acall to a comma separator routine.-->
					</address>
				</publisher>
				<xsl:for-each select="idinfo/citation/citeinfo/pubinfo/pubplace">
					<pubPlace>
						<xsl:value-of select="."/>
					</pubPlace>
				</xsl:for-each>
				<xsl:if test=" dataqual/lineage| idinfo/tool/tooldesc "><!-- this tests whether there's a dataqual/lineage or a idinfo/tool/tooldesc path -->
					<methods>
						<xsl:if test="dataqual/lineage/method/methtype!=''">
							<methodStep>
								<description>
									<section>
										<title>
											<xsl:value-of select="'Methodology Type'"/>
										</title>
										<para>
											<xsl:for-each select="dataqual/lineage/method/methtype">
												<literalLayout>
													<xsl:value-of select="."/>
												</literalLayout>
											</xsl:for-each>
										</para>
									</section>
								</description>
							</methodStep>
						</xsl:if>
						<xsl:if test="dataqual/lineage/method/methodid/methkt">
							<methodStep>
								<description>
									<section>
										<title>
											<xsl:value-of select="'Methodology Keywords'"/>
										</title>
										<para>
											<xsl:for-each select="dataqual/lineage/method/methodid/methkt">
												<literalLayout>
													<xsl:value-of select="."/>
												</literalLayout>
											</xsl:for-each>
											<xsl:for-each select="dataqual/lineage/method/methodid/methkey">
												<literalLayout>
													<xsl:value-of select="."/>
												</literalLayout>
											</xsl:for-each>
										</para>
									</section>
								</description>
							</methodStep>
						</xsl:if>
						<methodStep>
							<description>
								<para>
									<xsl:for-each select="dataqual/lineage/method/methdesc">
										<literalLayout>
											<xsl:value-of select="."/>
										</literalLayout>
									</xsl:for-each>
								</para>
							</description>
							<xsl:if test="dataqual/lineage/method/methcite/citeinfo/title">
								<citation>
									<xsl:for-each select="dataqual/lineage/method/methcite/citeinfo/title">
										<title>
											<xsl:value-of select="."/>
										</title>
									</xsl:for-each>
									<creator>
										<xsl:for-each select="dataqual/lineage/method/methcite/citeinfo/origin">
											<organizationName>
												<xsl:value-of select="."/>
											</organizationName>
										</xsl:for-each>
									</creator>
									<associatedParty>
										<xsl:for-each select="dataqual/lineage/method/methcite/citeinfo/pubinfopublish">
											<organizationName>
												<xsl:value-of select="."/>
											</organizationName>
										</xsl:for-each>
										<xsl:for-each select="dataqual/lineage/method/methcite/citeinfo/pubinfo/pubplace">
											<organizationName>
												<xsl:value-of select="."/>
											</organizationName>
										</xsl:for-each>
										<positionName>
											<xsl:value-of select="'Method publisher'"/>
										</positionName>
										<role><xsl:value-of select="'Associated methodology publisher'"/>   </role>
									</associatedParty>
									<xsl:if test="dataqual/lineage/method/methcite/citeinfo/pubdate!=''">
										<pubDate>
											<xsl:value-of select="dataqual/lineage/method/methcite/citeinfo/pubdate"/>
										</pubDate>
									</xsl:if>
									<generic>
										<publisher>
											<organizationName>
												<xsl:value-of select="dataqual/lineage/method/methcite/citeinfo/origin"/>
											</organizationName>
										</publisher>
									</generic>
								</citation>
							</xsl:if>
						</methodStep>
						<xsl:if test="idinfo/tool/tooldesc!=''">
							<methodStep>
								<software>
									<title>
										<xsl:value-of select="'Analytical Tool'"/>	<!-- no title or name in BDP -->
									</title>
									<creator>
										<xsl:if test="idinfo/tool/toolcont/cntinfo/cntperp/cntper!=''"><!-- perl here?-->									
											<individualName>
												<surName>
													<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntperp/cntper"/>
												</surName>
											</individualName>
										</xsl:if>
										<xsl:if test="idinfo/tool/toolcont/cntinfo/cntperp/cntorg!=''">
											<organizationName>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntperp/cntorg"/>
											</organizationName>
										</xsl:if>
										<xsl:if test="idinfo/tool/toolcont/cntinfo/cntorgp/cntorg!=''">
											<organizationName>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntorgp/cntorg"/>
											</organizationName>
										</xsl:if>
										<xsl:if test="idinfo/tool/toolcont/cntinfo/cntorgp/cntper!=''"><!-- perl here?-->									
											<individualName>
												<surName>
													<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntorgp/cntper"/>
												</surName>
											</individualName>
										</xsl:if>
										<address>
											<xsl:if test="idinfo/tool/toolcont/cntinfo/cntaddr/address">											
												<xsl:for-each select="idinfo/tool/toolcont/cntinfo/cntaddr/address">
													<deliveryPoint>
														<xsl:value-of select="."/>
													</deliveryPoint>
												</xsl:for-each>
											</xsl:if>
											<city>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntaddr/city"/>
											</city>
											<administrativeArea>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntaddr/state"/>
											</administrativeArea>
											<postalCode>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntaddr/postal"/>
											</postalCode>
											<country>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntaddr/country"/>
											</country>
										</address>
										<phone>
											<xsl:attribute name="phonetype">
												<xsl:value-of select="'voice'"/>
											</xsl:attribute>
											<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntvoice"/>
										</phone>
										<xsl:if test="idinfo/tool/toolcont/cntinfo/cntfax!=''">
											<phone>
												<xsl:attribute name="phonetype">
													<xsl:value-of select="'fax'"/>
												</xsl:attribute>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntfax"/>
											</phone>
										</xsl:if>
										<xsl:if test="idinfo/tool/toolcont/cntinfo/cntemail!=''">
											<electronicMailAddress>
												<xsl:value-of select="idinfo/tool/toolcont/cntinfo/cntemail"/>
											</electronicMailAddress>
										</xsl:if>
									</creator>
									<abstract>
										<para>
											<xsl:value-of select="idinfo/tool/tooldesc"/>
											<xsl:value-of select="idinfo/tool/toolacc/toolinst"/>
										</para>
									</abstract>
									<distribution>
										<online>
											<xsl:for-each select="idinfo/tool/toolacc/onlink">
												<url><!-- it may be wise to actually check for http, ftp, within the content before trying to translate it?..-->
													<xsl:value-of select="."/>
												</url>
											</xsl:for-each>
										</online>
									</distribution>
									<implementation>
										<xsl:for-each select="idinfo/tool/toolacc/toolcomp">
											<operatingSystem>
												<xsl:value-of select="."/>
											</operatingSystem>
										</xsl:for-each>
									</implementation>
									<version><xsl:value-of select="'No automatically parseable info on tool version'"/> </version>
								</software>
							</methodStep>
						</xsl:if>
					</methods>
				</xsl:if>

				<access>	<!-- hard coded access rights scope="document" order="allowFirst" authSystem="knb"... may need to add further rights for metadata owner -->
				    <xsl:attribute name="scope"><xsl:value-of select="'document'"/></xsl:attribute>				    
				    <xsl:attribute name="order"><xsl:value-of select="'allowFirst'"/></xsl:attribute>
				    <xsl:attribute name="authSystem" ><xsl:value-of select="'knb'"/></xsl:attribute>
					<allow>
						<principal>
							<xsl:value-of select="'public'"/>
						</principal>
						<permission>
							<xsl:value-of select="'read'"/>
						</permission>
					</allow>
				</access>
				<xsl:choose>
					<xsl:when test="eainfo/detailed/enttyp"><!-- only is the detailed section of BDP's eainfo is present -->
						<xsl:for-each select="eainfo/detailed">
							<xsl:variable name="attributeListTMP"><xsl:number /> </xsl:variable>
							<dataTable>
								<entityName><!-- mandatory in both -->
									<xsl:value-of select="enttyp/enttypl"/>
								</entityName>
								<entityDescription>
									<xsl:value-of select="enttyp/enttypd"/>
								</entityDescription>
								<xsl:if test="../../distinfo/stdorder/digform/digtinfo">
									<physical>
										<objectName>
											<xsl:value-of select="enttyp/enttypl"/><!-- mandatory in both -->
										</objectName>
										<xsl:if test="../../distinfo/stdorder/digform/digtinfo/transize!=''">
											<size>
												<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/transize"/>
											</size>
										</xsl:if>
										<xsl:if test="../../distinfo/stdorder/digform/digtinfo/asciistr/authent!=''">
											<authentication>
												<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/authent"/>
											</authentication>
										</xsl:if>
										<xsl:if test="../../distinfo/stdorder/digform/digtinfo/filedec!=''">
											<compressionMethod>
												<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/filedec"/>
											</compressionMethod>
										</xsl:if>
										<xsl:if test="../../distinfo/stdorder/digform/digtinfo/formcont!=''">
											<characterEncoding>
												<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/formcont"/>
											</characterEncoding>
										</xsl:if>
										<dataFormat><!-- mandatorty in EML physical -->
											<xsl:choose>
												<xsl:when test="../../distinfo/stdorder/digform/digtinfo/asciistr">
													<textFormat>
														<xsl:if test="../../distinfo/stdorder/digform/digtinfo/asciistr/numheadl">
															<numHeaderLines>
																<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/numheadl"/>
															</numHeaderLines>
														</xsl:if>
														<xsl:if test="../../distinfo/stdorder/digform/digtinfo/asciistr/recdel">
															<recordDelimiter>
																<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/recdel"/>
															</recordDelimiter>
														</xsl:if>
														<xsl:if test="../../distinfo/stdorder/digform/digtinfo/asciistr/recdel">
															<physicalLineDelimiter>
																<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/recdel"/>
															</physicalLineDelimiter>
														</xsl:if>
														<xsl:choose>
															<xsl:when test="../../distinfo/stdorder/digform/digtinfo/asciistr/datafiel/dfwidthd">
																<maxRecordLength>
																	<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/datafiel/dfwidthd"/>
																</maxRecordLength>
															</xsl:when>
															<xsl:when test="../../distinfo/stdorder/digform/digtinfo/asciistr/datafiel/dfwidth">
																<maxRecordLength>
																	<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/datafiel/dfwidth"/>
																</maxRecordLength>
															</xsl:when>
														</xsl:choose>
														<xsl:if test="../../distinfo/stdorder/digform/digtinfo/asciistr/orienta">
															<attributeOrientation>
																<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/orienta"/>
															</attributeOrientation>
														</xsl:if>
														
														<simpleDelimited>
															<xsl:choose>
																<xsl:when test="../../distinfo/stdorder/digform/digtinfo/asciistr/recdel">
																	<fieldDelimiter>
																		<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/recdel"/>
																	</fieldDelimiter>
																</xsl:when>
																<xsl:otherwise>
																	<fieldDelimiter>
																		<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/datafiel/dfwidth"/>
																		<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/datafiel/dfwidthd"/>
																	</fieldDelimiter>
																</xsl:otherwise>
															</xsl:choose>
															<xsl:choose>
																<xsl:when test="../../distinfo/stdorder/digform/digtinfo/asciistr/quotech">
																	<quoteCharacter>
																		<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/asciistr/quotech"/>
																	</quoteCharacter>
																</xsl:when>
																<xsl:otherwise> 
																	<xsl:text> &quot; </xsl:text> 
																</xsl:otherwise><!-- to bail out non-validity, place usual character quote -->
															</xsl:choose>
														</simpleDelimited>
													</textFormat>
												</xsl:when>
												<xsl:when test="../../distinfo/stdorder/digform/digtinfo/formname">
													<externallyDefinedFormat>
														<formatName>
															<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/formname"/>
														</formatName>
														<xsl:if test="../../distinfo/stdorder/digform/digtinfo/formvern">
															<formatVersion>
																<xsl:value-of select="../../distinfo/stdorder/digform/digtinfo/formvern"/>
															</formatVersion>
														</xsl:if>
													</externallyDefinedFormat>
												</xsl:when>
											</xsl:choose>
										</dataFormat>
									</physical>
								</xsl:if>
								<attributeList>
									<xsl:attribute name="id"><xsl:value-of select="concat('attList',$attributeListTMP)"/>  </xsl:attribute><!-- used to reference in spatial elements, in reality, only 1 table in that case..-->
									<xsl:for-each select="attr">
										<attribute>
											<attributeName>
												<xsl:value-of select="attrlabl"/>
											</attributeName>
											<attributeLabel>
												<xsl:value-of select="attrlabl"/>
											</attributeLabel>
											<attributeDefinition>
												<xsl:value-of select="attrdef"/>
											</attributeDefinition>
											<measurementScale>
												<xsl:choose>
													<xsl:when test="attrdomv/edom/edomv">
														<nominal>
															<nonNumericDomain>
																<enumeratedDomain>
																	<xsl:for-each select="attrdomv/edom">
																		<codeDefinition>
																			<code>
																				<xsl:value-of select="edomv"/>
																			</code>
																			<definition>
																				<xsl:value-of select="edomvd"/>
																			</definition>
																			<source>
																				<xsl:value-of select="edomvds"/>
																			</source>
																		</codeDefinition>
																	</xsl:for-each>
																</enumeratedDomain>
															</nonNumericDomain>
														</nominal>
													</xsl:when>
													<xsl:when test="attrdomv/udom">
														<nominal>
															<nonNumericDomain>
																<textDomain>
																	<definition>
																		<xsl:value-of select="attrdomv/udom"/>
																	</definition>
																</textDomain>
															</nonNumericDomain>
														</nominal>
													</xsl:when>
													<xsl:when test="attrdomv/codesetd/codesetn">
														<ordinal>
															<nonNumericDomain>
																<enumeratedDomain>
																	<externalCodeSet>
																		<codesetName>
																			<xsl:value-of select="attrdomv/codesetd/codesetn"/>
																		</codesetName>
																		<citation>
																			<title>
																				<xsl:value-of select="attrdomv/codesetd/codesetn"/>
																			</title>
																			<creator>
																				<organizationName>
																					<xsl:value-of select="attrdomv/codesetd/codesets"/>
																				</organizationName>
																			</creator>
																			<generic>
																				<publisher>
																					<organizationName>
																						<xsl:value-of select="attrdomv/codesetd/codesets"/>
																					</organizationName>
																				</publisher>
																			</generic>
																		</citation>
																	</externalCodeSet>
																</enumeratedDomain>
															</nonNumericDomain>
														</ordinal>
													</xsl:when>
													<xsl:when test="attrdomv/rdom">
														<ratio>
															<unit>
																<xsl:choose>
																	<xsl:when test="attrdomv/rdom/attrunit">
																		<customUnit>
																			<xsl:value-of select="attrdomv/rdom/attrunit"/><!-- custom Unit dictionary? we would do much better using Perl....-->
																		</customUnit>
																	</xsl:when>
																	<xsl:otherwise>
																		<customUnit>
																			<xsl:value-of select="'unit not specified in original metadata format (BDP-FGDC)'"/><!-- custom Unit dictionary? -->
																		</customUnit>
																	</xsl:otherwise>
																</xsl:choose>
															</unit>
															<numericDomain>
																<numberType>
																	<xsl:value-of select="'real'"/><!-- good guess -->
																</numberType>
																<bounds>
																	<minimum>
																		<xsl:attribute name="exclusive">
																			<xsl:value-of select="'false'"/>
																		</xsl:attribute>
																		<xsl:value-of select="attrdomv/rdom/rdommin"/>
																	</minimum>
																	<maximum>
																		<xsl:attribute name="exclusive">
																			<xsl:value-of select="'false'"/>
																		</xsl:attribute>
																		<xsl:value-of select="attrdomv/rdom/rdommax"/>
																	</maximum>
																</bounds>
															</numericDomain>
														</ratio>
													</xsl:when>
												</xsl:choose>
											</measurementScale>
											<xsl:if test="attrvai">
												<accuracy>
													<attributeAccuracyReport>
														<xsl:value-of select="attrvai/attrvae"/>
													</attributeAccuracyReport>
													<quantitativeAttributeAccuracyAssessment>
														<attributeAccuracyValue>
															<xsl:value-of select="attrvai/attrva"/>
														</attributeAccuracyValue>
														<attributeAccuracyExplanation>
															<xsl:value-of select="attrvai/attrvae"/>
														</attributeAccuracyExplanation>
													</quantitativeAttributeAccuracyAssessment>
												</accuracy>
											</xsl:if>
										</attribute>
									</xsl:for-each>
								</attributeList>
							</dataTable>
						</xsl:for-each>
						<!--add a check before we go in here, becuase BDP is more lax than EML: we need eainfo/detailed (check!!) and spdoinfo/rastinfo-->
						<xsl:choose>
							<xsl:when test="spdoinfo/rastinfo">
								<spatialRaster>
									<entityName><!-- mandatory in both -->
										<xsl:value-of select="eainfo/detailed/enttyp/enttypl"/>
									</entityName>
									<entityDescription>
										<xsl:value-of select="eainfo/detailed/enttyp/enttypd"/>
									</entityDescription>				 <!-- physical, coverage, method maye be referenced here.-->
									<attributeList>				<!-- let's not reinvent the wheel -->
										<references>
											<xsl:value-of select="'attList1'"/> 
										</references>
									</attributeList>
									<spatialReference>
										<xsl:call-template name="spref"/>
									</spatialReference>
									<horizontalAccuracy>
										<xsl:choose>
											<xsl:when test="dataqual/possac/horizpa">
												<accuracyReport>
													<xsl:value-of select="dataqual/possac/horizpa/horizpar"/>
												</accuracyReport>
												<xsl:if test="dataqual/possac/horizpa/qhorizpa/horizpav">
													<quantitativeAccuracyReport>
														<quantitativeAccuracyvalue>
															<xsl:value-of select="dataqual/possac/horizpa/qhorizpa/horizpav"/>
														</quantitativeAccuracyvalue>
														<quantitativeAccuracyMethod>
															<xsl:value-of select="dataqual/possac/horizpa/qhorizpa/horizpae"/>										
														</quantitativeAccuracyMethod>
													</quantitativeAccuracyReport>
												</xsl:if>
											</xsl:when>
											<xsl:otherwise>
												<accuracyReport>
													<xsl:value-of select="'No report on accuracy provided in original metadata source'"/>
												</accuracyReport>
											</xsl:otherwise>
										</xsl:choose>
									</horizontalAccuracy>
									<verticalAccuracy>
										<xsl:choose>
											<xsl:when test="dataqual/possac/vertacc">
												<accuracyReport>
													<xsl:value-of select="dataqual/possac/vertacc/vertaccr"/>
												</accuracyReport>
												<xsl:if test="dataqual/possac/vertacc/qvertpa/vertaccv">
													<quantitativeAccuracyReport>
														<quantitativeAccuracyvalue>
															<xsl:value-of select="dataqual/possac/vertacc/qvertpa/vertaccv"/>
														</quantitativeAccuracyvalue>
														<quantitativeAccuracyMethod>
															<xsl:value-of select="dataqual/possac/vertacc/qvertpa/vertacce"/>										
														</quantitativeAccuracyMethod>
													</quantitativeAccuracyReport>
												</xsl:if>
											</xsl:when>
											<xsl:otherwise>
												<accuracyReport>
													<xsl:value-of select="'No report on accuracy provided in original metadata source'"/>
												</accuracyReport>
											</xsl:otherwise>
										</xsl:choose>					
									</verticalAccuracy>
									<xsl:choose><!-- the next tags have no obvious correspondence, both Geo. Lienkamper and John van de Castle helped fill in alternative content -->
									
										<xsl:when test="/metadata/spref/horizsys/planar/mapproj/spaceobq/landsat!=''">
											<cellSizeXDirection><!-- in ESRI, no problem, this stuff is a kid of rastinfo, but not in FGDC -->
												<xsl:comment> <xsl:value-of select="'Landsat data have special parameters not described in the original metadata standard'"/></xsl:comment>
												<xsl:value-of select="'Unknown'"/>
											</cellSizeXDirection>
											<cellSizeYDirection><!-- in ESRI, no problem, this stuff is a kid of rastinfo, but not in FGDC -->
												<xsl:comment> <xsl:value-of select="'Landsat data have special parameters not described in the original metadata standard'"/></xsl:comment>
												<xsl:value-of select="'Unknown'"/>
											</cellSizeYDirection>
										</xsl:when>
										<xsl:otherwise>
											<cellSizeXDirection><!-- in ESRI, no problem, this stuff is a kid of rastinfo, but not in FGDC -->
												<xsl:comment> <xsl:value-of select="'Unknown at the original metadata source, but by default, pixels are square in size,  X=Y'"/></xsl:comment>
											</cellSizeXDirection>
											<cellSizeYDirection><!-- in ESRI, no problem, this stuff is a kid of rastinfo, but not in FGDC -->
												<xsl:comment> <xsl:value-of select="'Unknown at the original metadata source, but by default, pixels are square in size,  X=Y'"/></xsl:comment>
											</cellSizeYDirection>
										</xsl:otherwise>
									</xsl:choose>
				
									<numberOfBands><!-- in ESRI, no problem, this stuff is a kid of rastinfo, but not in FGDC -->
										<xsl:comment><xsl:value-of select="'This information not registered in original metadata standard.'"/></xsl:comment>
										<xsl:value-of select="'Value Unknown. Information not registered in original metadata standard'"/>
									</numberOfBands>
									<xsl:comment>
											<xsl:value-of select="'RASTER ORIGIN: Unknown. Information not registered in original metadata standard, the default is usually Upper Left'"/><!-- enumerated values in EML, this is the best default -->									
									</xsl:comment>
									<rasterOrigin><xsl:text>Upper Left</xsl:text></rasterOrigin><!-- we have bigger problems here -->
									<xsl:for-each select="spdoinfo/rastinfo/rowcount">
										<rows>
											<xsl:value-of select="."/>
										</rows>
									</xsl:for-each>
									<xsl:for-each select="spdoinfo/rastinfo/colcount">
										<columns>
											<xsl:value-of select="."/>
										</columns>
									</xsl:for-each>
									<xsl:for-each select="spdoinfo/rastinfo/vrtcount">
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
							<!-- MOVE here the spatialVector below, aand place WHEN eainfo/detailed + spdoinfo/ptvctcnt test-->
							<xsl:when test="spdoinfo/ptvctcnt">
								<spatialVector>
									<xsl:for-each select="eainfo/detailed/enttyp/enttypl">
										<entityName>
											<xsl:value-of select="."/>
										</entityName>
									</xsl:for-each>
									<xsl:for-each select="spdoinfo/ptvctinf/sdtsterm/sdtstype">
										<entityDescription>
											<xsl:value-of select="."/>
										</entityDescription>
									</xsl:for-each>
									<additionalInfo>
										<para>
											<xsl:for-each select="spdoinfo/ptvctinf/vpfterm/vpfinfo/vpftype">
												<literalLayout>
													<xsl:value-of select="."/>
												</literalLayout>
											</xsl:for-each>
											<xsl:for-each select="spdoinfo/ptvctinf/vpfterm/vpfinfo/ptvctcnt">
												<literalLayout>
													<xsl:value-of select="."/>
												</literalLayout>
											</xsl:for-each>
										</para>
									</additionalInfo>
												 <!-- physical, coverage, method maye be referenced here.-->
									<attributeList><!-- let's not reinvent the wheel -->
										<references>
											<xsl:value-of select="'attList1'"/> 
										</references>
									</attributeList>
							
									<xsl:for-each select="spdoinfo/ptvctinf/sdtsterm/sdtstype">
										<geometry>
											<xsl:choose>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'string' )">
													<xsl:value-of select="'LineString'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'ring' )">
													<xsl:value-of select="'LinearRing'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'olygon') ">
													<xsl:value-of select="'polygon'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'chain') ">
													<xsl:value-of select="'polygon'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'point')">
													<xsl:value-of select="'point'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'node' )">
													<xsl:value-of select="'point'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'link' )">
													<xsl:value-of select="'LinearRing'"/>
												</xsl:when>
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'pline' ) "><!-- for Spline-->
													<xsl:value-of select="'polygon'"/>
												</xsl:when>			
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'arc' )">
													<xsl:value-of select="'polygon'"/>
												</xsl:when>						
												<xsl:when test="contains(spdoinfo/ptvctinf/sdtsterm/sdtstype,'ezier') "><!-- for Bezier-->
													<xsl:value-of select="'polygon'"/>
												</xsl:when>		
											</xsl:choose>
										</geometry>						
									</xsl:for-each>
									<xsl:for-each select="spdoinfo/ptvctinf/sdtsterm/ptvctcnt">
										<geometricObjectCount>
											<xsl:value-of select="."/>
										</geometricObjectCount>
									</xsl:for-each>
									<xsl:for-each select="spdoinfo/ptvctinf/vpfterm/vpflevel">
										<topologyLevel>
											<xsl:value-of select="."/>
										</topologyLevel>
									</xsl:for-each>
				
									<xsl:call-template name="spref"/>
							
								</spatialVector>
							</xsl:when>
							<xsl:otherwise>
								<!-- place all spdoinf spref  in additionalMetadata.. we'll redo the check in that section.-->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- if we do not have detailed info on attributes, we cannot use spdoinfo nor spref (spatial info) since in EML we need to detail the attributes within these -->
				</xsl:choose>
			</dataset>
			<xsl:if test="eainfo/overview"><!-- they did not really describe the data table in the desired level -->
				<additionalMetadata>
					<dataTableOverview>
						<xsl:text>Datatable attribute Information overview</xsl:text>
						<xsl:value-of select="eainfo/overview/eaover"/>
						<xsl:if test="eainfo/overview/eadecit">
							<xsl:text>Datatable attribute Information overview</xsl:text>
							<xsl:value-of select="eainfo/overview/eadetcit"/>
						</xsl:if>
					</dataTableOverview>
						<!-- add here spdoinfo if exists??-->
				</additionalMetadata>
				<xsl:if test="spdoinfo">
					<additionalMetadata>
						<spatialInfo>
							<xsl:for-each select="spdoinfo">
								<xsl:if test="indspref">
									<xsl:text>Spatial Info: Indirect Spatial Reference</xsl:text>
									<xsl:value-of select="indspref"/>
								</xsl:if>
								<xsl:if test="direct">
									<xsl:text>Spatial Info: Direct Reference Type</xsl:text>
									<xsl:value-of select="direct"/>
								</xsl:if>
								<xsl:if test="ptvctinf">
									<xsl:text>Spatial Info: Point Vector Info</xsl:text>
									<xsl:for-each select="ptvctinf">
										<xsl:if test="sdtsterm">
											<xsl:value-of select="sdtstype"/>
											<xsl:text>Count:</xsl:text>
											<xsl:value-of select="ptvctcnt"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="vpfterm">
									<xsl:for-each select="vpfterm">
										<xsl:text>Level:</xsl:text><xsl:value-of select="vpflevel"/>
										<xsl:for-each select="vpfinfo">
											<xsl:text>Type and count:</xsl:text><xsl:value-of select="vpfinfo/vpftype"/><xsl:value-of select="ptvctcnt"/>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:if>
							</xsl:for-each>
					        <xsl:if test="spref"><!-- here, flatten spref-->
								<xsl:call-template name="spref"/>
					        </xsl:if>
						</spatialInfo>
					</additionalMetadata>
				</xsl:if>
			</xsl:if>
		
			<xsl:if test="metainfo">
				<xsl:for-each select="metainfo">
					<additionalMetadata>
						<metadataInfo>
							<xsl:text>Additional Metadata Information</xsl:text>
							<xsl:value-of select="."/>
						</metadataInfo>
					</additionalMetadata>
				</xsl:for-each>
			</xsl:if>
		</eml:eml>
	</xsl:template>
	
	
	<xsl:template name="spref" match="/metadata/spref">
		
<!-- in the FGDC-BDP, there is a choice over populating the "geodetic" tag/field (datum, ellipsoid name, semiaxis and denominator or flattening ratio). 
							if FGDC users do not populate the geodetic element, our only hope to create a compliant EML doc is that FGDC users provide with a name for
							the grid system, or the projection name, and even this last one option would be a kludge, as EML is very specific about the nomenclature of the
							horizontal coordinate system name. it is possible that we miss the datum, or other relevant geospatial details. 
							So, there are three attempts to see whether we can fulfill EML-2.0.1 spatial referecen requirements. If we fail, all the info that may
							exist on spatial reference info should go somewhat unstructured into additionalMetadata. -->
				
			<xsl:choose>
				<xsl:when test="/metadata/spref/horizsys/geodetic/ellips!=''"><!-- at least, we may have a datum, and ellipsoid name and semiaxis. lets see . it turns out that most of the FGDC geospatial files will do this. instead of trying to come up with all the parameters, just populate what you can in this instance, starting by the good fact that we have the mandatory <geogCoordSys> info-->				
					<xsl:element name="spatialReference">
						<xsl:element name="horizCoordSysDef">
							<xsl:attribute name="name">
								<xsl:choose>
									<xsl:when test="/metadata/spref/horizsys/planar/mapproj/mapprojn!=''">
										<xsl:value-of select="/metadata/spref/horizsys/planar/mapproj/mapprojn"/>
									</xsl:when>
									<xsl:when test="/metadata/spref/horizsys/planar/gridsys/gridsysn!=''">
										<xsl:value-of select="/metadata/spref/horizsys/planar/gridsys/gridsysn"/>
									</xsl:when>
										<xsl:otherwise><xsl:value-of select="'Not able to determine'"/></xsl:otherwise>
								</xsl:choose> 
							</xsl:attribute>
							<xsl:choose>
								<xsl:when test="/metadata/spref/horizsys/planar/mapproj/mapprojn!=''"><!-- dump both geog and proj. info in EML -->
									<xsl:element name="projCoordSys">
										<xsl:element name="geogCoordSys">
											<xsl:element name="datum">
												<xsl:attribute name="name">
													<xsl:choose><!-- the datum name is optional in FGDC, but mandatory in EML201. check whether populated -->
														<xsl:when test="/metadata/spref/horizsys/geodetic/horizdn!=''">
															<xsl:value-of select="/metadata/spref/horizsys/geodetic/horizdn"/>
														</xsl:when>
														<xsl:otherwise><xsl:value-of select="'Not able to determine'"/></xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
											</xsl:element>
											<xsl:element name="spheroid">
												<xsl:attribute name="name">
													<xsl:value-of select="/metadata/spref/horizsys/geodetic/ellips"/>
												</xsl:attribute>
												<xsl:attribute name="semiAxisMajor">
													<xsl:value-of select="/metadata/spref/horizsys/geodetic/semiaxis"/>
												</xsl:attribute>
												<xsl:attribute name="denomFlatRatio">
													<xsl:value-of select="/metadata/spref/horizsys/geodetic/denflat"/>
												</xsl:attribute>
											</xsl:element>
											<xsl:element name="primeMeridian"><!-- except for the french and some pl. in asia, always greenwich. NEED to accom. those-->
												<xsl:attribute name="name"><xsl:value-of select="' Greenwich'"/></xsl:attribute><!-- harcoded -->
												<xsl:attribute name="longitude"><xsl:value-of select="'0.0'"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="unit"><!--again, except la galoise (radians) always degrees -->
												<xsl:attribute name="name"><xsl:value-of select="'degree'"/></xsl:attribute>
											</xsl:element>
										</xsl:element>
										<xsl:element name="projection">											
											<xsl:choose> <!-- begin multiple PARAMETER choice between possible FGDC projections -->
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/albers!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Albers Conical Equal Area Section'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/albers/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/albers/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/albers/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/albers/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/albers/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/azimequi/longcm!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Azimuthal Equidistant '"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/azimequi/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/azimequi/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/azimequi/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/azimequi/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/equicon/stdparll!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Equidistant Conic '"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equicon/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equicon/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equicon/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equicon/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equicon/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/equirect/stdparll!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Equirectangular'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equirect/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equirect/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equirect/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/equirect/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/gvnsp/heightpt!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'General Vertical Near-Sided'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Height of Perspective Point Above Surface'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'height of viewpoint above the Earth, expressed in meters.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gvnsp/heightpt">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gvnsp/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="' latitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gvnsp/latprjc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gvnsp/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gvnsp/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/gnomonic/longpc!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Gnomonic'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gnomonic/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="' latitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gnomonic/latprjc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gnomonic/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/gnomonic/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/lamberta/longpc!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Lambert Azimuthal Equal Area'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="' latitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/latprjc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/lamberta/stdparll!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Lambert Conformal Conic'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/lamberta/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/mercator/stdparll!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Mercator'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mercator/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at equator'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance along the equator.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mercator/sfequat">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mercator/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mercator/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mercator/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/modsak!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Modified Stereographic for Alaska Projection'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/modsak/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/modsak/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/miller/longcm!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Miller Cylindrical Projection'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/miller/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/miller/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/miller/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/obqmerc/sfctrlin!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Oblique Mercator Projection'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at center line'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance along the center line.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/sfctrlin">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Azimuth: Azimuthal Angle'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using the map projection origin and an azimuth. angle measured clockwise from north, and expressed in degrees.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/obqlazim/azimangl">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Azimuth: Azimuthal Measure point longitude'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using the map projection origin and an azimuth.  longitude of the map projection origin'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/obqlazim/azimptl">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Point: latitude'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using two points near the limits of the mapped region that define the center line: latitude of a point defining the oblique line.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/obqlpt/obqllat">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Point:  Longitude'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using two points near the limits of the mapped region that define the center line. longitude of a point defining the oblique line.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/obqlpt/obqllong">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/obqmerc/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/orthogr/longpc!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Orthographic'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/orthogr/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="' latitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/orthogr/latprjc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/orthogr/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/orthogr/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/polarst/svlong!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Polar Stereographic'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Straight Vertical Longitude from Pole'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude to be oriented straight up from the North or South Pole.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polarst/svlong">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polarst/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance at the projection origin.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polarst/sfprjorg">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polarst/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polarst/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/polycon/longcm!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Polyconic'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polycon/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polycon/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polycon/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/polycon/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/robinson/longpc!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Robinson'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/robinson/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/robinson/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/robinson/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/sinusoid/longcm!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Sinusoidal'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/sinusoid/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/sinusoid/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/sinusoid/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/spaceobq/landsat!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Space Oblique Mercator'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Landsat Number'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'number of the Landsat satellite. (Note: This data element exists solely to provide a parameter needed to define the space oblique mercator projection. It is not used to identify data originating from a remote sensing vehicle.)'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/spaceobq/landsat">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Path Number'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'number of the orbit of the Landsat satellite. (Note: This data element exists solely to provide a parameter needed to define the space oblique mercator projection. It is not used to identify data originating from a remote sensing vehicle.)'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/spaceobq/pathnum">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/spaceobq/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/spaceobq/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/stereo/longpc!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Stereographic'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/stereo/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="' latitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/stereo/latprjc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/stereo/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/stereo/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/transmer/sfctrmer!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'Transverse Mercator'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance along the central meridian.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/transmer/sfctrmer">
																				<xsl:attribute name="value">
																					<xsl:value-of select="."/>
																				</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/transmer/longcm">
																				<xsl:attribute name="value">
																					<xsl:value-of select="."/>
																				</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/transmer/latprjo">
																				<xsl:attribute name="value">
																					<xsl:value-of select="."/>
																				</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/transmer/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/transmer/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/vdgrin/longcm!=''">
													<xsl:attribute name="name">
														<xsl:value-of select="'van der Grinten'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/vdgrin/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/vdgrin/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/vdgrin/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
												<xsl:when test="/metadata/spref/horizsys/planar/mapproj/mapprojp!=''">
												<!-- this case is tricky, as it may have up to 6 of all the parameters mentioned before. NEED ifs..-->
													<xsl:attribute name="name">
														<xsl:value-of select="'Other Set of  Map Projection Parameters'"/>
													</xsl:attribute>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Standard Parallel'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'Line of constant latitude at which the Earth and the plane intersect'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/stdparll">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Longitude at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The line of logitude at the center of the map projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/longcm">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'The latitude chosen as center of the projection'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/latprjo">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Easting'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/feast">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'False Northing'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'A value added in a rectangular coordinate system, usually used to avoid negative values'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/fnorth">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at equator'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance along the equator.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/sfequat">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Height of Perspective Point Above Surface'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'height of viewpoint above the Earth, expressed in meters.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/heightpt">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="' Longitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/longpc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Latitude of Projection Center'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="' latitude of the point of projection for azimuthal projections.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/latprjc">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at center line'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance along the center line.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/sfctrlin">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Azimuth: Azimuthal Angle'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using the map projection origin and an azimuth. angle measured clockwise from north, and expressed in degrees.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/obqlazim/azimangl">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Azimuth: Azimuthal Measure point longitude'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using the map projection origin and an azimuth.  longitude of the map projection origin'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/obqlazim/azimptl">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Point: latitude'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using two points near the limits of the mapped region that define the center line: latitude of a point defining the oblique line.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/obqlpt/obqllat">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Oblique Line Point:  Longitude'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'method used to describe the line along which an oblique mercator map projection is centered using two points near the limits of the mapped region that define the center line. longitude of a point defining the oblique line.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/obqlpt/obqllong">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Straight Vertical Longitude from Pole'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'longitude to be oriented straight up from the North or South Pole.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/svlong">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at projection origin'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance at the projection origin.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/sfprjorg">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Landsat Number'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'number of the Landsat satellite. (Note: This data element exists solely to provide a parameter needed to define the space oblique mercator projection. It is not used to identify data originating from a remote sensing vehicle.)'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/landsat">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Path Number'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'number of the orbit of the Landsat satellite. (Note: This data element exists solely to provide a parameter needed to define the space oblique mercator projection. It is not used to identify data originating from a remote sensing vehicle.)'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/pathnum">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Scale factor at central meridian'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a multiplier for reducing a distance obtained from a map by computation or scaling to the actual distance along the central meridian.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/sfctrmer">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
													<xsl:element name="parameter">
														<xsl:attribute name="name">
															<xsl:value-of select="'Other projection definitions'"/>
														</xsl:attribute>
														<xsl:attribute name="description">
															<xsl:value-of select="'a description of a projection, not defined elsewhere in the standard, that was used for the data set. The information provided shall include the name of the projection, names of parameters and values used for the data set, and the citation of the specification for the algorithms that describe the mathematical relationship between Earth and plane or developable surface for the projection.'"/>
														</xsl:attribute>
														<xsl:for-each select="/metadata/spref/horizsys/planar/mapproj/mapprojp/otherprj">
															<xsl:attribute name="value">
																<xsl:value-of select="."/>
															</xsl:attribute>
														</xsl:for-each>
													</xsl:element>
												</xsl:when>
								
											</xsl:choose> <!-- end of big long FGDC projection PARAMETERS choice -->
											<xsl:element name="unit">
												<xsl:value-of select="/metadata/spref/horizsys/planar/planci/plandu"/><!-- the unit element : it is an Enumerated field, so some CHOOSE must be applied.HERE-->
											</xsl:element>
										</xsl:element> <!--end of projection element -->
									</xsl:element>    <!-- end of projCoordSys element -->
								</xsl:when>
								
								<xsl:when test="/metadata/spref/horizsys/geograph/geounit!=''"> <!-- dump only geogCoordSys element -->
									<xsl:element name="geogCoordSys">
											<xsl:element name="datum">
												<xsl:attribute name="name">
													<xsl:choose><!-- the datum name is optional in FGDC, but mandatory in EML201. check whether populated -->
														<xsl:when test="/metadata/spref/horizsys/geodetic/horizdn!=''">
															<xsl:value-of select="/metadata/spref/horizsys/geodetic/horizdn"/>
														</xsl:when>
														<xsl:otherwise><xsl:value-of select="'Not able to determine'"/></xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
											</xsl:element>
											<xsl:element name="spheroid">
												<xsl:attribute name="name">
													<xsl:value-of select="/metadata/spref/horizsys/geodetic/ellips"/>
												</xsl:attribute>
												<xsl:attribute name="semiAxisMajor">
													<xsl:value-of select="/metadata/spref/horizsys/geodetic/semiaxis"/>
												</xsl:attribute>
												<xsl:attribute name="denomFlatRation">
													<xsl:value-of select="/metadata/spref/horizsys/geodetic/denflat"/>
												</xsl:attribute>
											</xsl:element>
											<xsl:element name="primeMeridian"><!-- except for the french and some pl. in asia, always greenwich. NEED to accom. those-->
												<xsl:attribute name="name"><xsl:value-of select="' Greenwich'"/></xsl:attribute><!-- harcoded -->
												<xsl:attribute name="longitude"><xsl:value-of select="'0.0'"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="unit"><!--again, except la galoise (radians) always degrees -->
												<xsl:attribute name="name"><xsl:value-of select="'degrees'"/></xsl:attribute>
											</xsl:element>
									</xsl:element>
								</xsl:when>      <!-- end of geogCoordSys and all tree..-->     
							</xsl:choose>            <!-- end of choice of "projection" vs. "geog" -->
						</xsl:element>       <!--end of horizCoordSysDef -->

				        <!-- time for testing whether there is vertical info, and if so, place it here. -->

				        <xsl:if test="/metadata/spref/vertdef/altsys/altdatum!=''"> <!-- if true, we have at least the vertical coordinate altitude system 1-1 FGDC to EML -->
							<xsl:element name="vertCoordSys">
								<xsl:element name="altitudeSysDef">
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altdatum">
													<xsl:element name="altitudeDatumName">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altres">
													<xsl:element name="altitudeResolution">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altunits">
													<xsl:element name="altitudeDistanceUnits">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altenc">
													<xsl:element name="altitudeEncodingMethod">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
								</xsl:element>
								<xsl:if test="/metadata/spref/vertdef/depthsys/depthdn!=''"><!-- if true, we also have the depth system for the vertical coordinates -->
									<xsl:element name="depthSysDef">
										<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthdn">
														<xsl:element name="depthDatumName">
															<xsl:value-of select="."/>
														</xsl:element>
										</xsl:for-each>
										<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthres">
														<xsl:element name="depthResolution">
															<xsl:value-of select="."/>
														</xsl:element>
										</xsl:for-each>
										<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthdu">
														<xsl:element name="depthDistanceUnits">
															<xsl:value-of select="."/>
														</xsl:element>
										</xsl:for-each>
										<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthem">
														<xsl:element name="depthEncodingMethod">
															<xsl:value-of select="."/>
														</xsl:element>
										</xsl:for-each>
									</xsl:element>
								</xsl:if>
							</xsl:element>
						</xsl:if>   <!-- end fi for testing existence of vertical coordinate info -->

					</xsl:element>	          <!--end of spatialReference element -->
				
				</xsl:when>
				
				<xsl:when test="/metadata/spref/horizsys/planar/mapproj/mapprojn!=''"><!-- we may have a projection name -->
					<!-- we could have try to decode what datum and ellisoid we have, but it'd be too cumbersome.-->
					<xsl:element name="spatialReference">
						<horizCoordSysName>
							<xsl:value-of select="/metadata/spref/horizsys/planar/mapproj/mapprojn"/>
						</horizCoordSysName>
				
						<xsl:if test="/metadata/spref/vertdef/altsys/altdatum!=''"> <!-- if true, we have at least the vertical coordinate altitude system 1-1 FGDC to EML -->
							<xsl:element name="vertCoordSys">
								<xsl:element name="altitudeSysDef">
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altdatum">
													<xsl:element name="altitudeDatumName">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altres">
													<xsl:element name="altitudeResolution">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altunits">
													<xsl:element name="altitudeDistanceUnits">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/altsys/altenc">
													<xsl:element name="altitudeEncodingMethod">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
								</xsl:element>
								<xsl:if test="/metadata/spref/vertdef/depthsys/depthdn!=''"><!-- if true, we also have the depth system for the vertical coordinates -->
								<xsl:element name="depthSysDef">
									<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthdn">
													<xsl:element name="depthDatumName">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthres">
													<xsl:element name="depthResolution">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthdu">
													<xsl:element name="depthDistanceUnits">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthem">
													<xsl:element name="depthEncodingMethod">
														<xsl:value-of select="."/>
													</xsl:element>
									</xsl:for-each>
								</xsl:element>
								</xsl:if>
							</xsl:element>
						</xsl:if>
					</xsl:element><!-- end of spatialReference-->
					
				</xsl:when><!-- end of case no Geodetic info, but mapproj existed -->

				<xsl:when test="/metadata/spref/horizsys/planar/gridsys/gridsysn"><!-- we may have a gridsystem-->
				<!-- info for datum, etc, too dificult to guess -->
					<xsl:element name="spatialReference">
						<horizCoordSysName>
							<xsl:value-of select="/metadata/spref/horizsys/planar/gridsys/gridsysn"/>
						</horizCoordSysName>
						<xsl:if test="/metadata/spref/vertdef/altsys/altdatum!=''"> <!-- if true, we have at least the vertical coordinate altitude system 1-1 FGDC to EML -->
						<xsl:element name="vertCoordSys">
							<xsl:element name="altitudeSysDef">
								<xsl:for-each select="/metadata/spref/vertdef/altsys/altdatum">
												<xsl:element name="altitudeDatumName">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
								<xsl:for-each select="/metadata/spref/vertdef/altsys/altres">
												<xsl:element name="altitudeResolution">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
								<xsl:for-each select="/metadata/spref/vertdef/altsys/altunits">
												<xsl:element name="altitudeDistanceUnits">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
								<xsl:for-each select="/metadata/spref/vertdef/altsys/altenc">
												<xsl:element name="altitudeEncodingMethod">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
							</xsl:element>
							<xsl:if test="/metadata/spref/vertdef/depthsys/depthdn!=''"><!-- if true, we also have the depth system for the vertical coordinates -->
							<xsl:element name="depthSysDef">
								<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthdn">
												<xsl:element name="depthDatumName">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
								<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthres">
												<xsl:element name="depthResolution">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
								<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthdu">
												<xsl:element name="depthDistanceUnits">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
								<xsl:for-each select="/metadata/spref/vertdef/depthsys/depthem">
												<xsl:element name="depthEncodingMethod">
													<xsl:value-of select="."/>
												</xsl:element>
								</xsl:for-each>
							</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:if>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise><!-- todo-->
				
				</xsl:otherwise><!-- cannot meet EML-2.0.1 spatial ref. requirements, dump info into additionalMetadata field -->

			</xsl:choose><!-- should end here -->
			
	</xsl:template>
</xsl:stylesheet>

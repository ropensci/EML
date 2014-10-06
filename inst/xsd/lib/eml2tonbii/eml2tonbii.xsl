<?xml version="1.0"?>
<!--
  *  This is a newer revision for the eml2nbii stylesheet. See log of changes respect to revision 1.21 below. Inigo
  *  The following info, from previous version 1.21, until where says "Log of Changes".
  * 
  *  '$RCSfile: eml2tonbii.xsl,v $'
  *      Authors: Dan Higgins
  *    Copyright: 2000 Regents of the University of California and the
  *               National Center for Ecological Analysis and Synthesis
  *  For Details: http://www.nceas.ucsb.edu/
  *
  *   '$Author: jones $'
  *     '$Date: 2007-03-01 17:00:22 $'
  * '$Revision: 1.23 $'
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
  * This is an XSLT (http://www.w3.org/TR/xslt) stylesheet designed to
  * convert an XML file in eml2 format to nbii fromat
*
*
*
**** Log of Changes, January 19, 2010. Jing Tao. ***
** Summary:
*      The modification makes the style sheet work with eml-2.0.0, eml-2.0.1 and eml-2.1.0.
*	
** Itemized list of changes.
* 1. Use "/*[local-name() = 'eml']" to replace "/eml:eml/" in xpath throught out the entire file.
* 2. Line 1384, 1386 and 1391, use "or" condition to handle "/eml/dataset/access" or "/eml/access".
* 3. Line 1938 and 1940, use "or" condition to hanlde "//measurmentScale/datetime" or "//measurmentScale/dateTime"
* 4. Line 1392, using "Deny" to replace "Allow".
* 5  Line 3149, use "Ecological Metadata Langualge 2.x " to replace "Ecological Metadata Langualge 2.0".
* 5. Line 3152, use "Ecological Metadata Language 2.x" to repalce "Ecological Metadata Language 2.0.1".
************************************************************************************************************************
 
**** Log of Changes, September 2005. Inigo San Gil.****
*
**  Summary
*
*   There are about 50 issues (some critical metadata loss) solved in this revision. Mostly are 
*	metadata sections that were not completely mapped from the EML to the BDP standard.
*    
*   Additionally, there are a few other improvements in the mapping. 
*   This revision, 3000+ lines, previous 1600.
*
** Itemized list of changes. NOTE, line numbers refer to the previous version (revision 1.21) of "eml2nbii.xsl"
*
* line  51: Make all possible metadata transformations, that is, set the variable $show_optional to true (1)
* line 141: Loop over all entities in EML; Previosuly, only dataTable, spatialRaster and spatialVector considered. "view", "storedProcedure" and "otherEntity" added. 
*               hard coded content values changed to english (dataTable  to tabular digital data, etc)
* line 148: BDP "Sername" (series) contents not mapped. Added EML"series" content, if populated in the EML instance.
* line 158: BDP "pubPlace" contents not mapped. Added EML "pubPlace" content when used.
* line 161: BDP "publish" contents not mapped. Added EML "publisher" individual and org. name when used.
* line 172: BDP "onlink" contents not mapped. Added EML "distribution/online/url" when used.
* line 178: Odd hard coded value removed. It is possible that the author meant some action. 
* line 196: BDP "purpose" contents not mapped. Added EML "purpose"
* line 200: BDP "supplinf" contents not mapped. Added EML "additionalInfo"
* line 243: Handling multiple single data time elements addressed (for each..), gelogical Scale / Alternatetimescale, etc.  About 300+ lines of code replace about 120 of them
* line 333: Currentness element hard coded to "as it was when data was compiled" added
* line 330: Comment change
* line 335: Added all possible EML maintenance contents to map into BDP's update field. Also, there was a bug in the conditional statement.
* line 367: Added bounding altitudes mapping to the geographic coverage mapping (Not considered before) 
* line 369: Added the G-poligon mapping.
* line 539: Added taxonomic keywords, previously forced to NONE.
* line 562: Added the case of optional classification system elements and other taxonomic-related metadata groups (230 lines of code)
* line 607, 620: Access element code group duplicated for use and access constraints elements in BDP. Not quite accurate granularity. Removed duplicate code
* line 607: Access element incomplete, the EML intellectual Rights section is relevant here. Add code.
* line 633: Added EML contact info. Need handle refs.
* line 641: Added in "datacred" (credit) info from EML "associated parties" and "funding" agency.
* line 663: Addition of metadata:  Attemting to use section 2 of BDP: Data Quality Info. Some sections from EML methods can be used here. quite a bit of code added
* sections 3 and 4 of BDP skipped for now.
* line 791: Misleading/Obsolete comments refined. 
* line 792: Include all EML dataset entities; add storedProcedure, view and otherEntity types. 
* line 794: Not sure about the loop logic. Need testing.
* line 886: Textdomain from attribute type nominal or ordinal mapped correctly as is to "unrepresentable domain"
* line 911: Unit type added to BDPs "range domain" from EML's attributes of type interval or ratio.
* line 915: EMLs date time attribute type mapped correctly to unrepresentable domain.
* line 921: THIS MAY NEED A CHANGE. accuracy missing. It is not exactly the precision, but if EMLs attr. precision exists, it is mapped to BDPs attr. accuracy for the sake of preserving metadata.
* line 931: This conditional is out of place: there is no need of a EML physical element to populate this element. All you need is a "publisher" or a "contact". An distribution/online element helps.
* line 936: Distribution element. The distributor should be the publisher. If the publisher is not specified, it could default to the contact. Options included
* line 960: Contact org mapped.
* line 972: Contact person mapped
* line 984: Contact person mapped
* line 1058: Phone mapped better
* line 1072: Fax mapped
* line 1078: Email mapped
* line 1102: In the previous version, the BDP element distribution info is only mapped if the EML physical element is populated. We consider the case where the EML "distribution" exists,
*                 this opens a new case (lots of code)
* line 1122: Sometimes the "data format " -geoform- is placed depending on the entity we have in EML (data table, spatial vector, etc)
* line 1257: Clarification added to the hard coded text.
* line 1338: In practice, both metadata and data have the same publication date (pubDate), therefore pubdate of EML data mapped to pub date of BDP metadata
* line 1351: Try to map the metadataprovider as the metadta creator, otherwise (metadata provider not present in EML) default to the EML contact
* line 1386: add contact organization or contact person name even though we placed already one or the other.
* line 1475: map better the phone
* line 1490: map the fax
* line 1495: most importantly, map the email.
*
***
* Contact Info for <origin> (eml:<creator>) ((the person who gathered the data)) added to the <othercit> BDP in element (there is no room for that info otherwise).
*** Things to consider.
* The BDP elements spatial data organization info and spatial ref. info were not revised in this version. 
* line 1099: statement about distribution liability
* line 921: THIS MAY NEED A CHANGE. accuracy missing. It is not exactly the precision, but if EMLs attr. precision exists, it is mapped to BDPs attr. accuracy for the sake of preserving metadata.
* Some references are not handled yet
* substitute the "xalan" namespace (work out the code) to make this stylesheet more portable  - xalan independent-
*
*
* Thanks to Wade Sheldon, Mark Servilla, George Lienkaemper, Viv Hutchison and Matt Jones 
***
***  Added, March 2006
***
*** Chris Lindsley found a critical bug on <spdoinfo> tree nodes. Some node xsl oeprations are not permitted on temporary subtree nodes (from variables). Changes made around line 1705.
*** 
** October 2006
**  
** inline data tweaked: transformation was faulty there were distribution references in a <physical> group. Now it is contemplated well for all three options of EML distribution.
** TODOs: multiple tables in one EML.
**              taxonomic keywords not mapped correctly. 
***
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:eml="eml://ecoinformatics.org/eml-2.0.1"
xmlns:xalan="http://xml.apache.org/xalan"
version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:output encoding="ISO-8859-1"/>
<xsl:strip-space elements="*"/>

<!-- mapping of eml2 geometry types to fgdc; multi... types very uncertain! -->
<!-- March 2006, group is obsolete -->
 <!--xsl:variable name="geometryTypeMap">   
    <geomtype name="LineString" sdtstype="String"/>
    <geomtype name="LinearRing" sdtstype="Area chain"/>
    <geomtype name="Polygon" sdtstype="G-polygon"/>
    <geomtype name="Point" sdtstype="Point"/>
    <geomtype name="MultiPoint" sdtstype="Point"/>
    <geomtype name="MultiLineString" sdtstype="Ring composed of strings"/>
    <geomtype name="MultiPolygon" sdtstype="G-polygon"/>
    <geomtype name="MultiGeometry" sdtstype="Node, network"/>
  </xsl:variable-->
  
  <xsl:variable name="show_optional" select="1"/>
  
  <!-- create a variable that contains all the elements that have an 'id' 
       attribute. Do this so that the the search for such elements only has
       to be carried out once.
  -->     
  <xsl:variable name="ids" select="//*[@id!='']"/>
  
  <xsl:template match="/">
  
    <xsl:element name="metadata">
      <!-- only the 'idinfo' and 'metainfo' elements are required -->
      <!-- start the 'idinfo' branch -->      
	 <xsl:variable name="packageID">
				<xsl:value-of select="/*[local-name() = 'eml']/@packageId"/>
	 </xsl:variable>
      <xsl:element name="idinfo">
        <xsl:element name="citation">
          <xsl:element name="citeinfo">
            <xsl:for-each select="/*[local-name() = 'eml']/dataset/creator">
            <!-- This is a loop over all the dataset 'creator' elements
             Note that dataset itself might be 'referenced' rather
             than exist 'in-place'. More likely, however, is that
             the creator element may have a 'references' child rather
             than inline children! -->
              <xsl:variable name="cc">
                <xsl:choose>
                  <xsl:when test="./references!=''">
                    <xsl:variable name="ref_id" select="./references"/>
                    <!-- current element just references its contents 
                    There should only be a single node with an id attribute
                    which matches the value of the references element -->
                    <xsl:copy-of select="$ids[@id=$ref_id]"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- no references tag, thus use the current node -->
                    <xsl:copy-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:element name="origin">
              <!-- 'origin' should correspond to the name of the 'creator' RP in eml2 -->
                  <xsl:choose>
                    <xsl:when test="xalan:nodeset($cc)//individualName/surName!=''">
                      <xsl:value-of select="xalan:nodeset($cc)//individualName/surName"/>
                      <xsl:value-of select="', '"/><xsl:value-of select="xalan:nodeset($cc)//individualName/givenName"/>
                    </xsl:when>
                    <xsl:when test="xalan:nodeset($cc)//organizationName!=''">
                      <xsl:value-of select="xalan:nodeset($cc)//organizationName"/>
                    </xsl:when>
                    <xsl:when test="xalan:nodeset($cc)//positionName!=''">
                      <xsl:value-of select="xalan:nodeset($cc)//positionName"/>
                    </xsl:when>
                  </xsl:choose>
              </xsl:element>
            </xsl:for-each>  
            <xsl:element name="pubdate">
            <!-- pubdate is optional in eml2 -->
              <xsl:choose>
                <xsl:when test="/*[local-name() = 'eml']/dataset/pubDate!=''">
                  <xsl:value-of select="/*[local-name() = 'eml']/dataset/pubDate"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'N/A'"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
            <xsl:if test="$show_optional">
              <xsl:element name="pubtime">
              
              </xsl:element>
            </xsl:if>
            <xsl:element name="title">
              <xsl:value-of select="/*[local-name() = 'eml']/dataset/title"/>
            </xsl:element>
             <xsl:if test="$show_optional">
              <xsl:element name="edition">                             <!-- ISG: POSSIBLE ADD: version, but packet version is not neccrly title edition -->
              
              </xsl:element>
            </xsl:if>
            <xsl:element name="geoform">
            <!-- Geospatial Data Presentation Form - the mode in which the 
                       geospatial data are represented. -->      
              <xsl:choose>
                <xsl:when test="/*[local-name() = 'eml']/dataset/dataTable!=''">
                  <xsl:value-of select="'tabular digital data'"/>       <!-- ISG: changed from dataTable to tabular digital data"  -->
                </xsl:when>
                <xsl:when test="/*[local-name() = 'eml']/dataset/spatialRaster!=''">
                  <xsl:value-of select="'raster digital data'"/>			<!-- ISG: changed from spatialRaster to "raster digital data" -->
                </xsl:when>
                <xsl:when test="/*[local-name() = 'eml']/dataset/spatialVector!=''">
                  <xsl:value-of select="'spatial vector data'"/>         <!-- ISG: changed from spatialVector data  to "spatial vector data" -->
                </xsl:when>
                <xsl:when test="/*[local-name() = 'eml']/dataset/storedProcedure!=''">
                  <xsl:value-of select="'procedure'"/>                       <!-- ISG: added procedure -->
                </xsl:when>
                <xsl:when test="/*[local-name() = 'eml']/dataset/view!=''">
                  <xsl:value-of select="'view'"/>                                <!-- ISG: added view -->
                </xsl:when>
                <xsl:when test="/*[local-name() = 'eml']/dataset/otherEntity!=''">
                  <xsl:value-of select="'entity'"/>                               <!-- ISG: added entity -->
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'unknown'"/>
                </xsl:otherwise>              
              </xsl:choose>
            </xsl:element>
             <xsl:if test="$show_optional">
              <xsl:element name="serinfo">
                <xsl:element name="sername">
					<xsl:if test="/*[local-name() = 'eml']/dataset/series!=''">
						<xsl:value-of select="/*[local-name() = 'eml']/dataset/series" />    <!-- ISG: series added -->
					</xsl:if>
                </xsl:element>
                <xsl:element name="issue">
                
                </xsl:element>
              </xsl:element>
            </xsl:if>
             <xsl:if test="$show_optional">
              <xsl:element name="pubinfo">
                <xsl:element name="pubplace">
					<xsl:if test="/*[local-name() = 'eml']/dataset/pubPlace!=''">
						<xsl:value-of select="/*[local-name() = 'eml']/dataset/pubPlace" />    <!-- ISG: pubPlace added -->
					</xsl:if>
                </xsl:element>
                <xsl:element name="publish">
					<xsl:if test="/*[local-name() = 'eml']/dataset/publisher/individualName/surName!=''">
						<xsl:value-of select="/*[local-name() = 'eml']/dataset/publisher/individualName/surName" /><xsl:value-of select="', '"/>
						<xsl:value-of select="/*[local-name() = 'eml']/dataset/publisher/individualName/givenName" />    <!-- ISG: publisher individual added -->
					</xsl:if>
					<xsl:if test="/*[local-name() = 'eml']/dataset/publisher/organizationName!=''">
						<xsl:value-of select="/*[local-name() = 'eml']/dataset/publisher/organizationName" />              <!-- ISG: publisher org. name added -->
					</xsl:if>
                </xsl:element>
              </xsl:element>
            </xsl:if>
             <xsl:if test="$show_optional">
              <xsl:element name="othercit"><!-- ISG added Oct 31 2005: Addresses for originators -->
              <!-- 'origin' corresponds to the name of the 'creator'  in eml2, but <origin> cannot accept contact info. we put it here. -->
				<xsl:for-each select="/*[local-name() = 'eml']/dataset/creator">
					<!-- Need to capture info into $cc again -->
				  <xsl:variable name="cc">
					<xsl:choose>
					  <xsl:when test="./references!=''">
						<xsl:variable name="ref_id" select="./references"/>
							<!-- current element just references its contents There should only be a single node with an id attribute which matches the value of the references element -->
						<xsl:copy-of select="$ids[@id=$ref_id]"/>
					  </xsl:when>
					  <xsl:otherwise>
						<!-- no references tag, thus use the current node -->
						<xsl:copy-of select="."/>
					  </xsl:otherwise>
					</xsl:choose>
				  </xsl:variable>
				  <xsl:if test="xalan:nodeset($cc)//address!=''">
					  <xsl:value-of select="'  Contact info for data set originator:  '"/>
					  <xsl:choose>
						<xsl:when test="xalan:nodeset($cc)//individualName/surName!=''">   
							<xsl:value-of select="xalan:nodeset($cc)//individualName/surName"/>
							<xsl:value-of select="', '"/><xsl:value-of select="xalan:nodeset($cc)//individualName/givenName"/>
						    <xsl:value-of select="'  Address:'"/>
						    <xsl:value-of select="xalan:nodeset($cc)//deliveryPoint"/>
						    <xsl:value-of select="' '"/>
						    <xsl:value-of select="xalan:nodeset($cc)//city"/>				    
						    <xsl:value-of select="', '"/>
						    <xsl:value-of select="xalan:nodeset($cc)//administrativeArea"/>
						    <xsl:value-of select="' '"/>
						    <xsl:value-of select="xalan:nodeset($cc)//postalCode"/>
						    <xsl:value-of select="' '"/>
						    <xsl:value-of select="xalan:nodeset($cc)//country"/>
						    <xsl:value-of select="' '"/>
						</xsl:when>
						<xsl:when test="xalan:nodeset($cc)//organizationName!=''">
						  <xsl:value-of select="xalan:nodeset($cc)//organizationName"/>
						  <xsl:value-of select="'  Address:'"/>
						  <xsl:value-of select="xalan:nodeset($cc)//address"/>
						</xsl:when>
					  </xsl:choose>              
                  </xsl:if>
                  <xsl:if test="xalan:nodeset($cc)//phone!=''">
						<xsl:value-of select="' Phone:'"/><xsl:value-of select="xalan:nodeset($cc)//phone"/>
                  </xsl:if>
                  <xsl:if test="xalan:nodeset($cc)//electronicMailAddress!=''">
						<xsl:value-of select="' Email address:'"/><xsl:value-of select="xalan:nodeset($cc)//electronicMailAddress"/>
                   </xsl:if>
                </xsl:for-each>
              </xsl:element>
            </xsl:if>
             <xsl:if test="$show_optional">
              <xsl:element name="onlink">														<!-- ISG: url location added -->
				<xsl:if test="/*[local-name() = 'eml']/dataset/distribution/online/url!=''">
					<xsl:value-of select="/*[local-name() = 'eml']/dataset/distribution/online/url" />
				</xsl:if>
              </xsl:element>
            </xsl:if>
             <xsl:if test="$show_optional">
              <xsl:element name="lworkcit"> 		<!-- ISG: this value was hard coded: "recursive link to citinfo" I think the author meant to code something here. Value removed -->
              </xsl:element>
            </xsl:if>
         </xsl:element>
        </xsl:element>
        <xsl:element name="descript">
          <xsl:element name="abstract">
            <xsl:choose>
              <xsl:when test="/*[local-name() = 'eml']/dataset/abstract!=''">
                <xsl:value-of select="/*[local-name() = 'eml']/dataset/abstract"/>
                <!-- abstract can be complex element in eml2; this useage will simply concatenate text -->
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="'N/A'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
          <xsl:element name="purpose">											<!-- ISG: BDP purpose contents not mapped. Added EML purpose -->
			<xsl:choose>
				<xsl:when test="/*[local-name() = 'eml']/dataset/purpose!=''">
					<xsl:value-of select="/*[local-name() = 'eml']/dataset/purpose" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'N/A'"/>
				</xsl:otherwise>
			</xsl:choose>
          </xsl:element>
          <xsl:if test="$show_optional">
            <xsl:element name="supplinf">											<!-- ISG: BDP supplemental info contents not mapped. Added EML additionalInfo -->
				<xsl:if test="/*[local-name() = 'eml']/dataset/additionalInfo!=''">
					<xsl:value-of select="/*[local-name() = 'eml']/dataset/additionalInfo" />
				</xsl:if>
            </xsl:element>
          </xsl:if>
        </xsl:element>
        
        <xsl:element name="timeperd">
          <xsl:element name="timeinfo">
			<xsl:variable name="singledates">					<!-- store here the number of single date times used in the EML instance -->
				<xsl:value-of select="count(/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime)" />
			</xsl:variable>
					    <xsl:choose>
							<xsl:when test="$singledates=1">				<!-- Case: A single date -->
								<xsl:element name="sngdate">
									<xsl:choose>
										<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/calendarDate!=''">    <!-- a single date, standard date -->
											<xsl:element name="caldate">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/calendarDate"/>
											</xsl:element>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/time!=''">						<!-- add time, if there is any specified -->
												<xsl:element name="time">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/time"/>
												</xsl:element>
											</xsl:if>
										</xsl:when>
										<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleName!=''">
										<xsl:element name="geolage">
											<xsl:element name="geolscal">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleName"/>
											</xsl:element>
											<xsl:element name="geolest">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleAgeEstimate"/>
											</xsl:element>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleAgeUncertainty!=''">
												<xsl:element name="geolun">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleAgeUncertainty"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleAgeExplanation!=''">
												<xsl:element name="geolexpl">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleAgeExplanation"/>
												</xsl:element>
											</xsl:if>
											<xsl:if  test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/title!=''">
												<xsl:element name="geolcit">
													<xsl:element name="citeinfo">
														<xsl:element name="origin">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/creator/individualName/surName"/>
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/creator/organizationName"/>
														</xsl:element>
														<xsl:choose>
															<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/pubDate!=''">
																<xsl:element name="pubdate">
																	<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/pubDate"/>
																</xsl:element>
															</xsl:when>
															<xsl:otherwise>
															<xsl:element name="pubdate"><xsl:value-of select="'Unknown'"/></xsl:element>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:element name="title">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/title"/>
														</xsl:element>
														<xsl:element name="geoform"><xsl:value-of select="'Standard'"/></xsl:element>
														<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/series!=''">
															<xsl:element name="sername">
																<xsl:element name="serinfo">
																	<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/series"/>
																</xsl:element>
																<xsl:element name="issue"><xsl:value-of select="'Unknown'"/></xsl:element>
															</xsl:element>
														</xsl:if>
													    <xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/distribution/online/url!=''">
															<xsl:element name="onlink">
																<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleCitation/distribution/online/url"/>
															</xsl:element>
														</xsl:if>
													</xsl:element>
												</xsl:element>
											</xsl:if>
										</xsl:element>
									    </xsl:when>	
									</xsl:choose>
								</xsl:element>
							</xsl:when>		                                           <!-- end of single date case -->
  							<xsl:when test="$singledates &gt; 1">				<!-- Case: Multiple single dates -->
  								<xsl:element name="mdattim">
									<xsl:choose>
										<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/calendarDate!=''">
											<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/calendarDate">
												<xsl:element name="sngdate">
													<xsl:element name="caldate">
														<xsl:value-of select="."/>
													</xsl:element>	  			<!-- we are not putting the time of the thing -->											 
												</xsl:element>
											</xsl:for-each>
										</xsl:when>
										<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale/timeScaleName!=''">
										<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/singleDateTime/alternativeTimeScale">
											<xsl:element name="geolage">
												<xsl:element name="geolscal">
													<xsl:value-of select="timeScaleName"/>
												</xsl:element>
												<xsl:element name="geolest">
													<xsl:value-of select="timeScaleAgeEstimate"/>
												</xsl:element>
												<xsl:if test="timeScaleAgeUncertainty!=''">
													<xsl:element name="geolun">
														<xsl:value-of select="timeScaleAgeUncertainty"/>
													</xsl:element>
												</xsl:if>
												<xsl:if test="timeScaleAgeExplanation!=''">
													<xsl:element name="geolexpl">
														<xsl:value-of select="timeScaleAgeExplanation"/>
													</xsl:element>
												</xsl:if>
												<xsl:if  test="timeScaleCitation/title!=''">
													<xsl:element name="geolcit">
														<xsl:element name="citeinfo">
															<xsl:element name="origin">
																<xsl:value-of select="timeScaleCitation/creator/individualName/surName"/>
																<xsl:value-of select="timeScaleCitation/creator/organizationName"/>
															</xsl:element>
															<xsl:choose>
																<xsl:when test="timeScaleCitation/pubDate!=''">
																	<xsl:element name="pubdate">
																		<xsl:value-of select="timeScaleCitation/pubDate"/>
																	</xsl:element>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:element name="pubdate"><xsl:value-of select="'Unknown'"/></xsl:element>
																</xsl:otherwise>
															</xsl:choose>
															<xsl:element name="title">
																<xsl:value-of select="timeScaleCitation/title"/>
															</xsl:element>
															<xsl:if test="timeScaleCitation/series!=''">
																<xsl:element name="sername">
																	<xsl:element name="serinfo">
																		<xsl:value-of select="timeScaleCitation/series"/>
																	</xsl:element>
																	<xsl:element name="issue"><xsl:value-of select="'Unknown'" /></xsl:element>
																</xsl:element>
															</xsl:if>
															<xsl:if test="timeScaleCitation/distribution/online/url!=''">
																<xsl:element name="onlink">
																	<xsl:value-of select="timeScaleCitation/distribution/online/url"/>
																</xsl:element>
															</xsl:if>
														</xsl:element>
													</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:for-each>
										</xsl:when>	
									</xsl:choose>
								</xsl:element>
							</xsl:when>   <!-- end case multiple single dates. -->
							<xsl:when test="$singledates &lt; 1">
								<xsl:choose>
								<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/calendarDate!=''">    <!-- a range of dates, standard date -->
									<xsl:element name="rngdates">
										<xsl:element name="begdate">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/calendarDate"/>
										</xsl:element>
										<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/time!=''">
											<xsl:element name="begtime">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/time"/>
											</xsl:element>
										</xsl:if>
										<xsl:element name="enddate">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/calendarDate"/>
										</xsl:element>
										<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/time!=''">
											<xsl:element name="endtime">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/time"/>
											</xsl:element>
										</xsl:if>
									</xsl:element>
								</xsl:when>
								<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleName!=''">    <!-- a range of dates, alternative date -->
									<xsl:element name="rngdates">
									<xsl:element name="beggeol">
										<xsl:element name="geolage">
											<xsl:element name="geolscal">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleName" />   
											</xsl:element>
											<xsl:element name="geolest">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleAgeEstimate"/>
											</xsl:element>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleAgeUncertainty!=''">
												<xsl:element name="geolun">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleAgeUncertainty"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleAgeExplanation!=''">
												<xsl:element name="geolexpl">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleAgeExplanation"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/title!=''">
												<xsl:element name="geolcit">
													<xsl:element name="citeinfo">
														<xsl:element name="origin">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/creator/individualName/surName"/>
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/creator/organizationName"/>
														</xsl:element>
														<xsl:choose>
															<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/pubDate!=''">
																<xsl:element name="pubdate">
																	<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/pubDate"/>														
																</xsl:element>
															</xsl:when>
															<xsl:otherwise>
																<xsl:element name="pubdate"><xsl:value-of select="'Unknown'"/></xsl:element>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:element name="title">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/title"/>			
														</xsl:element>
														<xsl:element name="geoform">
															<xsl:value-of select="'Standard'"/>																	
														</xsl:element>
														<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/series!=''">
															<xsl:element name="serinfo">
																<xsl:element name="sername">
																	<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/series"/>														
																</xsl:element>
																<xsl:element name="issue"><xsl:value-of select="'Unknown'"/></xsl:element>
															</xsl:element>
														</xsl:if>
														<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/distribution/online/url!=''">
															<xsl:element name="onlink">
																<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/beginDate/alternativeTimeScale/timeScaleCitation/distribution/online/url"/>														
															</xsl:element>
														</xsl:if>
													</xsl:element>
												</xsl:element>
											</xsl:if>
										</xsl:element>
									</xsl:element>
									<xsl:element name="endgeol">
										<xsl:element name="geolage">
											<xsl:element name="geolscal">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleName" />   
											</xsl:element>
											<xsl:element name="geolest">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleAgeEstimate"/>
											</xsl:element>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleAgeUncertainty!=''">
												<xsl:element name="geolun">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleAgeUncertainty"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleAgeExplanation!=''">
												<xsl:element name="geolexpl">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleAgeExplanation"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/title!=''">
												<xsl:element name="geolcit">
													<xsl:element name="citeinfo">
														<xsl:element name="origin">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/creator/individualName/surName"/>
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/creator/organizationName"/>
														</xsl:element>
														<xsl:choose>
															<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/pubDate!=''">
																<xsl:element name="pubdate">
																	<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/pubDate"/>														
																</xsl:element>
															</xsl:when>
															<xsl:otherwise>
																<xsl:element name="pubdate"><xsl:value-of select="'Unknown'"/></xsl:element>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:element name="title">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/title"/>			
														</xsl:element>
														<xsl:element name="geoform">
															<xsl:value-of select="'Standard'"/>																	
														</xsl:element>
														<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/series!=''">
															<xsl:element name="serinfo">
																<xsl:element name="sername">
																	<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/series"/>														
																</xsl:element>
																<xsl:element name="issue"><xsl:value-of select="'Unknown'"/></xsl:element>
															</xsl:element>
														</xsl:if>
														<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/distribution/online/url!=''">
															<xsl:element name="onlink">
																<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/temporalCoverage/rangeOfDates/endDate/alternativeTimeScale/timeScaleCitation/distribution/online/url"/>														
															</xsl:element>
														</xsl:if>
													</xsl:element>
												</xsl:element>
											</xsl:if>
										</xsl:element>
									</xsl:element>
									</xsl:element>
								</xsl:when>	<!-- end alternative time scale of date range -->
								<xsl:otherwise>  <!-- well, there is no temporal coverage after all .. -->
									<xsl:element name="sngdate">
										<xsl:element name="caldate">
											<xsl:value-of select="'N/A'"/>
										</xsl:element>
									</xsl:element>
								</xsl:otherwise>
								</xsl:choose>
							</xsl:when>   <!-- end range of dates (singledates<1) -->							
						</xsl:choose>         
          </xsl:element> <!-- end of timeinfo -->
          <xsl:element name="current">
			 <xsl:value-of select="'as it was at time of compilation'"/>  
          </xsl:element>
        </xsl:element>    <!-- end of timeper -->
        <xsl:element name="status">
          <xsl:element name="progress">
          <!-- allowed values for progress are 'Complete' 'In work' and 'Planned'. ISG: In EML we consider this document self-contained and complete -->
            <xsl:value-of select="'Complete'"/>     
          </xsl:element>
          <xsl:element name="update">
            <xsl:choose>
              <xsl:when test="/*[local-name() = 'eml']/dataset/maintenance!=''"> <!-- ISG :we should consider all EML maintenance tag, not just the optional frequency. -->
                <xsl:value-of select="/*[local-name() = 'eml']/dataset/maintenance"/> <!-- flatten out all element -->
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="'Unknown'"/>
              </xsl:otherwise>
            </xsl:choose>
           </xsl:element>
        </xsl:element>
        
        <!-- spatial domain; esp bounding box info goes here -->
        <!-- need to handle possible 'references' element here
             Also, geographicCoverage is repeatable in eml2, but is NOT repeatable in fgdc;
             This implementation just insert data from the first instance -->
        <xsl:choose>
          <!-- this 'when' test catches the top level geographic coverage element -->
          <xsl:when test="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage!=''">
            <xsl:element name="spdom">
					<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/geographicDescription">
						<xsl:element name="descgeog">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
					<xsl:element name="bounding">
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/westBoundingCoordinate">				
							<xsl:element name="westbc">
								<xsl:value-of select="."/>
							</xsl:element>									
						</xsl:for-each>
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/eastBoundingCoordinate">
							<xsl:element name="eastbc">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/northBoundingCoordinate">
							<xsl:element name="northbc">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/southBoundingCoordinate">
							<xsl:element name="southbc">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
						<xsl:element name="boundalt">
							<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/boundingAltitudes/altitudeMinimum">
								<xsl:element name="altmin">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
							<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/boundingAltitudes/altitudeMaximum">
								<xsl:element name="almax">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
							<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/boundingCoordinates/boundingAltitudes/altitudeUnits">
								<xsl:element name="altunits">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:element>
					<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon!=''">
					<xsl:element name="dsgpoly">
						<xsl:element name="dsgpolyo">
							<xsl:choose>
								<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRingPoint/gRingLatitude!=''">
									<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRingPoint">
										<xsl:element name="grngpoin">
											<xsl:element name="gringlat">
												<xsl:value-of select="gRingLatitude"/>
											</xsl:element>
											<xsl:element name="gringlon">
												<xsl:value-of select="gRingLongitude"/>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRing/gRingLatitude!=''">		
								<!-- in this case we are dealing with pairs of latitude-longitude pairs that are mapped into gring in the BDP standard -->
									<xsl:element name="gring">
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRing/gRingLatitude"/>
										<xsl:value-of select="','"/>
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRing/gRingLongitude"/>
									</xsl:element>
								</xsl:when>							
							</xsl:choose>
						</xsl:element>
						<!-- in EML, the exclusion or Inner ring is optional.. so if it is not existing, make it a zero in bdp -->
						<xsl:element name="dsgpolyx">
							<xsl:choose>
								<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRingPoint/gRingLatitude!=''">
									<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRingPoint">
										<xsl:element name="grngpoin">
											<xsl:element name="gringlat">
												<xsl:value-of select="gRingLatitude"/>
											</xsl:element>
											<xsl:element name="gringlon">
												<xsl:value-of select="gRingLongitude"/>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRing/gRingLatitude!=''">		
								<!-- in this case we are dealing with pairs of latitude-longitude pairs that are mapped into gring in the BDP standard -->
								<!-- as is, it will flatten the contents into the gring. It may need some work to be more accurate -->
									<xsl:element name="gring">
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRing/gRingLatitude"/>
										<xsl:value-of select="','"/>
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRing/gRingLongitude"/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="grngpoin">
										<xsl:element name="gringlat" />
										<xsl:element name="gringlon"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element><!-- end dspoly el -->
					</xsl:if>
				</xsl:element>
          </xsl:when>
          <!-- Use geocoverage if it is part of the first entitiy -->
          <xsl:when test="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage!=''">
           <xsl:element name="spdom">
					<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/geographicDescription">
						<xsl:element name="descgeog">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
					<xsl:element name="bounding">
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/westBoundingCoordinate">				
							<xsl:element name="westbc">
								<xsl:value-of select="."/>
							</xsl:element>									
						</xsl:for-each>
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/eastBoundingCoordinate">
							<xsl:element name="eastbc">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/northBoundingCoordinate">
							<xsl:element name="northbc">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
						<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/southBoundingCoordinate">
							<xsl:element name="southbc">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
						<xsl:element name="boundalt">
							<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/boundingAltitudes/altitudeMinimum">
								<xsl:element name="altmin">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
							<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/boundingAltitudes/altitudeMaximum">
								<xsl:element name="almax">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
							<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/boundingCoordinates/boundingAltitudes/altitudeUnits">
								<xsl:element name="altunits">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:element>
					<xsl:if test="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon!=''">
					<xsl:element name="dsgpoly">
						<xsl:element name="dsgpolyo">
							<xsl:choose>
								<xsl:when test="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRingPoint/gRingLatitude!=''">
									<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRingPoint">
										<xsl:element name="grngpoin">
											<xsl:element name="gringlat">
												<xsl:value-of select="gRingLatitude"/>
											</xsl:element>
											<xsl:element name="gringlon">
												<xsl:value-of select="gRingLongitude"/>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRing/gRingLatitude!=''">		
								<!-- in this case we are dealing with pairs of latitude-longitude pairs that are mapped into gring in the BDP standard -->
									<xsl:element name="gring">
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRing/gRingLatitude"/>
										<xsl:value-of select="','"/>
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonOuterGRing/gRing/gRingLongitude"/>
									</xsl:element>
								</xsl:when>							
							</xsl:choose>
						</xsl:element>
						<!-- in EML, the exclusion or Inner ring is optional.. so if it is not existing, make it a zero in bdp -->
						<xsl:element name="dsgpolyx">
							<xsl:choose>
								<xsl:when test="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRingPoint/gRingLatitude!=''">
									<xsl:for-each select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRingPoint">
										<xsl:element name="grngpoin">
											<xsl:element name="gringlat">
												<xsl:value-of select="gRingLatitude"/>
											</xsl:element>
											<xsl:element name="gringlon">
												<xsl:value-of select="gRingLongitude"/>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRing/gRingLatitude!=''">		
								<!-- in this case we are dealing with pairs of latitude-longitude pairs that are mapped into gring in the BDP standard -->
								<!-- as is, it will flatten the contents into the gring. It may need some work to be more accurate -->
									<xsl:element name="gring">
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRing/gRingLatitude"/>
										<xsl:value-of select="','"/>
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/*/coverage/geographicCoverage/datasetGPolygon/datasetGPolygonExclusionGRing/gRing/gRingLongitude"/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="grngpoin">
										<xsl:element name="gringlat" />
										<xsl:element name="gringlon"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element><!-- end dspolyg element -->
					</xsl:if>					
				</xsl:element>
          </xsl:when>
        </xsl:choose>
        
        <xsl:element name="keywords">
          <xsl:choose>
            <xsl:when test="/*[local-name() = 'eml']/dataset/keywordSet!=''">
              <xsl:for-each select="/*[local-name() = 'eml']/dataset/keywordSet">
                <xsl:variable name="current_thes" select="/*[local-name() = 'eml']/dataset/keywordSet/keywordThesaurus"/>
                <xsl:for-each select="./keyword">
                  <xsl:choose>
                    <xsl:when test="./@keywordType='theme'">
                      <xsl:element name="theme">
                        <xsl:element name="themekt">
                          <xsl:choose>
                            <xsl:when test="$current_thes!=''">
                              <xsl:value-of select="$current_thes"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="'N/A'"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:element>
                        <xsl:element name="themekey">
                          <xsl:value-of select="."/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:when>
                    <xsl:when test="./@keywordType='place'">
                      <xsl:element name="place">
                        <xsl:element name="placekt">
                          <xsl:choose>
                            <xsl:when test="$current_thes!=''">
                              <xsl:value-of select="$current_thes"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="'N/A'"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:element>
                        <xsl:element name="placekey">
                          <xsl:value-of select="."/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:when>
                    <xsl:when test="./@keywordType='stratum'">
                      <xsl:element name="stratum">
                        <xsl:element name="stratkt">
                          <xsl:choose>
                            <xsl:when test="$current_thes!=''">
                              <xsl:value-of select="$current_thes"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="'N/A'"/>
                            </xsl:otherwise>
                          </xsl:choose>
                      </xsl:element>
                        <xsl:element name="stratkey">
                          <xsl:value-of select="."/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:when>
                    <xsl:when test="./@keywordType='temporal'">
                      <xsl:element name="temporal">
                        <xsl:element name="tempkt">
                          <xsl:choose>
                            <xsl:when test="$current_thes!=''">
                              <xsl:value-of select="$current_thes"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="'N/A'"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:element>
                        <xsl:element name="tempkey">
                          <xsl:value-of select="."/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:element name="theme">
                        <xsl:element name="themekt">
                          <xsl:choose>
                            <xsl:when test="$current_thes!=''">
                              <xsl:value-of select="$current_thes"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="'N/A'"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:element>
                        <xsl:element name="themekey">
                          <xsl:value-of select="."/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="theme">
                <xsl:element name="themekt">
                  <xsl:value-of select="'N/A'"/>
                </xsl:element>
                <xsl:element name="themekey">
                  <xsl:value-of select="'N/A'"/>
                </xsl:element>
              </xsl:element>  
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>  
          
        <!-- loop over all coverage elements in the eml2 doc -->
        <xsl:for-each select="/*[local-name() = 'eml']//coverage">
          <!-- 'references' handling for coverage -->
          <xsl:variable name="cc_cov">
              <xsl:choose>
                  <xsl:when test="./references!=''">
                    <xsl:variable name="ref_id" select="./references"/>
                    <!-- current element just references its contents 
                    There should only be a single node with an id attribute
                    which matches the value of the references element -->
                    <xsl:copy-of select="$ids[@id=$ref_id]"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- no references tag, thus use the current node -->
                    <xsl:copy-of select="."/>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="xalan:nodeset($cc_cov)//taxonomicCoverage!=''">
              <xsl:element name="taxonomy">  <!-- oversight  there might be some keywordType of type taxonomic -->
                <xsl:element name="keywtax">
                  <xsl:element name="taxonkt">
                    <xsl:value-of select="'None'"/>
                  </xsl:element>                  
				  <xsl:if test="eml:eml/dataset/keywordSet/keyword!=''"> <!-- group added , perhaps there were taxon keywds -->
						<xsl:for-each select="eml:eml/dataset/keywordSet/keyword"> <!-- loop thru all keywds, extract thos that are taxonomic (had to be specified as such) -->
							<xsl:choose>
								<xsl:when test="@keywordType='taxonomic'">
									<xsl:element name="taxonkey">
										<xsl:value-of select="."/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="taxonkey">                  
										<xsl:value-of select="'N/A'"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
				  </xsl:if>                  
                </xsl:element>
                <xsl:for-each select="xalan:nodeset($cc_cov)//taxonomicCoverage/taxonomicClassification">
                  <!-- add 'references' handling for taxonomicCoverage here -->
                  <xsl:variable name="cc_taxon">
                    <xsl:choose>
                      <xsl:when test="./references!=''">
                        <xsl:variable name="ref_id" select="./references"/>
                        <!-- current element just references its contents 
                        There should only be a single node with an id attribute
                        which matches the value of the references element -->
                        <xsl:copy-of select="$ids[@id=$ref_id]"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- no references tag, thus use the current node -->
                        <xsl:copy-of select="."/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <!-- inserted lots of code for taxon coverage HERE  ISG -->
                  		   <!-- all these elements are mandatory if applicable, until the taxonomic classification, that is mandatory
							however, if you put something here, then you need at least classsys and classcit/citeinfo+mandatory citeinfo els., 
							last we would also need taxonomic procedures -->
					<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem!=''">
    					<xsl:element name="taxonsys">
							<xsl:element name="classsys">
								<xsl:element name="classcit">
									<xsl:element name="citeinfo">
										<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/creator/individualName/surName">
											<xsl:element name="origin"><!-- this is also mandatory in EML (when parent is populated)-->
												<xsl:value-of select="."/>
											</xsl:element>
										</xsl:for-each>
										<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/creator/organizationName">
											<xsl:element name="origin">
												<xsl:value-of select="."/>
											</xsl:element>
										</xsl:for-each>
										<xsl:choose>
											<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/pubDate!=''">
												<xsl:element name="pubdate">
													<xsl:value-of select="eml:eml/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/pubDate"/>
												</xsl:element>
											</xsl:when> <!-- pubdate not required in EML, have choice -->
											<xsl:otherwise><xsl:element name="pubdate"><xsl:value-of select="'N/A'"/></xsl:element></xsl:otherwise>
										</xsl:choose>
										<xsl:element name="title"> <!-- mandatory in EML (when parent element is populated -->
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/title"/>
										</xsl:element>
										<xsl:element name="geoform"><!-- hard coded -->
											<xsl:value-of select="'Standard'"/>
										</xsl:element>
										<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/series!=''">
											<xsl:element name="serinfo">
												<xsl:element name="sername">
													<xsl:value-of select="."/>
												</xsl:element>
												<xsl:element name="issue">
													<xsl:value-of select="'Unknown'"/>
												</xsl:element>
											</xsl:element>
										</xsl:if>
										<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/distribution/online/url!=''">
											<xsl:element name="onlink">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemCitation/distribution/online/url"/>
											</xsl:element>
										</xsl:if>
									</xsl:element> <!-- end of citeinfo -->
								</xsl:element>    <!-- end of classcit-->
								<xsl:choose>
									<xsl:when test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemModifications!=''">
										<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/classificationSystem/classificationSystemModifications">
											<xsl:element name="classmod">			
												<xsl:value-of select="."/>
											</xsl:element>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:element name="classmod">			
											<xsl:value-of select="'None'"/>
										</xsl:element>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element> <!-- end of classsys -->		
							<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference!=''"><!--optional in EML-->
									<xsl:element name="idref">
										<xsl:element name="citeinfo">
											<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/creator/individualName/surname">
												<xsl:element name="origin">
													<xsl:value-of select="."/>
												</xsl:element>
											</xsl:for-each><!-- somewhere here. lots of conditionals to be placed before this line -->
											<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/creator/organizationName">
												<xsl:element name="origin">
													<xsl:value-of select="."/>
												</xsl:element>
											</xsl:for-each>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/pubDate!=''">
												<xsl:element name="pubdate">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/pubDate"/>
												</xsl:element>
											</xsl:if>
											<xsl:element name="geoform">
												<xsl:value-of select="'Standard'"/>
											</xsl:element>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/series!=''">
												<xsl:element name="serinfo">
													<xsl:element name="sername">
														<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/series"/>
													</xsl:element>
													<xsl:element name="issue">
														<xsl:value-of select="'Unknown'"/>
													</xsl:element>
												</xsl:element>
											</xsl:if>
											<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/distribution/online/url!=''">
												<xsl:element name="onlink">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identificationReference/distribution/online/url"/>
												</xsl:element>
											</xsl:if>
										</xsl:element>
									</xsl:element> <!-- end of ider -->
							</xsl:if> <!-- endif idref (identificationReference) -->
							<xsl:element name="ider"> <!-- if taxonomic System exist in EML, this is mandatory -->
									<xsl:element name="cntinfo">
										<xsl:element name="cntperp">
											<xsl:element name="cntper">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/individualName/surName"/>
												<xsl:value-of select="', '"/>
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/individualName/givenName"/>												
											</xsl:element>
											<xsl:element name="cntorg">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/organizationName"/>
									        </xsl:element>
										</xsl:element>
										<xsl:element name="cntorgp">
											<xsl:element name="cntorg">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/organizationName"/>
									        </xsl:element>
										    <xsl:element name="cntper">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/individualName/surName"/>
												<xsl:value-of select="', '"/>
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/individualName/givenName"/>												
											</xsl:element>
										</xsl:element>
										<xsl:element name="cntaddr">
											<xsl:element name="addresstype">
												<xsl:value-of select="'Mailing'"/>
											</xsl:element>
											<xsl:element name="address">
												<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/address/deliveryPoint">
													<xsl:value-of select="."/>
												</xsl:for-each>
											</xsl:element>
											<xsl:element name="city">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/address/city"/>
											</xsl:element>
											<xsl:element name="state">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/address/administrativearea"/>
											</xsl:element>
											<xsl:element name="postal">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/address/postal"/>
											</xsl:element>
											<xsl:element name="country">
												<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/address/country"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="cntvoice">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/phone"/>
										</xsl:element>
										<xsl:element name="cntemail">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/identifierName/electronicMailAddress"/>
										</xsl:element>
									</xsl:element>
							</xsl:element> <!-- end of ider (identifierName) -->
							<xsl:element name="taxonpro">
									<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/taxonomicProcedures"/>
							</xsl:element>
							<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/taxonomicCompleteness!=''">
									<xsl:element name="taxoncom">
										<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/taxonomicCompleteness"/>
									</xsl:element>
							</xsl:if>
							<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers!=''">
									<xsl:element name="vouchers">
										<xsl:element name="specimen">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/specimen"/>
										</xsl:element>
										<xsl:element name="reposit">
											<xsl:element name="cntinfo">
													<xsl:element name="cntperp">
														<xsl:element name="cntper">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/individualName/surName"/>
															<xsl:value-of select="', '"/>
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/individualName/givenName"/>
														</xsl:element>
														<xsl:element name="cntorg">	
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/organizationName"/>
														</xsl:element>
													</xsl:element>
													<xsl:element name="cntorgp">
														<xsl:element name="cntorg">	
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/organizationName"/>
														</xsl:element>
														<xsl:element name="cntper">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/individualName/surName"/>
															<xsl:value-of select="', '"/>
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/individualName/givenName"/>
														</xsl:element>
													</xsl:element>
													<xsl:element name="cntaddr">
														<xsl:element name="addresstype">
															<xsl:value-of select="'Mailing'"/>
														</xsl:element>
														<xsl:element name="address">
															<xsl:for-each select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/address/deliveryPoint">
																<xsl:value-of select="."/>
															</xsl:for-each>
														</xsl:element>
														<xsl:element name="city">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/address/city"/>
														</xsl:element>
														<xsl:element name="state">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/address/administrativeArea"/>
														</xsl:element>
														<xsl:element name="postal">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/address/postalCode"/>
														</xsl:element>
														<xsl:element name="country">
															<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/address/country"/>
														</xsl:element>
													</xsl:element>
													<xsl:element name="cntvoice">
														<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/phone"/>
													</xsl:element>
													<xsl:element name="cntemail">
														<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/taxonomicSystem/vouchers/repository/originator/electronicMailAddress"/>
													</xsl:element>
											</xsl:element> <!-- end of cntinfo -->
										</xsl:element> <!-- reposit -->
									</xsl:element> <!-- end of vouchers -->
							</xsl:if> <!-- endif vouchers -->
						</xsl:element> <!-- end of Taxonomic System MAY BE MISSING AN </EL>-->
					</xsl:if> <!--possible end of conditional for taxonsssys -->
					<xsl:if test="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/generalTaxonomicCoverage">
						<xsl:element name="taxongen">
							<xsl:value-of select="/*[local-name() = 'eml']/dataset/coverage/taxonomicCoverage/generalTaxonomicCoverage"/>
						</xsl:element>
					</xsl:if>  <!-- end of code insertion (taxonomic Coverage ) -->
                  <xsl:element name="taxoncl">
                    <xsl:element name="taxonrn">
                      <xsl:choose>
                        <xsl:when test="xalan:nodeset($cc_taxon)//taxonRankName!=''">
                          <xsl:value-of select="xalan:nodeset($cc_taxon)//taxonRankName"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="'N/A'"/>
                        </xsl:otherwise>
                      </xsl:choose>  
                    </xsl:element>
                    <xsl:element name="taxonrv">
                      <xsl:choose>
                        <xsl:when test="xalan:nodeset($cc_taxon)//taxonRankValue!=''">
                          <xsl:value-of select="xalan:nodeset($cc_taxon)//taxonRankValue"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="'N/A'"/>
                        </xsl:otherwise>
                      </xsl:choose>  
                    </xsl:element>
                    <xsl:element name="common">
                      <xsl:choose>
                        <xsl:when test="xalan:nodeset($cc_taxon)//commonName!=''">
                          <xsl:value-of select="xalan:nodeset($cc_taxon)//commonName"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="'N/A'"/>
                        </xsl:otherwise>
                      </xsl:choose>  
                    </xsl:element>
                    <xsl:if test="xalan:nodeset($cc_taxon)//taxonomicClassification!=''">
                      <xsl:call-template name="taxonClTemplate">
                        <xsl:with-param name="cur_tc" select="xalan:nodeset($cc_taxon)//taxonomicClassification"/>
                      </xsl:call-template>
                    </xsl:if>
                    
                  </xsl:element>
                </xsl:for-each>  
              </xsl:element>
            </xsl:when>  
          </xsl:choose>  
        </xsl:for-each>
        
        <xsl:choose>
          <xsl:when test="/*[local-name() = 'eml']/dataset/access!='' or /*[local-name() = 'eml']/access!=''">
            <xsl:element name="accconst">
			   <xsl:for-each select="/*[local-name() = 'eml']/dataset/access/allow | /*[local-name() = 'eml']/access/allow">	
					<xsl:value-of select="'Allow  '"/><xsl:value-of select="permission"/><xsl:value-of select="' to users: '"/><xsl:value-of select="principal"/>
					<xsl:text>
					</xsl:text><!-- a separator -->
				</xsl:for-each>
				<xsl:for-each select="/*[local-name() = 'eml']/dataset/access/deny | /*[local-name() = 'eml']/access/deny">	
					<xsl:value-of select="'Deny  '"/><xsl:value-of select="permission"/><xsl:value-of select="' to users: '"/><xsl:value-of select="principal"/>
                    <xsl:text>
					</xsl:text><!-- a separator -->
				</xsl:for-each>
            </xsl:element>  
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="accconst">
              <xsl:value-of select="'N/A'"/>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>  
        <xsl:choose>
			<xsl:when test="/*[local-name() = 'eml']/dataset/intellectualRights!=''">
				<xsl:element name="useconst">
					<xsl:value-of select="/*[local-name() = 'eml']/dataset/intellectualRights"/>
				</xsl:element>  
			</xsl:when>
            <xsl:otherwise>
            <xsl:element name="useconst">
              <xsl:value-of select="'N/A'"/>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>  

        <xsl:if test="$show_optional">
          <xsl:element name="ptcontac">  <!-- ISG, added contact info.  -->
			  <xsl:element name="cntinfo">
				<xsl:for-each select="/*[local-name() = 'eml']/dataset/contact[1]">  <!-- Here is the 1st EML contact found. -->
				  <xsl:variable name="contact_c">
						<xsl:choose>
						  <xsl:when test="./references!=''">
							<xsl:variable name="ref_id" select="./references"/>
							<xsl:copy-of select="$ids[@id=$ref_id]"/>
						  </xsl:when>
						  <xsl:otherwise>
								<!-- no references tag, thus use the current node -->
							<xsl:copy-of select="."/>
						  </xsl:otherwise>
						</xsl:choose>
				  </xsl:variable>		  
				  <xsl:choose>
				    <xsl:when test="xalan:nodeset($contact_c)//individualName!=''">			  
					  <xsl:element name="cntperp">
						  <xsl:element name="cntper">
							<xsl:value-of select="xalan:nodeset($contact_c)//individualName/surName" />
							<xsl:value-of select="', '"/>
							<xsl:value-of select="xalan:nodeset($contact_c)//individualName/givenName" />
						  </xsl:element>
						  <xsl:if test="xalan:nodeset($contact_c)//organizationName!=''">
							  <xsl:element name="cntorg">
								<xsl:value-of select="xalan:nodeset($contact_c)//organizationName"/>
							  </xsl:element>
						  </xsl:if>
					  </xsl:element>
					</xsl:when>
					<xsl:when test="xalan:nodeset($contact_c)//organizationName!=''">
						<xsl:element name="cntorgp">
							<xsl:element name="cntorg"> 
								<xsl:value-of select="xalan:nodeset($contact_c)//organizationName"/>
							</xsl:element>
							<xsl:if test="xalan:nodeset($contact_c)//individualName/surname!=''">
								<xsl:element name="cntper">
									<xsl:value-of select="xalan:nodeset($contact_c)//individualName/surName"/>
									<xsl:value-of select="', '"/>
									<xsl:value-of select="xalan:nodeset($contact_c)//individualName/givenName"/>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>  <!-- in this case, the EML doc. has "positionName" as contact. Name organization, then add in BDP this position name (optional here)-->
						<xsl:element name="cntorgp">
							<xsl:element name="cntorg">
								<xsl:choose>
									<xsl:when test="xalan:nodeset($contact_c)//organizationName!=''">
										<xsl:value-of select="xalan:nodeset($contact_c)//organizationName"/>
									</xsl:when>
									<xsl:otherwise> <!-- in this case we have no idea where the org name is, so let's shoot for the first "delivery point" line in address..hope for the best.-->
										<xsl:value-of select="xalan:nodeset($contact_c)//address/deliveryPoint"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</xsl:element>
						<xsl:element name="cntper">
							<xsl:value-of select="xalan:nodeset($contact_c)//positionName"/>
						</xsl:element>
					</xsl:otherwise>
				  </xsl:choose>
				  <xsl:if test="xalan:nodeset($contact_c)//positionName">
					  <xsl:element name="cntpos"><xsl:value-of select="xalan:nodeset($contact_c)//positionName"/></xsl:element>
				  </xsl:if>
				<xsl:element name="addrtype">
                   <xsl:value-of select="'Mailing'"/>
                </xsl:element>
				<xsl:element name="cntaddr">
					<xsl:for-each select="xalan:nodeset($contact_c)//address/deliveryPoint">
						<xsl:element name="address">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
					<xsl:choose>
						<xsl:when test="xalan:nodeset($contact_c)//address/city!=''">
							<xsl:element name="city">
								<xsl:value-of select="xalan:nodeset($contact_c)//address/city"/>
							</xsl:element>
                        </xsl:when>
                        <xsl:otherwise><xsl:element name="city"><xsl:value-of select="'N/A'"/></xsl:element></xsl:otherwise>
    				</xsl:choose>
    				<xsl:choose>
						<xsl:when test="xalan:nodeset($contact_c)//address/administrativeArea!=''">
							<xsl:element name="state">
								<xsl:value-of select="xalan:nodeset($contact_c)//address/administrativeArea"/>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise><xsl:element name="state"><xsl:value-of select="'N/A'"/></xsl:element></xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="xalan:nodeset($contact_c)//address/postalCode!=''">
							<xsl:element name="postal">
								<xsl:value-of select="xalan:nodeset($contact_c)//address/postalCode"/>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise><xsl:element name="postal"><xsl:value-of select="'N/A'"/></xsl:element></xsl:otherwise>
					</xsl:choose>
					<xsl:if test="xalan:nodeset($contact_c)//address/country!=''">
						<xsl:element name="country">
							<xsl:value-of select="xalan:nodeset($contact_c)//address/country"/>
						</xsl:element>
					</xsl:if>
				</xsl:element>
				<xsl:if test="xalan:nodeset($contact_c)//phone!=''">
					<xsl:for-each select="xalan:nodeset($contact_c)//phone">
						<xsl:if test="@phonetype='voice'">
							<xsl:element name="cntvoice">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:if>
						<xsl:if test="@phonetype='fax'">
							<xsl:element name="cntfax">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="xalan:nodeset($contact_c)//electronicMailAddress!=''">
					<xsl:element name="cntemail">
						<xsl:value-of select="xalan:nodeset($contact_c)//electronicMailAddress"/>
					</xsl:element>
				</xsl:if>
			    </xsl:for-each>			
			  </xsl:element>
          </xsl:element>
        </xsl:if>
        <xsl:if test="$show_optional">
          <xsl:element name="browse">
          </xsl:element>
        </xsl:if>
        <xsl:if test="$show_optional">
          <xsl:element name="datacred"> <!-- add either an associated Parties and funding agency. lump all here..-->
			 <xsl:for-each select="/*[local-name() = 'eml']/dataset/associatedParty">
				  <xsl:text>  
					</xsl:text><!-- put a new line character -->
				 <xsl:value-of select="individualName/surName"/>
				 <xsl:value-of select="', '"/> 
				 <xsl:value-of select="individualName/givenName"/>
				 <xsl:if test="role!=''">
					<xsl:text>
					</xsl:text><!-- put a new line character -->
					 <xsl:value-of select="'position name:'"/><xsl:value-of select="role"/>
				 </xsl:if>
			 </xsl:for-each>
			 <xsl:if test="/*[local-name() = 'eml']/dataset/project/funding!=''">
				 <xsl:text>    
   				 </xsl:text><!-- put a new line character -->
				 <xsl:value-of select="'Funding:'"/><xsl:value-of select="/*[local-name() = 'eml']/dataset/project/funding"/>
			 </xsl:if>
          </xsl:element>
        </xsl:if>
        <xsl:if test="$show_optional">
          <xsl:element name="secinfo">
          </xsl:element>
        </xsl:if>
        <xsl:if test="$show_optional">
          <xsl:element name="native">
          </xsl:element>
        </xsl:if>
        <xsl:if test="$show_optional">
          <xsl:element name="crossref">
          </xsl:element>
        </xsl:if>
        <xsl:if test="$show_optional">
          <xsl:element name="tool">
          </xsl:element>
        </xsl:if>
     </xsl:element>
     
     <!-- section 2 "data quality info" in BDP is expanded using metadata from EML methods -->        
      
      <xsl:if test="$show_optional"> 
		  <xsl:element name="dataqual">

			<xsl:element name="logic">
				<xsl:choose>
					<xsl:when test="/*[local-name() = 'eml']/dataset/methods/qualityControl!=''">
						<xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/qualityControl/description"/>
					    <xsl:if test="/*[local-name() = 'eml']/dataset/methods/qualityControl/protocol!=''">
							<xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/qualityControl/protocol"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'Not Applicable'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:element name="complete"><xsl:value-of select="Unknown"/></xsl:element>
			<xsl:element name="lineage">
				<xsl:if test="/*[local-name() = 'eml']/dataset/methods/methodStep!=''">
					<xsl:for-each select="/*[local-name() = 'eml']/dataset/methods/methodStep">
						<xsl:element name="method">
							<xsl:element name="methodtype">
								<xsl:value-of select="'Method Type; field, lab, etc'"/>
							</xsl:element>
							<xsl:element name="methoddesc">
								<xsl:value-of select="description"/>
							</xsl:element>
							<xsl:if test="/*[local-name() = 'eml']/dataset/methods/methodStep/citation!=''">
								<xsl:element name="methcite">
									<xsl:element name="citeinfo">
										<xsl:element name="origin">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/methodStep/citation/creator"/>
										</xsl:element>
										<xsl:element name="pubdate">
											<xsl:choose>
												<xsl:when test="/*[local-name() = 'eml']/dataset/methods/methodStep/citation/pubDate!=''">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/methodStep/citation/pubDate"/>
												</xsl:when>
												<xsl:otherwise><xsl:value-of select="'N/A'"/></xsl:otherwise>
											</xsl:choose>
										</xsl:element>
										<xsl:element name="title"><xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/methodStep/citation/title"/></xsl:element>
										<xsl:element name="geoform"><xsl:value-of select="'document'"/></xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="/*[local-name() = 'eml']/dataset/methods/sampling!=''">
					<xsl:element name="method">
						<xsl:element name="methodtype">
							<xsl:value-of select="'Sampling methods'"/>
						</xsl:element>
							<xsl:element name="methoddesc">
								<xsl:value-of select="samplingDescription"/>
								<xsl:value-of select="studyExtent"/>
							</xsl:element>
							<xsl:if test="/*[local-name() = 'eml']/dataset/methods/sampling/citation!=''">
								<xsl:element name="methcite">
									<xsl:element name="citeinfo">
										<xsl:element name="origin">
											<xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/sampling/citation/creator"/>
										</xsl:element>
										<xsl:element name="pubdate">
											<xsl:choose>
												<xsl:when test="/*[local-name() = 'eml']/dataset/methods/sampling/citation/pubDate!=''">
													<xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/sampling/citation/pubDate"/>
												</xsl:when>
												<xsl:otherwise><xsl:value-of select="'N/A'"/></xsl:otherwise>
											</xsl:choose>
										</xsl:element>
										<xsl:element name="title"><xsl:value-of select="/*[local-name() = 'eml']/dataset/methods/sampling/citation/title"/></xsl:element>
										<xsl:element name="geoform"><xsl:value-of select="'document'"/></xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:if>
					</xsl:element>
				</xsl:if>
				<xsl:element name="procstep">
					<xsl:element name="procdesc">
						<xsl:value-of select="'Read Methods description above if applies'"/>
					</xsl:element>
					<xsl:element name="procdate">
						<xsl:value-of select="'Read method descriptions if applicable'"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
      
        </xsl:element>   <!-- end data quality section of BDP -->
      </xsl:if>
      
<!-- spatial domain information -->
<!-- It appears that nbii does not allow multiple spatial domain metadata trees,
      while eml2 allows multiple copies of spatialRaster and spatialVector entities.
      Only the first set of spatial data will be copied -->
      
      <!-- NEED TO HANDLE 'REFERENCES' -->
      <xsl:if test="/*[local-name() = 'eml']/dataset/spatialRaster!=''">
        <!-- apparently, there are numerous elements in eml2 spatialRaster
             which have no equivalent in nbii/fgdc rastinfo element! -->
        <xsl:element name="spdoinfo">
          <xsl:element name="direct">
            <xsl:value-of select="'Raster'"/>
          </xsl:element>
          <xsl:element name="rastinfo">
            <xsl:element name="rasttype">
            <!-- apparently this element corresponds to the 'cellGeometry' element
                 in eml2, which only has allowed values of 'pixel' and 'matrix';
                 in fgdc, this element has allowed values of 'Point', 'Pixel', 
                 'Grid Cell' or 'Voxel'-->
              <xsl:choose>
                <xsl:when test="/*[local-name() = 'eml']/dataset/spatialRaster/cellGeometry='pixel'">
                  <xsl:value-of select="'Pixel'"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'Grid Cell'"/>                
                </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
            <xsl:element name="rowcount">
              <xsl:value-of select="/*[local-name() = 'eml']/dataset/spatialRaster/rows"/>
            </xsl:element>
            <xsl:element name="colcount">
              <xsl:value-of select="/*[local-name() = 'eml']/dataset/spatialRaster/columns"/>
            </xsl:element>
            <xsl:element name="vrtcount">
              <xsl:value-of select="/*[local-name() = 'eml']/dataset/spatialRaster/verticals"/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <!-- NEED TO HANDLE 'REFERENCES' -->
      <xsl:if test="/*[local-name() = 'eml']/dataset/spatialVector!=''">
        <xsl:element name="spdoinfo">
          <xsl:element name="direct">
            <xsl:value-of select="'Vector'"/>
          </xsl:element>
          <xsl:for-each select="/*[local-name() = 'eml']/dataset/spatialVector/geometry">
            <xsl:element name="ptvctinf">
              <xsl:element name="sdtsterm">
                <xsl:element name="sdtstype">
                  <xsl:variable name="geotype" select="/*[local-name() = 'eml']/dataset/spatialVector/geometry"/>
                  <!-- mapping of eml2 geometry types to fgdc; multi... types very uncertain! -->
				   <xsl:choose>
								<xsl:when test="$geotype='LineString'"><xsl:value-of select="'String'"/></xsl:when>
								<xsl:when test="$geotype='LinearRing'"><xsl:value-of select="'Area chain'"/></xsl:when>
								<xsl:when test="contains($geotype,'Polygon')"><xsl:value-of select="'G-Polygon'"/></xsl:when>
								<xsl:when test="contains($geotype,'Point')"><xsl:value-of select="'Point'"/></xsl:when>
								<xsl:when test="$geotype='MultiLineString'"><xsl:value-of select="'Ring composed of strings'"/></xsl:when>
								<xsl:when test="$geotype='MultiGeometry'"><xsl:value-of select="'Node, network'"/></xsl:when>								
			      </xsl:choose>
                  <!--xsl:value-of select="$geometryTypeMap/*[@name=$geotype]/@sdtstype"/ --><!-- all group transformed here, since it was illegal XSL.(some noce ops are not applicable to temp. tree nodes (variables)-->
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:for-each>  
        </xsl:element>
      </xsl:if>
      
<!-- spatial reference information -->
<!-- As in other places, fgdc here seems designed for use with a single entity.
     EML2 allows multiple entities; for now, just handle the first one! -->

     <!-- The emlSpatialReferenceDictionary.xml has a large collection of horizCoordSysDefs defined
            by name for use in the spatialReference/horizCoordSysName element. The information here is
            basically the same as would be in the horizCoordSysDef tag -->
     
     <xsl:choose>
       <xsl:when test="/*[local-name() = 'eml']/dataset/spatialRaster/spatialReference!=''">
       <!-- Note: spatialRefenence is required in spatialRaster, but NOT in spatialVector! -->
         <xsl:choose>
           <xsl:when test="/*[local-name() = 'eml']/dataset/spatialRaster/spatialReference/horizCoordSysDef!=''">
             <xsl:element name="spref">
               <xsl:element name="horizsys">
                 <xsl:element name="planar">
                   <xsl:element name="mapproj"> 
                     <xsl:element name="mapprojn">
                       <xsl:choose>
                         <xsl:when test="//horizCoordSysDef/projCoordSys/projection/@name!=''">
                           <xsl:value-of select="//horizCoordSysDef/projCoordSys/projection/@name"/>
                         </xsl:when>
                         <xsl:otherwise>
                           <xsl:value-of select="'N/A'"/>
                         </xsl:otherwise>
                       </xsl:choose>
                     </xsl:element>
                     <xsl:element name="mapprojp">
                       <!-- eml has a set of arbitrary parameter (attributes) to describe a projection
                            fgdc, however, has a long list of named elements - how to map>??? 
                            Also, order of fgdc parameters does not match order in nbii1999.xsd  
                            -->
                            <xsl:element name="longcm">
                              <!-- longcm is the 'Central Meridian'; I think this corresponds to the 
                                   'primeMeridian' in eml -->
                              <xsl:value-of select="//horizCoordSysDef/geogCoordSys/primeMeridian/@longitude"/>
                            </xsl:element>
                     </xsl:element>
                   </xsl:element>
                 </xsl:element>
                 <xsl:element name="geodetic">
                   <xsl:element name="horizdn">
                     <xsl:value-of select="//horizCoordSysDef//geogCoordSys/datum/@name"/>
                   </xsl:element>
                   <xsl:element name="ellps">
                     <xsl:value-of select="//horizCoordSysDef//geogCoordSys/spheroid/@name"/>
                   </xsl:element>
                   <xsl:element name="semiaxis">
                     <xsl:value-of select="//horizCoordSysDef//geogCoordSys/spheroid/@semiAxisMajor"/>
                   </xsl:element>
                   <xsl:element name="denflat">
                     <xsl:value-of select="//horizCoordSysDef//geogCoordSys/spheroid/@denomFlatRation"/>
                   </xsl:element>
                 </xsl:element>
               </xsl:element>
             </xsl:element>
           </xsl:when>
         </xsl:choose>
       </xsl:when>
     </xsl:choose>  
      
      
<!-- start the 'eainfo' branch -->      
<!-- create only if there is entity data in the eml2 document --> 
   <!-- Need to test correct iterations over attributes... not so sure logic works-->
      <xsl:if test="/*[local-name() = 'eml']/dataset/dataTable!='' or /*[local-name() = 'eml']/dataset/spatialVector!='' or /*[local-name() = 'eml']/dataset/spatialRaster!=''  or /*[local-name() = 'eml']/dataset/storedProcedure!='' or /*[local-name() = 'eml']/dataset/view!='' or /*[local-name() = 'eml']/dataset/otherEntity!='' " >
        <xsl:element name="eainfo">
          <xsl:for-each select="(/*[local-name() = 'eml']/dataset/dataTable) | (/*[local-name() = 'eml']/dataset/spatialVector) | (/*[local-name() = 'eml']/dataset/spatialRaster) | (/*[local-name() = 'eml']/dataset/storedProcedure)  | (/*[local-name() = 'eml']/dataset/view)  | (/*[local-name() = 'eml']/dataset/otherEntity)  ">
           
            <xsl:variable name="cc">
              <xsl:choose>
                <xsl:when test="./references!=''">
                  <xsl:variable name="ref_id" select="./references"/>
                    <!-- current element just references its contents 
                    There should only be a single node with an id attribute
                    which matches the value of the references element -->
                   <xsl:copy-of select="$ids[@id=$ref_id]"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- no references tag, thus use the current node -->
                  <xsl:copy-of select="."/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <xsl:element name="detailed">
              <xsl:element name="enttyp">
                <xsl:element name="enttypl">
                  <xsl:value-of select="xalan:nodeset($cc)//entityName"/>
                </xsl:element>
                <xsl:choose>
                  <xsl:when test="xalan:nodeset($cc)//entityDescription!=''">
                    <xsl:element name="enttypd">
                      <xsl:value-of select="xalan:nodeset($cc)//entityDescription"/>
                    </xsl:element>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:element name="enttypd">
                      <xsl:value-of select="'N/A'"/>
                    </xsl:element>                  
                  </xsl:otherwise>
                </xsl:choose> 
                <xsl:element name="enttypds">
                  <xsl:value-of select="'N/A'"/>
                </xsl:element>
              </xsl:element>
              
              <xsl:for-each select="xalan:nodeset($cc)//attributeList/attribute">
              
                <xsl:variable name="cc-attr">
                    <xsl:choose>
                      <xsl:when test="./references!=''">
                          <xsl:variable name="ref_id" select="./references"/>
                          <xsl:copy-of select="$ids[@id=$ref_id]"/>
                      </xsl:when>
                    <xsl:otherwise>
                      <!-- no references tag, thus use the current node -->
                      <xsl:copy-of select="."/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                
                <xsl:element name="attr">
                  <xsl:element name="attrlabl">
                    <xsl:value-of select="concat(xalan:nodeset($cc-attr)//attributeName,':::',xalan:nodeset($cc-attr)//attributeLabel)"/>
                  </xsl:element>
                  <xsl:element name="attrdef">
                    <xsl:value-of select="xalan:nodeset($cc-attr)//attributeDefinition"/>
                  </xsl:element>
                  <xsl:element name="attrdefs">
                    <xsl:value-of select="'N/A'"/>
                  </xsl:element>
                  <xsl:element name="attrdomv">
                    <xsl:choose>
                      <xsl:when test="xalan:nodeset($cc-attr)//measurementScale//enumeratedDomain/codeDefinition!=''">
                        <xsl:for-each select="xalan:nodeset($cc-attr)//measurementScale//enumeratedDomain/codeDefinition">
                          <xsl:element name="edom">
                            <xsl:element name="edomv">
                              <xsl:value-of select="./code"/>
                            </xsl:element>
                            <xsl:element name="edomvd">
                              <xsl:value-of select="./definition"/>                            
                            </xsl:element>
                            <xsl:element name="edomvds">
                              <xsl:choose>
                                <xsl:when test="./source!=''">
                                  <xsl:value-of select="./source"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="N/A"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:element>
                          </xsl:element>
                        </xsl:for-each>
                      </xsl:when>
                      <xsl:when test="xalan:nodeset($cc-attr)//measurementScale//textDomain!=''">
                        <xsl:element name="udom">
                          <xsl:value-of select="xalan:nodeset($cc-attr)//measurementScale//textDomain"/>
                        </xsl:element>
                      </xsl:when>
                      <xsl:when test="xalan:nodeset($cc-attr)//measurementScale//numericDomain!=''">
                        <xsl:element name="rdom">
                          <xsl:element name="rdommin">
                            <xsl:choose>
                              <xsl:when test="xalan:nodeset($cc-attr)//measurementScale//numericDomain/bounds/minimum!=''">
                                <xsl:value-of select="xalan:nodeset($cc-attr)//measurementScale//numericDomain/bounds/minimum"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="N/A"/>
                              </xsl:otherwise>
                            </xsl:choose>    
                          </xsl:element>
                          <xsl:element name="rdommax">
                            <xsl:choose>
                              <xsl:when test="xalan:nodeset($cc-attr)//measurementScale//numericDomain/bounds/maximum!=''">
                                <xsl:value-of select="xalan:nodeset($cc-attr)//measurementScale//numericDomain/bounds/maximum"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="N/A"/>
                              </xsl:otherwise>
                            </xsl:choose>    
                          </xsl:element>
                          <xsl:element name="attrunit">
                                <xsl:value-of select="xalan:nodeset($cc-attr)//measurementScale//unit"/>							  
                          </xsl:element>
                        </xsl:element>
                      </xsl:when>
                      <xsl:when test="xalan:nodeset($cc-attr)//measurementScale/datetime!='' or xalan:nodeset($cc-attr)//measurementScale/dateTime!='' ">
                        <xsl:element name="udom">
                          <xsl:value-of select="'Date time'"/>
                          <xsl:value-of select="xalan:nodeset($cc-attr)//measurementScale/datetime | xalan:nodeset($cc-attr)//measurementScale/datetTime"/>
                        </xsl:element>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:element>
				  <xsl:if test="xalan:nodeset($cc-attr)//measurementScale//precision!=''"> <!-- WE MAY modify this mapping cause of conceptual differences -->
						<xsl:element name="attrva">
							<xsl:value-of select="xalan:nodeset($cc-attr)//measurementScale//precision"/>
					    </xsl:element>						
						<xsl:element name="attrvae"><xsl:value-of select="'No explanation available'"/></xsl:element>
				  </xsl:if>
                </xsl:element>
              </xsl:for-each> <!--end for-each attribute-->
              
            </xsl:element>
          </xsl:for-each>
        </xsl:element>  
      </xsl:if>

<!-- start of the 'distinfo' branch -->

        <xsl:element name="distinfo">
          <!-- distribution contact info is required -->
          <xsl:element name="distrib">
            <xsl:element name="cntinfo">
	  		 <xsl:choose>
			   <xsl:when test="/*[local-name() = 'eml']/dataset/publisher!=''">  <!-- if publisher, use it as ditributor -->
				 <xsl:for-each select="/*[local-name() = 'eml']/dataset/publisher">
					<xsl:variable name="cc">
					  <xsl:choose>
						<xsl:when test="./references!=''">
						  <xsl:variable name="ref_id" select="./references"/>
						  <xsl:copy-of select="$ids[@id=$ref_id]"/>
						</xsl:when>
						<xsl:otherwise>
                      <!-- no references tag, thus use the current node -->
						  <xsl:copy-of select="."/>
						</xsl:otherwise>
					  </xsl:choose>
					</xsl:variable>

					  <xsl:choose>
						<xsl:when test="xalan:nodeset($cc)//individualName!=''">
						  <xsl:element name="cntperp">
						  <!-- there is only a single 'cntperp' in nbii thus we only reproduce the first publisher in eml2 -->
							 <xsl:element name="cntper">
							  <xsl:value-of select="xalan:nodeset($cc)//individualName"/>
							</xsl:element>
							<xsl:if test="$show_optional">
							  <xsl:element name="cntorg">
								  <xsl:value-of select="xalan:nodeset($cc)//organizationName"/>						
							  </xsl:element>
							</xsl:if>  
						  </xsl:element>
						</xsl:when>
						<xsl:when test="xalan:nodeset($cc)//organizationName!=''">
						  <xsl:element name="cntorgp">
							<xsl:element name="cntorg">
							  <xsl:value-of select="xalan:nodeset($cc)//organizationName"/>
							</xsl:element>
							<xsl:if test="$show_optional">
							  <xsl:element name="cntper">
						  
							  </xsl:element>
							</xsl:if>  
						  </xsl:element>
						</xsl:when>
						<xsl:when test="xalan:nodeset($cc)//positionName!=''">
						  <xsl:element name="cntorgp">
							<xsl:element name="cntorg">
							  <xsl:value-of select="xalan:nodeset($cc)//positionName"/>
							</xsl:element>
							<xsl:if test="$show_optional">
							  <xsl:element name="cntper">
								  <xsl:value-of select="xalan:nodeset($cc)//individualName"/>                  
							  </xsl:element>
							</xsl:if>  
						  </xsl:element>
						</xsl:when>
					  </xsl:choose>
					  <xsl:if test="xalan:nodeset($cc)//positionName!=''">
						<xsl:element name="cntpos">
						  <xsl:value-of select="xalan:nodeset($cc)//positionName"/>
						</xsl:element>
					  </xsl:if>
					  <xsl:element name="cntaddr">
						 <xsl:element name="addrtype">
						   <xsl:value-of select="'mailing'"/>
						 </xsl:element>
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/deliveryPoint!=''">
							 <xsl:element name="address">
							   <xsl:value-of select="xalan:nodeset($cc)//address/deliveryPoint"/>
							 </xsl:element>
						   </xsl:when>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/city!=''">
							 <xsl:element name="city">
							   <xsl:value-of select="xalan:nodeset($cc)//address/city"/>
							 </xsl:element>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:element name="city">
							   <xsl:value-of select="'N/A'"/>
							 </xsl:element>  
						   </xsl:otherwise>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/administrativaArea!=''">
							 <xsl:element name="state">
							   <xsl:value-of select="xalan:nodeset($cc)//address/administrativaArea"/>
							 </xsl:element>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:element name="state">
							   <xsl:value-of select="'N/A'"/>
							 </xsl:element>  
						   </xsl:otherwise>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/postalCode!=''">
							 <xsl:element name="postal">
							   <xsl:value-of select="xalan:nodeset($cc)//address/postalCode"/>
							 </xsl:element>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:element name="postal">
							   <xsl:value-of select="'N/A'"/>
							 </xsl:element>  
						   </xsl:otherwise>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/country!=''">
							 <xsl:element name="country">
							   <xsl:value-of select="xalan:nodeset($cc)//address/country"/>
							 </xsl:element>
						   </xsl:when>
						 </xsl:choose>
					   </xsl:element> <!-- end contact address element cntaddr -->
					   
					   <xsl:if test="xalan:nodeset($cc)//phone!=''">
							<xsl:for-each select="xalan:nodeset($cc)//phone">
								<xsl:element name="cntvoice">
									<xsl:choose>
										<xsl:when test="@phonetype='voice'">
											<xsl:value-of select="."/>
										</xsl:when>
										<xsl:otherwise>
										   <xsl:value-of select="'N/A'"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
							</xsl:for-each>
					   </xsl:if>               
					   
					  <xsl:if test="$show_optional">
						<xsl:element name="cnttdd">  <!-- TTD, not an option in EML -->
					  
						</xsl:element>
					  </xsl:if>
					  
					  <xsl:if test="$show_optional">
						<xsl:element name="cntfax">
							<xsl:if test="xalan:nodeset($cc)//phone!=''">
								<xsl:for-each select="xalan:nodeset($cc)//phone">
									<xsl:if test="@phonetype='fax'">
										<xsl:value-of select="."/>
									</xsl:if>				
								</xsl:for-each>
							</xsl:if>              
						</xsl:element>
					  </xsl:if>
		
					  <xsl:if test="$show_optional">
						<xsl:element name="cntemail">
						 <xsl:choose>
							 <xsl:when test="xalan:nodeset($cc)//electronicMailAddress!=''">
								 <xsl:value-of select="xalan:nodeset($cc)//phone"/>
							 </xsl:when>
							 <xsl:otherwise>
							   <xsl:value-of select="'N/A'"/>
							 </xsl:otherwise>
						   </xsl:choose>              
						</xsl:element>
					  </xsl:if>
					  
					  <xsl:if test="$show_optional">
						<xsl:element name="hours">
					  
						</xsl:element>
					  </xsl:if>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntinst">
					  
						</xsl:element>
					  </xsl:if>
                  
				 </xsl:for-each>
			   </xsl:when>		<!-- end of case there is an EML publsher element -->
			   
			   <xsl:otherwise> <!-- use the contact person in EML mandatory -->
				 <xsl:for-each select="/*[local-name() = 'eml']/dataset/contact[1]">
				  <xsl:variable name="cc">
					  <xsl:choose>
						<xsl:when test="./references!=''">
						  <xsl:variable name="ref_id" select="./references"/>
						  <xsl:copy-of select="$ids[@id=$ref_id]"/>
						</xsl:when>
						<xsl:otherwise>
                      <!-- no references tag, thus use the current node -->
						  <xsl:copy-of select="."/>
						</xsl:otherwise>
					  </xsl:choose>
					</xsl:variable>
					  <xsl:choose>
						<xsl:when test="xalan:nodeset($cc)//individualName!=''">
						  <xsl:element name="cntperp">
						  <!-- there is only a single 'cntperp' in nbii thus we only reproduce the first publisher in eml2 -->
							 <xsl:element name="cntper">
							  <xsl:value-of select="xalan:nodeset($cc)//individualName"/>
							</xsl:element>
							<xsl:if test="$show_optional">
							  <xsl:element name="cntorg">
								  <xsl:value-of select="xalan:nodeset($cc)//organizationName"/>						
							  </xsl:element>
							</xsl:if>  
						  </xsl:element>
						</xsl:when>
						<xsl:when test="xalan:nodeset($cc)//organizationName!=''">
						  <xsl:element name="cntorgp">
							<xsl:element name="cntorg">
							  <xsl:value-of select="xalan:nodeset($cc)//organizationName"/>
							</xsl:element>
							<xsl:if test="$show_optional">
							  <xsl:element name="cntper">
						  
							  </xsl:element>
							</xsl:if>  
						  </xsl:element>
						</xsl:when>
						<xsl:when test="xalan:nodeset($cc)//positionName!=''">
						  <xsl:element name="cntorgp">
							<xsl:element name="cntorg">
							  <xsl:value-of select="xalan:nodeset($cc)//positionName"/>
							</xsl:element>
							<xsl:if test="$show_optional">
							  <xsl:element name="cntper">
								  <xsl:value-of select="xalan:nodeset($cc)//individualName"/>                  
							  </xsl:element>
							</xsl:if>  
						  </xsl:element>
						</xsl:when>
					  </xsl:choose>
					  <xsl:if test="xalan:nodeset($cc)//positionName!=''">
						<xsl:element name="cntpos">
						  <xsl:value-of select="xalan:nodeset($cc)//positionName"/>
						</xsl:element>
					  </xsl:if>
					  <xsl:element name="cntaddr">
						 <xsl:element name="addrtype">
						   <xsl:value-of select="'mailing'"/>
						 </xsl:element>
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/deliveryPoint!=''">
							 <xsl:element name="address">
							   <xsl:value-of select="xalan:nodeset($cc)//address/deliveryPoint"/>
							 </xsl:element>
						   </xsl:when>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/city!=''">
							 <xsl:element name="city">
							   <xsl:value-of select="xalan:nodeset($cc)//address/city"/>
							 </xsl:element>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:element name="city">
							   <xsl:value-of select="'N/A'"/>
							 </xsl:element>  
						   </xsl:otherwise>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/administrativaArea!=''">
							 <xsl:element name="state">
							   <xsl:value-of select="xalan:nodeset($cc)//address/administrativaArea"/>
							 </xsl:element>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:element name="state">
							   <xsl:value-of select="'N/A'"/>
							 </xsl:element>  
						   </xsl:otherwise>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/postalCode!=''">
							 <xsl:element name="postal">
							   <xsl:value-of select="xalan:nodeset($cc)//address/postalCode"/>
							 </xsl:element>
						   </xsl:when>
						   <xsl:otherwise>
							 <xsl:element name="postal">
							   <xsl:value-of select="'N/A'"/>
							 </xsl:element>  
						   </xsl:otherwise>
						 </xsl:choose>
					   
						 <xsl:choose>
						   <xsl:when test="xalan:nodeset($cc)//address/country!=''">
							 <xsl:element name="country">
							   <xsl:value-of select="xalan:nodeset($cc)//address/country"/>
							 </xsl:element>
						   </xsl:when>
						 </xsl:choose>
					   </xsl:element> <!-- end contact address element cntaddr -->
					   
					   <xsl:if test="xalan:nodeset($cc)//phone!=''">
							<xsl:for-each select="xalan:nodeset($cc)//phone">
								<xsl:element name="cntvoice">
									<xsl:choose>
										<xsl:when test="@phonetype='voice'">
											<xsl:value-of select="."/>
										</xsl:when>
										<xsl:otherwise>
										   <xsl:value-of select="'N/A'"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
							</xsl:for-each>
					   </xsl:if>               
					   
					  <xsl:if test="$show_optional">
						<xsl:element name="cnttdd">  <!-- TTD, not an option in EML -->
					  
						</xsl:element>
					  </xsl:if>
					  
					  <xsl:if test="$show_optional">
						<xsl:element name="cntfax">
							<xsl:if test="xalan:nodeset($cc)//phone!=''">
								<xsl:for-each select="xalan:nodeset($cc)//phone">
									<xsl:if test="@phonetype='fax'">
										<xsl:value-of select="."/>
									</xsl:if>				
								</xsl:for-each>
							</xsl:if>              
						</xsl:element>
					  </xsl:if>
		
					  <xsl:if test="$show_optional">
						<xsl:element name="cntemail">
						 <xsl:choose>
							 <xsl:when test="xalan:nodeset($cc)//electronicMailAddress!=''">
								 <xsl:value-of select="xalan:nodeset($cc)//phone"/>
							 </xsl:when>
							 <xsl:otherwise>
							   <xsl:value-of select="'N/A'"/>
							 </xsl:otherwise>
						   </xsl:choose>              
						</xsl:element>
					  </xsl:if>
					  
					  <xsl:if test="$show_optional">
						<xsl:element name="hours">
					  
						</xsl:element>
					  </xsl:if>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntinst">
					  
						</xsl:element>
					  </xsl:if>
					</xsl:for-each>
			    </xsl:otherwise>   <!-- otherwise use contact as ditributor -->
              
			  </xsl:choose>

             <!-- original location of the for-each loop to assign content to $cc. (Begin of distinfo branch) I think it can be moved up.  </xsl:for-each> -->
            
          </xsl:element> <!-- end cntinfo -->
        </xsl:element><!-- end distrib -->
         
         <xsl:element name="resdesc">
			  <xsl:value-of select="$packageID"/>
         </xsl:element>
         <xsl:element name="distliab">
            <xsl:value-of select="'distribution liability information is not available'"/> <!-- may put here some along the lines that LTER is not responsible for it. -->
         </xsl:element>
          
          <xsl:choose>
				<xsl:when test="/*[local-name() = 'eml']/dataset/*/physical!=''">
		            <xsl:element name="stdorder">
					  <xsl:for-each select="/*[local-name() = 'eml']/dataset/*/physical"> <!-- This looks for an EML <physical> element, but we may compromise and use a <distribution> element that it is likely to be present even when physical is not -->
						<xsl:variable name="cc-phys">
							<xsl:choose>
							  <xsl:when test="./references!=''">
								  <xsl:variable name="ref_id" select="./references"/>
								  <xsl:copy-of select="$ids[@id=$ref_id]"/>
							  </xsl:when>
							  <xsl:otherwise><!-- no references tag, thus use the current node -->
								  <xsl:copy-of select="."/>
							  </xsl:otherwise>
						    </xsl:choose>
						</xsl:variable>
						<xsl:element name="digform">
						  <xsl:element name="digtinfo">
							<xsl:element name="formname">
							  <xsl:choose>
								<xsl:when test="xalan:nodeset($cc-phys)//textFormat!=''">
								  <xsl:value-of select="'ASCII'"/>
								</xsl:when>
								<xsl:otherwise>
								  <xsl:value-of select="'Unknown; NOT ASCII'"/>
								</xsl:otherwise>
							  </xsl:choose>
							</xsl:element>
							<xsl:element name="asciistr">
							  <xsl:element name="recdel">
								<xsl:choose>
								  <xsl:when test="xalan:nodeset($cc-phys)//textFormat/recordDelimiter!=''">
									<xsl:value-of select="xalan:nodeset($cc-phys)//textFormat/recordDelimiter"/>
								  </xsl:when>
								  <xsl:otherwise>
									<xsl:value-of select="'N/A'"/>
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							  <xsl:element name="numheadl">
								<xsl:choose>
								  <xsl:when test="xalan:nodeset($cc-phys)//textFormat/numHeaderLines!=''">
									<xsl:value-of select="xalan:nodeset($cc-phys)//textFormat/numHeaderLines"/>
								  </xsl:when>
								  <xsl:otherwise>
									<xsl:value-of select="'N/A'"/>
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							  <xsl:element name="orienta">
								<xsl:choose>
								  <xsl:when test="xalan:nodeset($cc-phys)//textFormat/attributeOrientation='row'">
									<xsl:value-of select="'rowmajor'"/>                      
								  </xsl:when>
								  <xsl:otherwise>
									<xsl:value-of select="'columnmajor'"/>                      
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							  <xsl:element name="casesens">
								<xsl:choose>
								  <xsl:when test="//caseSensitive!=''">
									<xsl:value-of select="//caseSensitive"/>
								  </xsl:when>
								  <xsl:otherwise>
									<xsl:value-of select="'N/A'"/>
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							  <xsl:element name="authent">
								<xsl:choose>
								  <xsl:when test="xalan:nodeset($cc-phys)//authentication!=''">
									<xsl:value-of select="xalan:nodeset($cc-phys)//authentication"/>
								  </xsl:when>
								  <xsl:otherwise>
									<xsl:value-of select="'N/A'"/>
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							  <xsl:element name="quotech">
								<xsl:choose>
								  <xsl:when test="xalan:nodeset($cc-phys)//dataFormat/textFormat/simpleDelimited/quoteCharacter!=''">
									<xsl:value-of select="xalan:nodeset($cc-phys)//dataFormat/textFormat/simpleDelimited/quoteCharacter"/>
								  </xsl:when>
								  <xsl:otherwise>
									<xsl:value-of select="'N/A'"/>
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							  <xsl:element name="datafiel">
								<xsl:element name="dfieldnm">
								  <xsl:value-of select="'Field Name data is included as part of the Entity/Attribute element (eainfo).'"/>
								</xsl:element>
								<xsl:element name="dfwidthd">
								  <xsl:choose>
									<xsl:when test="xalan:nodeset($cc-phys)//dataFormat/textFormat/simpleDelimited/fieldDelimiter!=''">
									  <xsl:value-of select="concat('Single delimter for all fields: ', xalan:nodeset($cc-phys)//dataFormat/textFormat/simpleDelimited/fieldDelimiter)"/>
									</xsl:when>
									<xsl:otherwise>
									  <xsl:value-of select="'N/A'"/>
									</xsl:otherwise>
								  </xsl:choose>
								</xsl:element>
							  </xsl:element>
							</xsl:element>
							<xsl:element name="formcont">
							 <xsl:value-of select="'See Entity/Attribute element '"/>
							</xsl:element>
							<xsl:element name="filedec">
								<xsl:choose>
									<xsl:when test="xalan:nodeset($cc-phys)//compressionMethod!=''">
									  <xsl:value-of select="xalan:nodeset($cc-phys)//compressionMethod"/>
									</xsl:when>
									<xsl:otherwise>
									  <xsl:value-of select="'No compression applied'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
							<xsl:element name="transize">
								<xsl:choose>
									<xsl:when test="xalan:nodeset($cc-phys)//size!=''">
									  <xsl:choose>
										 <xsl:when test="xalan:nodeset($cc-phys)//size/@unit!=''">
											 <xsl:value-of select="concat(xalan:nodeset($cc-phys)//size, ' ', xalan:nodeset($cc-phys)//size/@unit)"/>
									     </xsl:when>
									     <xsl:otherwise>
											 <xsl:value-of select="concat(xalan:nodeset($cc-phys)//size, ' bytes')"/>
									     </xsl:otherwise>
									  </xsl:choose>
									</xsl:when>
									<xsl:otherwise>
									  <xsl:value-of select="'N/A'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						  </xsl:element> <!-- end digitinfo (digital transfer info box) -->
						  <xsl:element name="digtopt"> <!-- group digital transfer option (including URL) -->
							<xsl:choose>
								<xsl:when test="xalan:nodeset($cc-phys)//distribution/references!=''">
								<!-- references to a previous <distribution> most likely in the root distributionHERE-->
								    <xsl:variable name="cc-distr">
										  <xsl:variable name="dist_ref_id" select="xalan:nodeset($cc-phys)//distribution/references"/>
										  <xsl:copy-of select="$ids[@id=$dist_ref_id]"/>
									</xsl:variable>
									<xsl:choose>  <!-- bizarre enough, this is the same choice within the choice but with different variable -->
										<xsl:when test="xalan:nodeset($cc-distr)//online/url!=''">
											<xsl:element name="onlinopt">
											  <xsl:element name="computer">
												<xsl:element name="networka">
												  <xsl:element name="networkr">
													<xsl:value-of select="xalan:nodeset($cc-distr)//online/url"/>
												  </xsl:element>
												</xsl:element>
											  </xsl:element>
											</xsl:element>	
										</xsl:when>
										<xsl:when test="xalan:nodeset($cc-distr)//inline!=''">
											<xsl:element name="onlinopt">
											  <xsl:element name="computer">
												<xsl:element name="networka">
												  <xsl:element name="networkr">
													 <xsl:value-of select="concat('http://metacat.lternet.edu/knb/metacat?action=read&amp;qformat=lter&amp;docid=',$packageID,'&amp;displaymodule=inlinedata&amp;distributionlevel=entitylevel&amp;entitytype=dataTable&amp;entityindex=1&amp;physicalindex=1&amp;distributionindex=1' )"/>
												  </xsl:element>
												</xsl:element>
											  </xsl:element>
											</xsl:element>
									    </xsl:when>
                                        <xsl:otherwise><!-- offline -->
											<xsl:element name="offoptn">
											  <xsl:element name="offmedia">
												<xsl:choose>
												  <xsl:when test="xalan:nodeset($cc-distr)//offline/mediumName!=''">
													<xsl:value-of select="xalan:nodeset($cc-distr)//offline/mediumName"/>
												  </xsl:when>
												  <xsl:otherwise>
													<xsl:value-of select="'N/A'"/>
												  </xsl:otherwise>
												</xsl:choose>
											  </xsl:element>
											  <xsl:element name="reccap">
												<xsl:choose>
												  <xsl:when test="xalan:nodeset($cc-distr)//offline/mediumVolume!=''">
													<xsl:value-of select="xalan:nodeset($cc-distr)//offline/mediumVolume"/>
												  </xsl:when>
												  <xsl:otherwise>
													<xsl:value-of select="'N/A'"/>
												  </xsl:otherwise>
												</xsl:choose>
											  </xsl:element>
											  <xsl:element name="recfmt">
												<xsl:element name="recden">
												  <xsl:choose>
													<xsl:when test="xalan:nodeset($cc-distr)//offline/mediumDensity!=''">
													  <xsl:value-of select="xalan:nodeset($cc-distr)//offline/mediumDensity"/>
													</xsl:when>
													<xsl:otherwise>
													  <xsl:value-of select="'N/A'"/>
													</xsl:otherwise>
												  </xsl:choose>
												</xsl:element>
												<xsl:element name="recdenu">
												  <xsl:choose>
													<xsl:when test="xalan:nodeset($cc-distr)//offline/mediumDensityUnits!=''">
													  <xsl:value-of select="xalan:nodeset($cc-distr)//offline/mediumDensityUnits"/>
													</xsl:when>
													<xsl:otherwise>
													  <xsl:value-of select="'N/A'"/>
													</xsl:otherwise>
												  </xsl:choose>
												</xsl:element>
											  </xsl:element>
											  <xsl:element name="recfmt">
												<xsl:choose>
												  <xsl:when test="xalan:nodeset($cc-distr)//offline/mediumFormat!=''">
													<xsl:value-of select="xalan:nodeset($cc-distr)//offline/mediumFormat"/>
												  </xsl:when>
												  <xsl:otherwise>
													<xsl:value-of select="'N/A'"/>
												  </xsl:otherwise>
												</xsl:choose>
											  </xsl:element>
											  <xsl:if test="xalan:nodeset($cc-distr)//offline/mediumNote!=''">
												<xsl:element name="compat">
												  <xsl:value-of select="xalan:nodeset($cc-distr)//offline/mediumNote"/>
												</xsl:element>
											  </xsl:if>
											</xsl:element>
										</xsl:otherwise>
    								</xsl:choose> <!-- end of references within the references for the distribution-->
								  </xsl:when>
								  <xsl:when test="xalan:nodeset($cc-phys)//distribution/online/url!=''">
									<xsl:element name="onlinopt">
									  <xsl:element name="computer">
										<xsl:element name="networka">
										  <xsl:element name="networkr">
											<xsl:value-of select="xalan:nodeset($cc-phys)//distribution/online/url"/>
										  </xsl:element>
										</xsl:element>
									  </xsl:element>
									</xsl:element>
								  </xsl:when>
								  <xsl:when test="xalan:nodeset($cc-phys)//distribution/inline!=''">
									<xsl:element name="onlinopt">
									  <xsl:element name="computer">
										<xsl:element name="networka">
										  <xsl:element name="networkr">
											<xsl:value-of select="'data is inline (inside) eml2 document -- included with the original metadata document-- '"/>
										  </xsl:element>
										</xsl:element>
									  </xsl:element>
									</xsl:element>
								  </xsl:when>
								  <xsl:otherwise><!-- offline -->
									<xsl:element name="offoptn">
									  <xsl:element name="offmedia">
										<xsl:choose>
										  <xsl:when test="xalan:nodeset($cc-phys)//distribution/offline/mediumName!=''">
											<xsl:value-of select="xalan:nodeset($cc-phys)//distribution/offline/mediumName"/>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="'N/A'"/>
										  </xsl:otherwise>
										</xsl:choose>
									  </xsl:element>
									  <xsl:element name="reccap">
										<xsl:choose>
										  <xsl:when test="xalan:nodeset($cc-phys)//distribution/offline/mediumVolume!=''">
											<xsl:value-of select="xalan:nodeset($cc-phys)//distribution/offline/mediumVolume"/>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="'N/A'"/>
										  </xsl:otherwise>
										</xsl:choose>
									  </xsl:element>
									  <xsl:element name="recfmt">
										<xsl:element name="recden">
										  <xsl:choose>
											<xsl:when test="xalan:nodeset($cc-phys)//distribution/offline/mediumDensity!=''">
											  <xsl:value-of select="xalan:nodeset($cc-phys)//distribution/offline/mediumDensity"/>
											</xsl:when>
											<xsl:otherwise>
											  <xsl:value-of select="'N/A'"/>
											</xsl:otherwise>
										  </xsl:choose>
										</xsl:element>
										<xsl:element name="recdenu">
										  <xsl:choose>
											<xsl:when test="xalan:nodeset($cc-phys)//distribution/offline/mediumDensityUnits!=''">
											  <xsl:value-of select="xalan:nodeset($cc-phys)//distribution/offline/mediumDensityUnits"/>
											</xsl:when>
											<xsl:otherwise>
											  <xsl:value-of select="'N/A'"/>
											</xsl:otherwise>
										  </xsl:choose>
										</xsl:element>
									  </xsl:element>
									  <xsl:element name="recfmt">
										<xsl:choose>
										  <xsl:when test="xalan:nodeset($cc-phys)//distribution/offline/mediumFormat!=''">
											<xsl:value-of select="xalan:nodeset($cc-phys)//distribution/offline/mediumFormat"/>
										  </xsl:when>
										  <xsl:otherwise>
											<xsl:value-of select="'N/A'"/>
										  </xsl:otherwise>
										</xsl:choose>
									  </xsl:element>
									  <xsl:if test="xalan:nodeset($cc-phys)//distribution/offline/mediumNote!=''">
										<xsl:element name="compat">
										  <xsl:value-of select="xalan:nodeset($cc-phys)//distribution/offline/mediumNote"/>
										</xsl:element>
									  </xsl:if>
									</xsl:element>
								  </xsl:otherwise>
								</xsl:choose>
							  </xsl:element>
							 </xsl:element>
						   </xsl:for-each>
						   <xsl:element name="fees">
							 <xsl:value-of select="'N/A'"/>
						   </xsl:element>
					</xsl:element>  <!-- end stdorder element, for the case we have a physical element -->
				</xsl:when>
				<xsl:when test="/*[local-name() = 'eml']/dataset/distribution!=''">
				  <xsl:element name="stdorder">
					  <xsl:for-each select="/*[local-name() = 'eml']/dataset/distribution"> <!-- This looks for an EML <distribution> element that it is likely to be present even when physical is not -->
						<xsl:variable name="cc-phys">
							<xsl:choose>
							  <xsl:when test="./references!=''">
								  <xsl:variable name="ref_id" select="./references"/>
								  <xsl:copy-of select="$ids[@id=$ref_id]"/>
							  </xsl:when>
							  <xsl:otherwise><!-- no references tag, thus use the current node -->
								  <xsl:copy-of select="."/>
							  </xsl:otherwise>
						    </xsl:choose>
						</xsl:variable>
						<xsl:element name="digform">
						  <xsl:element name="digtinfo">
							<xsl:element name="formname">
								<xsl:choose><!-- the file is online, if a dataTable, assume ASCII, if vector or raster, put that..-->
									<xsl:when test="/*[local-name() = 'eml']/dataset/dataTable!=''">
									  <xsl:value-of select="'ASCII'"/>  <!-- if a dataTable, assume ASCII-->
									</xsl:when>
									<xsl:when test="/*[local-name() = 'eml']/dataset/spatialRaster!=''">
									  <xsl:value-of select="'Spatial Raster'"/>  <!-- a raster type-->
									</xsl:when>
									<xsl:when test="/*[local-name() = 'eml']/dataset/spatialVector!=''">
									  <xsl:value-of select="'Spatial Vector'"/>  <!-- a vector-->
									</xsl:when>
									<xsl:when test="/*[local-name() = 'eml']/dataset/view!=''">
									  <xsl:value-of select="'Image'"/>  <!-- Image looks like-->
									</xsl:when>								
									<xsl:otherwise>
										<xsl:value-of select="'Unknown'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						  </xsl:element> <!-- end digitinfo : only the minimu placed -->
						  <xsl:element name="digtopt"> <!-- group digital transfer option (including URL) -->
							<xsl:choose>
							  <xsl:when test="xalan:nodeset($cc-phys)//online/url!=''">
								<xsl:element name="onlinopt">
								  <xsl:element name="computer">
									<xsl:element name="networka">
									  <xsl:element name="networkr">
										<xsl:value-of select="xalan:nodeset($cc-phys)//online/url"/>
									  </xsl:element>
									</xsl:element>
								  </xsl:element>
								</xsl:element>
							  </xsl:when>
							  <xsl:when test="xalan:nodeset($cc-phys)//inline!=''">
								<xsl:element name="onlinopt">
								  <xsl:element name="computer">
									<xsl:element name="networka">
									  <xsl:element name="networkr">
										<xsl:value-of select="'data is inline (inside) eml2 document -- included with the original metadata document-- '"/>
									  </xsl:element>
									</xsl:element>
								  </xsl:element>
								</xsl:element>
							  </xsl:when>
							  <xsl:otherwise><!-- offline -->
								<xsl:element name="offoptn">
								  <xsl:element name="offmedia">
									<xsl:choose>
									  <xsl:when test="xalan:nodeset($cc-phys)//offline/mediumName!=''">
										<xsl:value-of select="xalan:nodeset($cc-phys)//offline/mediumName"/>
									  </xsl:when>
									  <xsl:otherwise>
										<xsl:value-of select="'N/A'"/>
									  </xsl:otherwise>
									</xsl:choose>
								  </xsl:element>
								  <xsl:element name="reccap">
									<xsl:choose>
									  <xsl:when test="xalan:nodeset($cc-phys)//offline/mediumVolume!=''">
										<xsl:value-of select="xalan:nodeset($cc-phys)//offline/mediumVolume"/>
									  </xsl:when>
									  <xsl:otherwise>
										<xsl:value-of select="'N/A'"/>
									  </xsl:otherwise>
									</xsl:choose>
								  </xsl:element>
								  <xsl:element name="recfmt">
									<xsl:element name="recden">
									  <xsl:choose>
										<xsl:when test="xalan:nodeset($cc-phys)//offline/mediumDensity!=''">
										  <xsl:value-of select="xalan:nodeset($cc-phys)//offline/mediumDensity"/>
										</xsl:when>
										<xsl:otherwise>
										  <xsl:value-of select="'N/A'"/>
										</xsl:otherwise>
									  </xsl:choose>
									</xsl:element>
								    <xsl:element name="recdenu">
									  <xsl:choose>
										<xsl:when test="xalan:nodeset($cc-phys)//offline/mediumDensityUnits!=''">
										  <xsl:value-of select="xalan:nodeset($cc-phys)//offline/mediumDensityUnits"/>
										</xsl:when>
										<xsl:otherwise>
										  <xsl:value-of select="'N/A'"/>
										</xsl:otherwise>
									  </xsl:choose>
									</xsl:element>
								  </xsl:element>
								  <xsl:element name="recfmt">
									<xsl:choose>
									  <xsl:when test="xalan:nodeset($cc-phys)//offline/mediumFormat!=''">
										<xsl:value-of select="xalan:nodeset($cc-phys)//offline/mediumFormat"/>
									  </xsl:when>
									  <xsl:otherwise>
										<xsl:value-of select="'N/A'"/>
									  </xsl:otherwise>
									</xsl:choose>
								  </xsl:element>
								  <xsl:if test="xalan:nodeset($cc-phys)//offline/mediumNote!=''">
									<xsl:element name="compat">
									  <xsl:value-of select="xalan:nodeset($cc-phys)//offline/mediumNote"/>
									</xsl:element>
								  </xsl:if>
								</xsl:element>
							  </xsl:otherwise>
							</xsl:choose>
						  </xsl:element>
						 </xsl:element>
					   </xsl:for-each>
					   <xsl:element name="fees">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>
	   			  </xsl:element>  <!-- end stdorder element, for the case we only have a distribution element -->
				</xsl:when>
				<xsl:otherwise> <!-- the whole group stdorder is mandatory if applicable (optional :) anyway we dont put a thing-->
				
				</xsl:otherwise>
		  </xsl:choose>
 
      </xsl:element><!-- end distinfo -->
      
<!-- start the 'metainfo' branch -->      
      <xsl:element name="metainfo">
        <xsl:element name="metd">
			<xsl:choose>
				<xsl:when test="/*[local-name() = 'eml']/dataset/pubDate!=''">
					<xsl:value-of select="/*[local-name() = 'eml']/dataset/pubDate"/> <!-- metadata and data published at the same time -->				
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select="'N/A'"/>
				</xsl:otherwise>
			</xsl:choose>
        </xsl:element>
        <xsl:element name="metrd">
          <xsl:value-of select="'N/A'"/>      <!-- metadata revision date.. there is no element in EML for metadata maintenance-->
        </xsl:element>
        <xsl:if test="$show_optional">
          <xsl:element name="metfrd">
          <xsl:value-of select="'N/A'"/>
          </xsl:element>
        </xsl:if>  
        <xsl:element name="metc">
          <xsl:element name="cntinfo">		
          <xsl:choose>
			<xsl:when test="/*[local-name() = 'eml']/dataset/metadataProvider!=''">
			  <xsl:for-each select="/*[local-name() = 'eml']/dataset/metadataProvider[1]">  <!-- Here the metadata Provider should be mapped. I. -->
				  <xsl:variable name="cc">
					<xsl:choose>
					  <xsl:when test="./references!=''">
						<xsl:variable name="ref_id" select="./references"/>
						<xsl:copy-of select="$ids[@id=$ref_id]"/>
					  </xsl:when>
					  <xsl:otherwise>
						<!-- no references tag, thus use the current node -->
						<xsl:copy-of select="."/>
					  </xsl:otherwise>
					</xsl:choose>
				  </xsl:variable>
				 <xsl:choose>
				  <xsl:when test="xalan:nodeset($cc)//individualName!=''">
					<xsl:element name="cntperp">
					<!-- there is only a single 'cntperp' in nbii;
					 thus we only reproduce the first contact in eml2 -->
					  <xsl:element name="cntper">
						<xsl:value-of select="xalan:nodeset($cc)//individualName"/>
					  </xsl:element>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntorg">
							<xsl:value-of select="xalan:nodeset($cc)//organizationName"/>       <!-- ISG wouldnt hurt to put the ORGname if exists -->                 
						</xsl:element>
					  </xsl:if>  
					</xsl:element>
				  </xsl:when>
				  <xsl:when test="xalan:nodeset($cc)//organizationName!=''">
					<xsl:element name="cntorgp">
					  <xsl:element name="cntorg">
						<xsl:value-of select="xalan:nodeset($cc)//organizationName"/>
					  </xsl:element>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntper">
						  <xsl:value-of select="xalan:nodeset($cc)//individualName"/> <!-- ISG wouldnt hurt to put the name if exists -->                  
						</xsl:element>
					  </xsl:if>  
					</xsl:element>
				  </xsl:when>
				  <xsl:when test="xalan:nodeset($cc)//positionName!=''">
					<xsl:element name="cntorgp">
					  <xsl:element name="cntorg">
						<xsl:value-of select="xalan:nodeset($cc)//positionName"/>
					  </xsl:element>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntper">
						  <xsl:value-of select="xalan:nodeset($cc)//individualName"/> <!-- ISG wouldnt hurt to put the name if exists -->
						</xsl:element>
					  </xsl:if>  
					</xsl:element>
				  </xsl:when>
				</xsl:choose>
				<xsl:if test="xalan:nodeset($cc)//positionName!=''">
				  <xsl:element name="cntpos">
					<xsl:value-of select="xalan:nodeset($cc)//positionName"/>
				  </xsl:element>
				</xsl:if>
				<xsl:element name="cntaddr">
				   <xsl:element name="addrtype">
					 <xsl:value-of select="'mailing'"/>
				   </xsl:element>
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/deliveryPoint!=''">
					   <xsl:element name="address">
						 <xsl:value-of select="xalan:nodeset($cc)//address/deliveryPoint"/>
					   </xsl:element>
					 </xsl:when>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/city!=''">
					   <xsl:element name="city">
						 <xsl:value-of select="xalan:nodeset($cc)//address/city"/>
					   </xsl:element>
					 </xsl:when>
					 <xsl:otherwise>
					   <xsl:element name="city">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>  
					 </xsl:otherwise>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/administrativaArea!=''">
					   <xsl:element name="state">
						 <xsl:value-of select="xalan:nodeset($cc)//address/administrativaArea"/>
					   </xsl:element>
					 </xsl:when>
					 <xsl:otherwise>
					   <xsl:element name="state">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>  
					 </xsl:otherwise>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/postalCode!=''">
					   <xsl:element name="postal">
						 <xsl:value-of select="xalan:nodeset($cc)//address/postalCode"/>
					   </xsl:element>
					 </xsl:when>
					 <xsl:otherwise>
					   <xsl:element name="postal">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>  
					 </xsl:otherwise>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/country!=''">
					   <xsl:element name="country">
						 <xsl:value-of select="xalan:nodeset($cc)//address/country"/>
					   </xsl:element>
					 </xsl:when>
				   </xsl:choose>      
				</xsl:element>

				 <xsl:choose>
				   <xsl:when test="xalan:nodeset($cc)//phone!=''">
					 <xsl:element name="cntvoice">
					   <xsl:value-of select="xalan:nodeset($cc)//phone[@phonetype='voice']"/>
					 </xsl:element>
				   </xsl:when>
				   <xsl:otherwise>
					 <xsl:element name="cntvoice">
					   <xsl:value-of select="'N/A'"/>
					 </xsl:element>
				   </xsl:otherwise>
				 </xsl:choose>
               
				<xsl:if test="$show_optional">
				  <xsl:element name="cnttdd">  <!-- no TTD in EML -->
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="cntfax">
					<xsl:if test="xalan:nodeset($cc)//phone[@phonetype='fax']">
						<xsl:value-of select="xalan:nodeset($cc)//phone[@phonetype='fax']"/>
					</xsl:if>
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="cntemail">
					<xsl:if test="xalan:nodeset($cc)//electronicMailAddress!=''">
						<xsl:value-of select="xalan:nodeset($cc)//electronicMailAddress"/>
					</xsl:if>
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="hours">
              
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="cntinst">
              
				  </xsl:element>
				</xsl:if>				  
			  </xsl:for-each>		
			</xsl:when>
			<xsl:otherwise> <!-- default to the contact -->
			  <xsl:for-each select="/*[local-name() = 'eml']/dataset/contact[1]">  <!--  default to the "contact". -->
				  <xsl:variable name="cc">
					<xsl:choose>
					  <xsl:when test="./references!=''">
						<xsl:variable name="ref_id" select="./references"/>
						<xsl:copy-of select="$ids[@id=$ref_id]"/>
					  </xsl:when>
					  <xsl:otherwise>
						<!-- no references tag, thus use the current node -->
						<xsl:copy-of select="."/>
					  </xsl:otherwise>
					</xsl:choose>
				  </xsl:variable>
<xsl:choose>
				  <xsl:when test="xalan:nodeset($cc)//individualName!=''">
					<xsl:element name="cntperp">
					<!-- there is only a single 'cntperp' in nbii;
					 thus we only reproduce the first contact in eml2 -->
					  <xsl:element name="cntper">
						<xsl:value-of select="xalan:nodeset($cc)//individualName"/>
					  </xsl:element>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntorg">
							<xsl:value-of select="xalan:nodeset($cc)//organizationName"/>       <!-- ISG wouldnt hurt to put the ORGname if exists -->                 
						</xsl:element>
					  </xsl:if>  
					</xsl:element>
				  </xsl:when>
				  <xsl:when test="xalan:nodeset($cc)//organizationName!=''">
					<xsl:element name="cntorgp">
					  <xsl:element name="cntorg">
						<xsl:value-of select="xalan:nodeset($cc)//organizationName"/>
					  </xsl:element>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntper">
						  <xsl:value-of select="xalan:nodeset($cc)//individualName"/> <!-- ISG wouldnt hurt to put the name if exists -->                  
						</xsl:element>
					  </xsl:if>  
					</xsl:element>
				  </xsl:when>
				  <xsl:when test="xalan:nodeset($cc)//positionName!=''">
					<xsl:element name="cntorgp">
					  <xsl:element name="cntorg">
						<xsl:value-of select="xalan:nodeset($cc)//positionName"/>
					  </xsl:element>
					  <xsl:if test="$show_optional">
						<xsl:element name="cntper">
						  <xsl:value-of select="xalan:nodeset($cc)//individualName"/> <!-- ISG wouldnt hurt to put the name if exists -->
						</xsl:element>
					  </xsl:if>  
					</xsl:element>
				  </xsl:when>
				</xsl:choose>
				<xsl:if test="xalan:nodeset($cc)//positionName!=''">
				  <xsl:element name="cntpos">
					<xsl:value-of select="xalan:nodeset($cc)//positionName"/>
				  </xsl:element>
				</xsl:if>
				<xsl:element name="cntaddr">
				   <xsl:element name="addrtype">
					 <xsl:value-of select="'mailing'"/>
				   </xsl:element>
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/deliveryPoint!=''">
					   <xsl:element name="address">
						 <xsl:value-of select="xalan:nodeset($cc)//address/deliveryPoint"/>
					   </xsl:element>
					 </xsl:when>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/city!=''">
					   <xsl:element name="city">
						 <xsl:value-of select="xalan:nodeset($cc)//address/city"/>
					   </xsl:element>
					 </xsl:when>
					 <xsl:otherwise>
					   <xsl:element name="city">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>  
					 </xsl:otherwise>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/administrativaArea!=''">
					   <xsl:element name="state">
						 <xsl:value-of select="xalan:nodeset($cc)//address/administrativaArea"/>
					   </xsl:element>
					 </xsl:when>
					 <xsl:otherwise>
					   <xsl:element name="state">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>  
					 </xsl:otherwise>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/postalCode!=''">
					   <xsl:element name="postal">
						 <xsl:value-of select="xalan:nodeset($cc)//address/postalCode"/>
					   </xsl:element>
					 </xsl:when>
					 <xsl:otherwise>
					   <xsl:element name="postal">
						 <xsl:value-of select="'N/A'"/>
					   </xsl:element>  
					 </xsl:otherwise>
				   </xsl:choose>
               
				   <xsl:choose>
					 <xsl:when test="xalan:nodeset($cc)//address/country!=''">
					   <xsl:element name="country">
						 <xsl:value-of select="xalan:nodeset($cc)//address/country"/>
					   </xsl:element>
					 </xsl:when>
				   </xsl:choose>      
				</xsl:element>

				 <xsl:choose>
				   <xsl:when test="xalan:nodeset($cc)//phone!=''">
					 <xsl:element name="cntvoice">
					   <xsl:value-of select="xalan:nodeset($cc)//phone[@phonetype='fax']"/>
					 </xsl:element>
				   </xsl:when>
				   <xsl:otherwise>
					 <xsl:element name="cntvoice">
					   <xsl:value-of select="'N/A'"/>
					 </xsl:element>
				   </xsl:otherwise>
				 </xsl:choose>
               
				<xsl:if test="$show_optional">
				  <xsl:element name="cnttdd">  <!-- no TTD in EML -->
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="cntfax">
					<xsl:if test="xalan:nodeset($cc)//phone[@phonetype='fax']">
						<xsl:value-of select="xalan:nodeset($cc)//phone[@phonetype='fax']"/>
					</xsl:if>
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="cntemail">
					<xsl:if test="xalan:nodeset($cc)//electronicMailAddress!=''">
						<xsl:value-of select="xalan:nodeset($cc)//electronicMailAddress"/>
					</xsl:if>
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="hours">
              
				  </xsl:element>
				</xsl:if>
				<xsl:if test="$show_optional">
				  <xsl:element name="cntinst">
              
				  </xsl:element>
				</xsl:if>
			  </xsl:for-each>		
			</xsl:otherwise>
		  </xsl:choose>
          
				
          
          </xsl:element>
        </xsl:element>
        <xsl:element name="metstdn">
          <xsl:value-of select="'FGDC/NBII Content Standard for Digital Geospatial Metadata (from Ecological Metadata Langualge 2.x)'"/>
        </xsl:element>
        <xsl:element name="metstdv">
          <xsl:value-of select="'1999 Version (from Ecological Metadata Langualge 2.x)'"/>
        </xsl:element>
        <xsl:if test="$show_optional">
          <xsl:element name="mettc">
      
          </xsl:element>
        </xsl:if>  
        <xsl:if test="$show_optional">
          <xsl:element name="mettac">
      
          </xsl:element>
        </xsl:if>  
        <xsl:if test="$show_optional">
          <xsl:element name="mettuc">
      
          </xsl:element>
        </xsl:if>  
        <xsl:if test="$show_optional">
          <xsl:element name="metsi">
      
          </xsl:element>
        </xsl:if>  
        <xsl:if test="$show_optional">
          <xsl:element name="metextns">
            <xsl:element name="onlink">
            
            </xsl:element>
            <xsl:element name="metprof">
            
            </xsl:element>
          </xsl:element>
        </xsl:if>  
      </xsl:element>      
    </xsl:element>
  
  </xsl:template>

<!-- this named template is needed to handle the recursive taxonimicClassification element-->  
  <xsl:template name="taxonClTemplate">
  <xsl:param name="cur_tc"/>
    <xsl:element name="taxoncl">
      <xsl:element name="taxonrn">
        <xsl:choose>
          <xsl:when test="$cur_tc//taxonRankName!=''">
             <xsl:value-of select="$cur_tc//taxonRankName"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'N/A'"/>
           </xsl:otherwise>
        </xsl:choose>  
      </xsl:element>
      <xsl:element name="taxonrv">
        <xsl:choose>
          <xsl:when test="$cur_tc//taxonRankValue!=''">
            <xsl:value-of select="$cur_tc//taxonRankValue"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'N/A'"/>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:element>
      <xsl:element name="common">
        <xsl:choose>
          <xsl:when test="$cur_tc//commonName!=''">
            <xsl:value-of select="$cur_tc//commonName"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'N/A'"/>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:element>
      <xsl:choose>
        <xsl:when test="$cur_tc//taxonomicClassification!=''">
          <xsl:call-template name="taxonClTemplate">
            <xsl:with-param name="cur_tc" select="$cur_tc//taxonomicClassification"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>  
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>

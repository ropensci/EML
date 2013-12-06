<?xml version="1.0" encoding='iso-8859-1' ?>
<xsl:stylesheet xmlns:xalan="http://xml.apache.org/xalan" 
   				 xmlns:java="http://xml.apache.org/xalan/java"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				version='1.0' 
				xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
				xmlns="urn:lsid:@METADATA_LABELS@:predicates:"
				xmlns:pred="urn:lsid:i3c.org:predicates:"
				xmlns:dc="http://purl.org/dc/elements/1.1/"
				xmlns:eml="eml://ecoinformatics.org/eml-2.0.1"
				exclude-result-prefixes="java seek">
				
				<xsl:template match="/eml:eml">

						<xsl:variable name="metacatServer">@METACAT_SERVER@</xsl:variable>
						<rdf:RDF>
							<xsl:apply-templates select="dataset" />				
		 					
							<rdf:Description>
								<xsl:attribute name="rdf:about">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							  </xsl:attribute> 
							  <xsl:element name="dc:format">
		 					  	<xsl:attribute name="rdf:resource">
		 					  	  <xsl:text>urn:lsid:i3c.org:formats:text</xsl:text>
		 					  	</xsl:attribute>
		 					  </xsl:element>	
						</rdf:Description>
						
						<rdf:Description>
								<xsl:attribute name="rdf:about">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							  </xsl:attribute> 
							  <xsl:element name="pred:storedas">
		 					  	<xsl:attribute name="rdf:resource">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
		 					  	</xsl:attribute>
		 					  </xsl:element>
						</rdf:Description>
						
						<rdf:Description>
								<xsl:attribute name="rdf:about">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							  </xsl:attribute> 
							  <xsl:element name="rdf:type">
		 					  	<xsl:attribute name="rdf:resource">
		 					  	  <xsl:text>urn:lsid:i3c.org:types:content</xsl:text>
		 					  	</xsl:attribute>
		 					  </xsl:element>	
						</rdf:Description>

						<rdf:Description>
								<xsl:attribute name="rdf:about">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							  </xsl:attribute> 
		 					<pred:htmlVersion xmlns:pred="urn:lsid:@METADATA_LABELS@:predicates:">
								<xsl:text>&lt;a href=&quot;</xsl:text>
								<xsl:value-of select="concat(concat($metacatServer,'?action=read&amp;qformat=knb&amp;docid='),@packageId)"/>
								<xsl:text>&quot;&gt;</xsl:text>
								<xsl:value-of select="concat(concat($metacatServer,'?action=read&amp;qformat=knb&amp;docid='),@packageId)"/>
								<xsl:text>&lt;/a&gt;</xsl:text>

		 					</pred:htmlVersion> 

						</rdf:Description>

						<rdf:Description>
								<xsl:attribute name="rdf:about">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							  </xsl:attribute> 
		 					<pred:xmlVersion xmlns:pred="urn:lsid:@METADATA_LABELS@:predicates:">
								<xsl:text>&lt;a href=&quot;</xsl:text>
								<xsl:value-of select="concat(concat($metacatServer,'?action=read&amp;qformat=xml&amp;docid='),@packageId)"/>
								<xsl:text>&quot;&gt;</xsl:text>
								<xsl:value-of select="concat(concat($metacatServer,'?action=read&amp;qformat=xml&amp;docid='),@packageId)"/>
								<xsl:text>&lt;/a&gt;</xsl:text>
		 					</pred:xmlVersion> 

						</rdf:Description>
						<rdf:Description>
								<xsl:attribute name="rdf:about">
								  <xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							  </xsl:attribute> 
							  <xsl:element name="rdf:type">
		 					  	<xsl:attribute name="rdf:resource">
		 					  	  <xsl:text>urn:lsid:i3c.org:types:content</xsl:text>
		 					  	</xsl:attribute>
		 					  </xsl:element>	
						</rdf:Description>
						
					 </rdf:RDF>
				</xsl:template>
				
				<xsl:template match="dataset">
						<rdf:Description>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							</xsl:attribute>
		 					<pred:title xmlns:pred="http://purl.org/dc/elements/1.1/">
		 						<xsl:value-of select="title" />
		 					</pred:title> 
						</rdf:Description>

						<rdf:Description>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							</xsl:attribute>
		 					<pred:creator xmlns:pred="urn:lsid:@METADATA_LABELS@:predicates:">
		 						<xsl:value-of select="creator" />
		 					</pred:creator> 
						</rdf:Description>

						<rdf:Description>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							</xsl:attribute>
		 					<pred:contact xmlns:pred="urn:lsid:@METADATA_LABELS@:predicates:">
		 						<xsl:value-of select="contact" />
		 					</pred:contact> 
						</rdf:Description>

						<xsl:apply-templates select="keywordSet/keyword" />
						<xsl:apply-templates select="distribution/online/url" />
						
					</xsl:template>

					<xsl:template match="keyword">
						<rdf:Description>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							</xsl:attribute>
		 					<pred:keyword xmlns:pred="urn:lsid:@METADATA_LABELS@:predicates:">
								<xsl:value-of select="@keywordType"/>
								<xsl:text>=</xsl:text>
		 						<xsl:value-of select="." />
		 					</pred:keyword> 
						</rdf:Description>
					</xsl:template>

					<xsl:template match="url">
						<rdf:Description>
							<xsl:attribute name="rdf:about">
								<xsl:value-of select="java:edu.ucsb.nceas.metacat.lsid.LSIDAuthorityMetaData.getLSID()" />
							</xsl:attribute>
		 					<pred:associatedInfo xmlns:pred="urn:lsid:@METADATA_LABELS@:predicates:">
		 					
		 						<xsl:choose>
		 							<xsl:when test="starts-with(., 'ecogrid://')">
		 								<xsl:value-of select="concat('urn:lsid:@LSID_AUTHORITY_STRING@:',substring-after(.,'ecogrid://knr/'))"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>&lt;a href=&quot;</xsl:text>
										<xsl:value-of select="."/>
										<xsl:text>&quot;&gt;</xsl:text>
										<xsl:value-of select="."/>
										<xsl:text>&lt;/a&gt;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
		 					</pred:associatedInfo> 
						</rdf:Description>
				</xsl:template>
</xsl:stylesheet>


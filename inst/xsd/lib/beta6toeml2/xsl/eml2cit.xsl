<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:output encoding="ISO-8859-1"/>
<xsl:strip-space elements="*"/>

<!--<xsl:variable name="citb6" select="document('higgins.4557.1')"/> -->

  <xsl:template name="citTransform">
    <xsl:param name="citb6"/>
    <citation>
   
        <xsl:if test="$citb6/citation/shortName!=''">
          <xsl:element name="shortName">
            <xsl:value-of select="$citb6/citation/shortName"/>
          </xsl:element>
        </xsl:if>  
        <xsl:if test="$citb6/citation/title!=''">
          <xsl:element name="title">
            <xsl:value-of select="$citb6/citation/title"/>
          </xsl:element>
        </xsl:if> 
        
        <!-- eml2 has a 'creator' tag with 'ResponsibleParty' content while           -->
        <!-- beta6 has an 'originator' tag with a 'role' element                      -->
        <!-- eml2 also has separate elements for metadataProvider and associatedParty -->
        <!-- use the 'role' value from emlb6 to detemine where info goes in eml2      -->
        <xsl:for-each select="$citb6/citation/originator/role">
          <xsl:if test="((.='Originator')or(.='originator'))">
            <xsl:element name="creator">
              <xsl:call-template name="responsibleParty"/>
            </xsl:element>  
          </xsl:if>
        </xsl:for-each>
          
        <xsl:for-each select="$citb6/citation/originator/role">
          <xsl:if test="(.='Metadata Provider')">
            <xsl:element name="metadataProvider">
              <xsl:call-template name="responsibleParty"/>
            </xsl:element>
          </xsl:if>
        </xsl:for-each>

          <xsl:for-each select="$citb6/citation/originator/role">
          <xsl:if test="((.!='Metadata Provider')and(.!='Originator'))">
            <xsl:element name="creator">
              <xsl:call-template name="responsibleParty"/>
            </xsl:element>
          </xsl:if>
          </xsl:for-each>
          <xsl:if test="$citb6/citation/pubDate!=''">
            <xsl:element name="pubDate">
              <xsl:value-of select="$citb6/citation/pubDate"/>
            </xsl:element>
          </xsl:if>
    <!-- Note - b6 has a 'pubPlace' element that occurs later in eml2 -->      


          <xsl:if test="$citb6/citation/series!=''">
            <xsl:element name="series">
              <xsl:value-of select="$citb6/citation/series"/>
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/abstract!=''">
            <xsl:element name="abstract">
              <xsl:for-each select="$citb6/citation/abstract/paragraph">
                <xsl:element name="para">
                  <xsl:value-of select="."/>
                </xsl:element>
              </xsl:for-each>  
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/keywordSet!=''">
            <xsl:element name="keywordSet">
              <xsl:for-each select="$citb6/citation/keywordSet/keyword">
               <xsl:choose>
               <xsl:when test="./@keywordType!=''">
                <keyword keywordType="{./@keywordType}">
                  <xsl:value-of select="."/>
                </keyword> 
               </xsl:when>
               <xsl:otherwise>
                <keyword keywordType="theme">
                  <xsl:value-of select="."/>
                </keyword> 
               </xsl:otherwise>
               </xsl:choose>
              </xsl:for-each>
              <xsl:if test="$citb6/citation/keywordSet/keywordThesaurus!=''">
                <xsl:element name="keywordThesaurus">
                  <xsl:value-of select="$citb6/citation/keywordSet/keywordThesaurus"/>
                </xsl:element>
              </xsl:if>
            </xsl:element>
          </xsl:if>


          
          <xsl:if test="$citb6/citation/additionalInfo!=''">
            <xsl:element name="additionalInfo">
              <xsl:for-each select="$citb6/citation/additionalInfo/paragraph">
                <xsl:element name="para">
                  <xsl:value-of select="."/>
                </xsl:element>
              </xsl:for-each>  
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/rights!=''">
            <xsl:element name="intellectualRights">
              <xsl:for-each select="$citb6/citation/rights/paragraph">
                <xsl:element name="para">
                  <xsl:value-of select="."/>
                </xsl:element>
              </xsl:for-each>  
            </xsl:element>
          </xsl:if>
          
          <xsl:if test="(($citb6/citation/onlineURL!='')or($citb6/citation/offlineMedium!=''))">
            <xsl:if test="($citb6/citation/onlineURL!='')">
              <xsl:element name="distribution">
                <xsl:element name="online">
                  <xsl:element name="url">
                    <xsl:value-of select="$citb6/citation/onlineURL/url"/>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:if>
          <xsl:if test="($citb6/citation/offlineMedium!='')">
              <xsl:element name="distribution">
                <xsl:element name="offline">
                  <xsl:if test="$citb6/citation/offlineMedium/medName!=''"> 
                    <xsl:element name="mediumName">
                      <xsl:value-of select="$citb6/citation/offlineMedium/medName"/>
                    </xsl:element>
                  </xsl:if>
                  <xsl:if test="$citb6/citation/offlineMedium/medDensity!=''"> 
                    <xsl:element name="mediumDensity">
                      <xsl:value-of select="$citb6/citation/offlineMedium/medDensity"/>
                    </xsl:element>
                  </xsl:if>
                  <xsl:if test="$citb6/citation/offlineMedium/medDensityUnits!=''"> 
                    <xsl:element name="mediumDensityUnits">
                      <xsl:value-of select="$citb6/citation/offlineMedium/medDensityUnits"/>
                    </xsl:element>
                  </xsl:if>
                  <xsl:if test="$citb6/citation/offlineMedium/medVolume!=''"> 
                    <xsl:element name="mediumVolume">
                      <xsl:value-of select="$citb6/citation/offlineMedium/medVolume"/>
                    </xsl:element>
                  </xsl:if>
                  <xsl:if test="$citb6/citation/offlineMedium/medFormat!=''"> 
                    <xsl:element name="mediumFormat">
                      <xsl:value-of select="$citb6/citation/offlineMedium/medFormat"/>
                    </xsl:element>
                  </xsl:if>
                  <xsl:if test="$citb6/citation/offlineMedium/medNote!=''"> 
                    <xsl:element name="mediumNote">
                      <xsl:value-of select="$citb6/citation/offlineMedium/medNote"/>
                    </xsl:element>
                  </xsl:if>
                </xsl:element>
              </xsl:element>
            </xsl:if>
          </xsl:if>
          
          <xsl:if test="$citb6/citation/article!=''">
            <xsl:element name="article">
              <xsl:element name="journal">
                <xsl:value-of select="$citb6/citation/article/journal"/>
              </xsl:element>
              <xsl:element name="volume">
                <xsl:value-of select="$citb6/citation/article/volume"/>
              </xsl:element>
              <xsl:if test="$citb6/citation/article/issue!=''">
                <xsl:element name="issue">
                  <xsl:value-of select="$citb6/citation/article/issue"/>
                </xsl:element>
              </xsl:if>  
              <xsl:element name="pageRange">
                <xsl:value-of select="$citb6/citation/article/pageRange"/>
              </xsl:element>
              <xsl:if test="$citb6/citation/ISSN!=''">
                <xsl:element name="ISSN">
                  <xsl:value-of select="$citb6/citation/ISSN"/>
                </xsl:element>
              </xsl:if>  
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/book!=''">
            <xsl:element name="book">
              <xsl:element name="publisher">
                <!-- no publisher info in beta6-->
                <xsl:element name="organizationName">
                  <xsl:value-of select="'unknown'"/>
                </xsl:element>
              </xsl:element>
              <xsl:if test="$citb6/citation/book/edition!=''">
                <xsl:element name="edition">
                  <xsl:value-of select="$citb6/citation/book/edition"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/book/totalPages!=''">
                <xsl:element name="totalPages">
                  <xsl:value-of select="$citb6/citation/book/totalPages"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/book/totalFigures!=''">
                <xsl:element name="totalFigures">
                  <xsl:value-of select="$citb6/citation/book/totalFigures"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/book/totalTables!=''">
                <xsl:element name="totalTables">
                  <xsl:value-of select="$citb6/citation/book/totalTables"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/book/volume!=''">
                <xsl:element name="volume">
                  <xsl:value-of select="$citb6/citation/book/volume"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/ISBN!=''">
                <xsl:element name="ISBN">
                  <xsl:value-of select="$citb6/citation/ISBN"/>
                </xsl:element>
              </xsl:if>
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/chapter!=''">

            <xsl:element name="chapter">
              <xsl:element name="publisher">
                <xsl:element name="organizationName">
                  <xsl:value-of select="$citb6/citation/chapter/publisher"/>
                </xsl:element>
              </xsl:element>
              <xsl:if test="$citb6/citation/chapter/edition!=''">
                <xsl:element name="edition">
                  <xsl:value-of select="$citb6/citation/chapter/edition"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/chapter/totalPages!=''">
                <xsl:element name="totalPages">
                  <xsl:value-of select="$citb6/citation/chapter/totalPages"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/chapter/totalFigures!=''">
                <xsl:element name="totalFigures">
                  <xsl:value-of select="$citb6/citation/chapter/totalFigures"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/chapter/totalTables!=''">
                <xsl:element name="totalTables">
                  <xsl:value-of select="$citb6/citation/chapter/totalTables"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/chapter/volume!=''">
                <xsl:element name="volume">
                  <xsl:value-of select="$citb6/citation/chapter/volume"/>
                </xsl:element>
              </xsl:if>
              <xsl:if test="$citb6/citation/ISBN!=''">
                <xsl:element name="ISBN">
                  <xsl:value-of select="$citb6/citation/ISBN"/>
                </xsl:element>
              </xsl:if>
              
              <xsl:element name="editor">
                <xsl:element name="individualName">
                  <xsl:element name="surName">
                    <xsl:value-of select="$citb6/citation/chapter/bookEditor"/>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              
              <xsl:element name="bookTitle">
                <xsl:value-of select="$citb6/citation/chapter/bookTitle"/>
              </xsl:element>

              <xsl:if test="$citb6/citation/chapter/pageRange!=''"> 
                <xsl:element name="pageRange">
                  <xsl:value-of select="$citb6/citation/chapter/pageRange"/>
                </xsl:element>
              </xsl:if>  
              
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/manuscript!=''">
            <xsl:element name="manuscript">
              <xsl:element name="institution">
                <xsl:for-each select="$citb6/citation/manuscript/pubInfo/role">
                  <xsl:call-template name="responsibleParty"/>
               </xsl:for-each>
              </xsl:element>
            </xsl:element>  
              <!-- should only be one pubInfo in beta6 -->
              <!-- don't know where to map the 'location' element of manuscript in beta6 -->
          </xsl:if>

          <xsl:if test="$citb6/citation/report!=''">
            <xsl:element name="report">
              <xsl:element name="reportNumber">
                <xsl:value-of select="$citb6/citation/report/reportNumber"/>
              </xsl:element>
              <xsl:element name="publisher">
                <xsl:for-each select="$citb6/citation/report/institution/role">
                  <xsl:call-template name="responsibleParty"/>
               </xsl:for-each>
              </xsl:element>
            </xsl:element>
          </xsl:if>

          <xsl:if test="$citb6/citation/thesis!=''">
            <xsl:element name="thesis">
              <xsl:element name="degree">
                <xsl:value-of select="$citb6/citation/thesis/degree"/>
              </xsl:element>
              <xsl:element name="institution">
                <xsl:for-each select="$citb6/citation/thesis/pubInfo/role">
                  <xsl:call-template name="responsibleParty"/>
               </xsl:for-each>
              </xsl:element>
              <xsl:element name="totalPages">
                <xsl:value-of select="$citb6/citation/thesis/totalPages"/>
              </xsl:element>
            </xsl:element>
          </xsl:if>
          
    </citation>
  </xsl:template>
  

  
  
</xsl:stylesheet>

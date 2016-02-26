<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:stmml="http://www.xml-cml.org/schema/stmml" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:output encoding="ISO-8859-1"/>
<xsl:strip-space elements="*"/>


	<!-- assign variables for input doc i.e. beta6 attribute module -->
<!-- 	<xsl:variable name="attb6" select="document('att1.atb6')"/> -->
	<xsl:variable name="unitDict" select="document('eml-unitDictionary.xml')"/>

  <xsl:template name="attrTransform">
    <xsl:param name="attb6ID"/>
    <xsl:variable name="attb6" select="document(concat($packageDir,$attb6ID))"/>
    <attributeList>
      <!-- first handle case if there is NO attribute information (since it is required)     -->  
      <xsl:if test="count($attb6/eml-attribute/attribute)=0">
        <xsl:element name="attribute">
          <xsl:element name="attributeName">
            <xsl:value-of select="'N/A'"/>
          </xsl:element>
          <xsl:element name="attributeDefinition">
            <xsl:value-of select="'N/A'"/>
          </xsl:element>
          <xsl:element name="measurementScale">
             <xsl:element name="nominal">
               <xsl:element name="nonNumericDomain">
                 <xsl:element name="textDomain">
                   <xsl:element name="definition">
                     <xsl:value-of select="'not available'"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>  
              </xsl:element>  
          </xsl:element>
        </xsl:element>
      </xsl:if>
      <xsl:for-each select="$attb6/eml-attribute/attribute">
        <xsl:element name="attribute">
        
          <xsl:element name="attributeName"> 
            <xsl:value-of select="./attributeName"/>
          </xsl:element>
          
          <xsl:if test="$attb6/eml-attribute/attribute/attributeLabel!=''">
            <xsl:for-each select="./attributeLabel">
              <xsl:element name="attributeLabel">
                <xsl:value-of select="."/>
              </xsl:element>
            </xsl:for-each>  
          </xsl:if>
          
          <xsl:element name="attributeDefinition">
            <xsl:choose>
              <xsl:when test="./attributeDefinition!=''">
                <xsl:value-of select="./attributeDefinition"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="'N/A'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
          
          <xsl:if test="$attb6/eml-attribute/attribute/dataType!=''">
            <xsl:element name="storageType">
              <xsl:value-of select="./dataType"/>
            </xsl:element>
          </xsl:if>
          
          <xsl:element name="measurementScale">
     <!-- must determine which of 5 measurementScales to create -->
          <xsl:choose>
           <xsl:when test="((./attributeDomain/textDomain) and (./attributeDomain/textDomain=''))">
             <xsl:element name="nominal">
               <xsl:element name="nonNumericDomain">
                 <xsl:element name="textDomain">
                   <xsl:element name="definition">
                     <xsl:value-of select="'not available'"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>  
              </xsl:element>  
           </xsl:when>
     
            <xsl:when test="((./attributeDomain/enumeratedDomain!='')or(./attributeDomain/textDomain!=''))">
             <xsl:choose>
              <xsl:when test="./dataType='Date'"> <!-- need other string checks for time, etc here -->
                <xsl:element name="datetime">
                  <xsl:element name="formatString">
                    <xsl:value-of select="'YYY-MM-DD'"/><!-- this is an arbitrary choice -->  
                  </xsl:element>
                  <xsl:element name="dateTimePrecision">
                    <xsl:value-of select="'unknown'"/><!-- this is an arbitrary choice -->  
                  </xsl:element>
                  <xsl:element name="dateTimeDomain">
                    <xsl:element name="bounds">
                      <minimum exclusive="false">unknown</minimum>
                      <maximum exclusive="false">unknown</maximum>
                     </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:when>
              <xsl:when test="./dataType!='Date'"> <!-- need other string checks for time, etc here -->
                <xsl:element name="nominal">
                  <xsl:element name="nonNumericDomain">
                   <xsl:choose>
                     <xsl:when test="./attributeDomain/enumeratedDomain!=''">
                        <xsl:element name="enumeratedDomain">
                          <xsl:for-each select="./attributeDomain/enumeratedDomain"> 
                            <xsl:element name="codeDefinition">
                              <xsl:element name="code">
                                <xsl:value-of select="./code"/>
                              </xsl:element>
                              <xsl:element name="definition">
                                <xsl:value-of select="./definition"/>
                              </xsl:element>
                              <xsl:if test="./source!=''">
                                <xsl:element name="source">
                                  <xsl:value-of select="./source"/>
                                </xsl:element>
                              </xsl:if>  
                           </xsl:element>
                          </xsl:for-each>  
                        </xsl:element>
                     </xsl:when>
                     <xsl:when test="./attributeDomain/textDomain!=''">
                        <xsl:element name="textDomain">
                          <xsl:for-each select="./attributeDomain/textDomain"> 
                            <xsl:element name="definition">
                              <xsl:value-of select="./definition"/>
                            </xsl:element>
                            <xsl:if test="./pattern!=''">
                              <xsl:element name="pattern">
                                <xsl:value-of select="./pattern"/>
                              </xsl:element>
                            </xsl:if>  
                            <xsl:if test="./source!=''">
                              <xsl:element name="source">
                                <xsl:value-of select="./source"/>
                              </xsl:element>
                            </xsl:if>  
                          </xsl:for-each>
                       </xsl:element>
                     </xsl:when>
                    </xsl:choose> 
                  </xsl:element>
                </xsl:element>
              </xsl:when>
              <!-- don't see how to determine if data is ordinal !! -->
              <xsl:otherwise>
              <xsl:element name="nominal">
                <xsl:element name="nonNumericDomain">
                  <xsl:element name="textDomain">
                    <xsl:element name="definition">
                      <xsl:value-of select="'any text'"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              </xsl:otherwise>
             </xsl:choose> 
            </xsl:when>
            
            <xsl:when test="./attributeDomain/numericDomain">
            <!-- must be ratio or interval -->
            <!-- may have case where minimum exist but has no data -->
             <xsl:choose>
              <xsl:when test="(./attributeDomain/numericDomain/minimum='')">
                <xsl:element name="interval">
                  <xsl:element name="unit">
                      <xsl:call-template name="getUnit">
                        <xsl:with-param name="string" select="./unit"/>
                      </xsl:call-template>  

              <!--        <xsl:value-of select="./unit"/>  -->
                  </xsl:element>
                  <xsl:element name="precision">
                  <!-- Note: 'precision' sometimes is filled out in beta6 for nonnumeric data! -->
                    <xsl:choose>
                      <xsl:when test="./precision!=''">
                        <xsl:value-of select="./precision"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="'0.0'"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:element>
                  <xsl:element name="numericDomain">
                    <xsl:element name="numberType">real</xsl:element>
                    <!--should really check data type + bounds to see if integer?-->
                    <xsl:element name="bounds">
                      <xsl:element name="minimum">
                        <xsl:attribute name="exclusive">false</xsl:attribute>
                        <xsl:value-of select="'0.0'"/>
                      </xsl:element>
                      <xsl:element name="maximum">
                        <xsl:attribute name="exclusive">false</xsl:attribute>
                        <xsl:value-of select="'0.0'"/>
                      </xsl:element>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:when>
              <xsl:when test="((./attributeDomain/numericDomain/minimum!='')and((./attributeDomain/numericDomain/minimum)&gt;=0.0))">
                <xsl:element name="ratio">
                  <xsl:element name="unit">
                      <xsl:call-template name="getUnit">
                        <xsl:with-param name="string" select="./unit"/>
                      </xsl:call-template>  

              <!--        <xsl:value-of select="./unit"/>  -->
                  </xsl:element>
                  <xsl:element name="precision">
                  <!-- Note: 'precision' sometimes is filled out in beta6 for nonnumeric data! -->
                    <xsl:choose>
                      <xsl:when test="./precision!=''">
                        <xsl:value-of select="./precision"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="'0.0'"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:element>
                  <xsl:element name="numericDomain">
                    <xsl:element name="numberType">real</xsl:element>
                    <!--should really check data type + bounds to see if integer?-->
                    <xsl:element name="bounds">
                      <xsl:element name="minimum">
                        <xsl:attribute name="exclusive">false</xsl:attribute>
                        <xsl:value-of select="./attributeDomain/numericDomain/minimum"/>
                      </xsl:element>
                      <xsl:element name="maximum">
                        <xsl:attribute name="exclusive">false</xsl:attribute>
                        <xsl:value-of select="./attributeDomain/numericDomain/maximum"/>
                      </xsl:element>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:when>
              <xsl:when test="((./attributeDomain/numericDomain/minimum!='')and((./attributeDomain/numericDomain/minimum)&lt;0.0))">
                <xsl:element name="interval">
                  <xsl:element name="unit">
                      <xsl:call-template name="getUnit">
                        <xsl:with-param name="string" select="./unit"/>
                      </xsl:call-template>  

              <!--        <xsl:value-of select="./unit"/>  -->
                  </xsl:element>
                  <xsl:element name="precision">
                  <!-- Note: 'precision' sometimes is filled out in beta6 for nonnumeric data! -->
                    <xsl:choose>
                      <xsl:when test="./precision!=''">
                        <xsl:value-of select="./precision"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="'0.0'"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:element>
                  <xsl:element name="numericDomain">
                    <xsl:element name="numberType">real</xsl:element>
                    <xsl:element name="bounds">
                      <minimum exclusive='false'>
                        <xsl:attribute name="exclusive">false</xsl:attribute>
                        <xsl:value-of select="./attributeDomain/numericDomain/minimum"/>
                      </minimum>
                      <maximum exclusive='false'>
                        <xsl:attribute name="exclusive">false</xsl:attribute>
                        <xsl:value-of select="./attributeDomain/numericDomain/maximum"/>
                      </maximum>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:when>
              <xsl:otherwise>
              <xsl:element name="nominal">
                <xsl:element name="nonNumericDomain">
                  <xsl:element name="textDomain">
                    <xsl:element name="definition">
                      <xsl:value-of select="'any text'"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              </xsl:otherwise>
              
             </xsl:choose> 
            </xsl:when> 
            <!-- do the otherwise when cannot figure out the measurement Scale -->
            <xsl:otherwise>
              <xsl:element name="nominal">
                <xsl:element name="nonNumericDomain">
                  <xsl:element name="textDomain">
                    <xsl:element name="definition">
                      <xsl:value-of select="'any text'"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:otherwise>
           </xsl:choose> 
          </xsl:element>
          <xsl:if test="$attb6/eml-attribute/attribute/missingValueCode!=''">
            <xsl:for-each select="./missingValueCode">
              <xsl:element name="missingValueCode">
                <xsl:element name="code">
                  <xsl:value-of select="."/>
                </xsl:element>
                <xsl:element name="codeExplanation">not available</xsl:element>
              </xsl:element>
            </xsl:for-each>  
          </xsl:if>
          
        </xsl:element><!-- end of attribute element-->
      </xsl:for-each>
    </attributeList>
  
  </xsl:template>
  
  <!-- template to return unit id if name is in unit Dictionary -->
  <xsl:template name="getUnit">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="$unitDict/stmml:unitList/stmml:unit/@id=$string">
        <xsl:element name="standardUnit">
          <xsl:value-of select="$unitDict/stmml:unitList/stmml:unit/@id[.=$string]"/>
        </xsl:element>  
      </xsl:when>
      <xsl:when test="$unitDict/stmml:unitList/stmml:unit/@abbreviation=$string">
        <xsl:element name="standardUnit">
          <xsl:value-of select="$unitDict/stmml:unitList/stmml:unit[./@abbreviation=$string]/@id"/>
        </xsl:element>
          </xsl:when>
      <xsl:otherwise>
        <xsl:element name="customUnit">
          <xsl:value-of select="$string"/>
        </xsl:element>  
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>
  
</xsl:stylesheet>  

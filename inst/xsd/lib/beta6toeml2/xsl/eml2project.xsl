<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:output encoding="ISO-8859-1"/>
<xsl:strip-space elements="*"/>

<!--<xsl:variable name="projectb6" select="document('higgins.4108.2')"/> -->

  <xsl:include href="eml2cit.xsl"/>


<xsl:template name="project">
  <xsl:param name="projectID"/>
<!-- beta6 project has elements that go in both the methods and project elements in eml2 -->
	<xsl:variable name="projectb6" select="document(concat($packageDir,$pack/package/project))"/>

 
<xsl:if test="($projectb6/eml-project/researchProject/designDescription/protocol!='') or
              ($projectb6/eml-project/researchProject/designDescription/protocol/qualityControl!='') or
              ($projectb6/eml-project/researchProject/designDescription/sampling!='')">
  <xsl:element name="methods">
  <!-- in beta6, both the 'method' element and the 'protocol' element are repeatable; -->
  <!-- it is not clear which repetition corresponds to 'methodStep' in eml2!!! -->
  <!-- and we must have at least one methodStep in eml2 -->
    <xsl:element name="methodStep">
      <xsl:element name="description">
        <xsl:choose>
          <xsl:when test="$projectb6/eml-project/researchProject/designDescription/protocol/method/paragraph!=''">
            <xsl:for-each select="$projectb6/eml-project/researchProject/designDescription/protocol/method/paragraph">
              <xsl:element name="para">
                <xsl:value-of select="."/>
              </xsl:element>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="para">
              <xsl:value-of select="'not available'"/>
            </xsl:element>
          </xsl:otherwise>  
        </xsl:choose>
      </xsl:element>
      <xsl:for-each select="$projectb6/eml-project/researchProject/designDescription/protocol/method/citation">
          <!-- insert call to citation copy template here -->
          <xsl:call-template name="citTransform">
            <xsl:with-param name="citb6" select=".."/>
          </xsl:call-template>  
      </xsl:for-each>
    </xsl:element><!-- a single methodStep element has now been created, as required; multiple methodSteps are allowed, however-->
  <xsl:if test="$projectb6/eml-project/researchProject/designDescription/protocol/method[last()>1]">
    <xsl:element name="methodStep">
      <xsl:element name="description">
        <xsl:choose>
          <xsl:when test="$projectb6/eml-project/researchProject/designDescription/protocol/method/paragraph!=''">
            <xsl:for-each select="$projectb6/eml-project/researchProject/designDescription/protocol/method/paragraph">
              <xsl:element name="para">
                <xsl:value-of select="."/>
              </xsl:element>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="para">
              <xsl:value-of select="'not available'"/>
            </xsl:element>
          </xsl:otherwise>  
        </xsl:choose>
      </xsl:element>
      <xsl:for-each select="$projectb6/eml-project/researchProject/designDescription/protocol/method/citation">
          <!-- insert call to citation copy template here -->
          <xsl:call-template name="citTransform">
            <xsl:with-param name="citb6" select=".."/>
          </xsl:call-template>  
      </xsl:for-each>
    </xsl:element><!-- repeating methodStep as needed-->
  </xsl:if>
  
  <xsl:if test="$projectb6/eml-project/researchProject/designDescription/sampling!=''">
    <xsl:element name="sampling">
      <xsl:element name="studyExtent">
        <xsl:for-each select="$projectb6/eml-project/researchProject/designDescription/sampling/temporalCov">
             <xsl:element name="temporalCoverage">
               <!-- insert temporal template here DFH-->
             </xsl:element>  
        </xsl:for-each>
          <xsl:element name="description">
            <xsl:element name="para">
              <xsl:choose>
                <xsl:when test="$projectb6/eml-project/researchProject/designDescription/sampling/frequency!=''">
                  <xsl:value-of select="$projectb6/eml-project/researchProject/designDescription/sampling/frequency"/>
                  <!-- cannot find an appropriate element for frequency information in eml2 sampling!! -->
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'no information'"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
          </xsl:element>
      
      </xsl:element>
      <xsl:element name="samplingDescription">
        <xsl:element name="para">
          <xsl:choose>
            <xsl:when test="$projectb6/eml-project/researchProject/designDescription/sampling/paragraph!=''">
              <xsl:value-of select="$projectb6/eml-project/researchProject/designDescription/sampling/paragraph"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'not available'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
      </xsl:element><!-- end of 'samplingDescription' -->
      
      <xsl:if test="$projectb6/eml-project/researchProject/designDescription/sampling/citation!=''">
        <xsl:for-each select="$projectb6/eml-project/researchProject/designDescription/sampling/citation">
            <!-- call citation template here -->
          <xsl:call-template name="citTransform">
            <xsl:with-param name="citb6" select=".."/>
          </xsl:call-template>  
        </xsl:for-each>
      </xsl:if>
    </xsl:element><!-- end of 'sampling --> 
  </xsl:if>
    
    
  </xsl:element><!-- end ot methods element -->
</xsl:if>

<project>
  <xsl:for-each select="$projectb6/eml-project/researchProject/title">
    <xsl:element name="title">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:for-each>

   <xsl:for-each select="$projectb6/eml-project/researchProject/personnel/role">
    <xsl:element name="personnel">
      <!-- responsible party info goes here -->
      <xsl:call-template name="responsibleParty"/>
    <xsl:choose>
      <xsl:when test="$projectb6/eml-project/researchProject/personnel/role!=''">
        <xsl:element name="role">
          <xsl:value-of select="$projectb6/eml-project/researchProject/personnel/role"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="role">
          <xsl:value-of select="'unknown'"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:element>
   </xsl:for-each>
   
   <xsl:if test="$projectb6/eml-project/researchProject/abstract!=''">
     <xsl:element name="abstract">
       <xsl:element name="para">
         <xsl:value-of select="$projectb6/eml-project/researchProject/abstract/paragraph"/>
       </xsl:element>
     </xsl:element>
   </xsl:if>
   
   <xsl:if test="$projectb6/eml-project/researchProject/funding!=''">
     <xsl:element name="funding">
       <xsl:element name="para">
         <xsl:value-of select="$projectb6/eml-project/researchProject/funding/paragraph"/>
       </xsl:element>
     </xsl:element>
   </xsl:if>
   
   <xsl:choose>
    <xsl:when test="(($projectb6/eml-project/researchProject/siteDescription!='') or
                    ($projectb6/eml-project/researchProject/temporalCov!='') or
                    ($projectb6/eml-project/researchProject/geographicCov!=''))">
     <xsl:element name="studyAreaDescription">
       <xsl:element name="descriptor">
         <xsl:attribute name="name"><xsl:value-of select="'unknown'"/></xsl:attribute>
         <xsl:attribute name="citableClassificationSystem"><xsl:value-of select="'false'"/></xsl:attribute>
         <xsl:element name="descriptorValue">
           <xsl:choose>
             <xsl:when test="$projectb6/eml-project/researchProject/siteDescription/paragraph!=''">
               <xsl:value-of select="$projectb6/eml-project/researchProject/siteDescription/paragraph"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="'unknown'"/>
             </xsl:otherwise>
           </xsl:choose>
         </xsl:element>  
       </xsl:element>
       <xsl:if test="$projectb6/eml-project/researchProject/siteDescription/citation!=''">
          <xsl:call-template name="citTransform">
            <xsl:with-param name="citb6" select="$projectb6/eml-project/researchProject/siteDescription"/>
          </xsl:call-template>  
       </xsl:if>
       <xsl:if test="(($projectb6/eml-project/researchProject/temporalCov!='') or ($projectb6/eml-project/researchProject/geographicCov!=''))">
         <xsl:element name="coverage">
            <xsl:if test="$projectb6/eml-project/researchProject/geographicCov!=''">            
              <xsl:element name="geographicCoverage">
                <xsl:for-each select="$projectb6/eml-project/researchProject/geographicCov">
                  <xsl:call-template name="geographicCoverage"/>
                </xsl:for-each>
              </xsl:element> 
            </xsl:if>

            <xsl:if test="$projectb6/eml-project/researchProject/temporalCov!=''"> 
              <xsl:element name="temporalCoverage">
                <xsl:for-each select="$projectb6/eml-project/researchProject/temporalCov">
                  <xsl:call-template name="temporalCoverage"/>
                </xsl:for-each>
              </xsl:element> 
            </xsl:if>
         
         </xsl:element>
       </xsl:if>
     </xsl:element>
    </xsl:when>
   </xsl:choose>

   <xsl:if test="$projectb6/eml-project/researchProject/designDescription!=''">
     <xsl:element name="designDescription">
       <xsl:element name="description">
         <xsl:element name="para">
           <xsl:choose>
             <xsl:when test="$projectb6/eml-project/researchProject/designDescription/paragraph!=''">
               <xsl:value-of select="$projectb6/eml-project/researchProject/designDescription/paragraph"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="'not available'"/>
             </xsl:otherwise>
           </xsl:choose>
         </xsl:element>
       </xsl:element>  
     </xsl:element>

  </xsl:if>   
</project>


</xsl:template>



</xsl:stylesheet>

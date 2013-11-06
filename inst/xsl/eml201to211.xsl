<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:eml="eml://ecoinformatics.org/eml-2.1.1" version="1.0">
  <xsl:output method="xml" indent="yes"></xsl:output>
  <!--<xsl:strip-space elements="*"></xsl:strip-space>-->
  <xsl:param name="package-id" select="'newID'"/>
	
  <xsl:template match="/* ">
    <!--handle top level element-->
    <xsl:element name="eml:eml">   
      <!--<xsl:copy-of select="@*"></xsl:copy-of>-->
      <!--<xsl:attribute name="xsi:schemaLocation">eml://ecoinformatics.org/eml-2.1.1 eml.xsd</xsl:attribute>-->

	  <!--<xsl:copy-of select="namespace::*[not(starts-with(.,'eml://ecoinformatics.org/')) or . != 'http://www.w3.org/2001/XMLSchema-instance']"/>-->
      <xsl:for-each select="@*">
	   <xsl:choose>
	    <xsl:when test="namespace-uri()='http://www.w3.org/2001/XMLSchema-instance'">
        <xsl:attribute name="xsi:{local-name()}" namespace="{namespace-uri()}">
          <xsl:variable name="value" select="."></xsl:variable>
          <xsl:choose>
            <!--change eml200 and stmml to eml210 and stmml-1.1 in attribute-->
            <xsl:when test="contains($value, &quot;eml://ecoinformatics.org/eml-2.0.0&quot;)">
              <xsl:variable name="first-replace">
                 <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$value"></xsl:with-param>
                    <xsl:with-param name="replace" select="'eml://ecoinformatics.org/eml-2.0.0'"></xsl:with-param>
                    <xsl:with-param name="with" select="'eml://ecoinformatics.org/eml-2.1.1'"></xsl:with-param>
                 </xsl:call-template>
			   </xsl:variable>
			   <xsl:variable name="second-replace">
                 <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$first-replace"></xsl:with-param>
                    <xsl:with-param name="replace" select="'http://www.xml-cml.org/schema/stmml'"></xsl:with-param>
                    <xsl:with-param name="with" select="'http://www.xml-cml.org/schema/stmml-1.1'"></xsl:with-param>
                 </xsl:call-template>
			   </xsl:variable>
				<xsl:value-of select="$second-replace"></xsl:value-of>
            </xsl:when>
			 <!--change eml201 and stmml to eml210 and stmml-1.1 in attribute-->
            <xsl:when test="contains($value, 'eml://ecoinformatics.org/eml-2.0.1') or contains($value, 'http://www.xml-cml.org/schema/stmml')">
			  <xsl:variable name="first-replace">
                 <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$value"></xsl:with-param>
                    <xsl:with-param name="replace" select="'eml://ecoinformatics.org/eml-2.0.1'"></xsl:with-param>
                    <xsl:with-param name="with" select="'eml://ecoinformatics.org/eml-2.1.1'"></xsl:with-param>
                 </xsl:call-template>
			   </xsl:variable>
			   <xsl:variable name="second-replace">
                 <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$first-replace"></xsl:with-param>
                    <xsl:with-param name="replace" select="'http://www.xml-cml.org/schema/stmml'"></xsl:with-param>
                    <xsl:with-param name="with" select="'http://www.xml-cml.org/schema/stmml-1.1'"></xsl:with-param>
                 </xsl:call-template>
			   </xsl:variable>
				<xsl:value-of select="$second-replace"></xsl:value-of>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."></xsl:value-of>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
            <xsl:choose>
               <xsl:when test="name()='packageId'">
				   <!-- handle package id: if there is no given packageid, it will use the old one. Otherwise, using the given id-->
			       <xsl:attribute name="{name()}" namespace="{namespace-uri()}">
					    <xsl:choose>
							<xsl:when test="$package-id='newID'">
								<xsl:value-of select="."/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$package-id"/>
							</xsl:otherwise>
						</xsl:choose>
			       </xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
				  <xsl:attribute name="{name()}" namespace="{namespace-uri()}">
                        <xsl:value-of select="."/>
                   </xsl:attribute> 
               </xsl:otherwise>
            </xsl:choose>
		</xsl:otherwise>
       </xsl:choose>
      </xsl:for-each>
      <!--<xsl:attribute name="xsi:schemaLocation">
		  <xsl:value-of select='translate(@xsi:schemaLocation, "eml-2.0.1", "eml-2.1.1")'/>
	  </xsl:attribute>-->
      <!-- move the access sub tree to top level-->
      <xsl:apply-templates mode="copy-top-access-tree" select="/*/dataset/access"></xsl:apply-templates>
      <xsl:apply-templates mode="copy-top-access-tree" select="/*/citation/access"></xsl:apply-templates>
      <xsl:apply-templates mode="copy-top-access-tree" select="/*/software/access"></xsl:apply-templates>
      <xsl:apply-templates mode="copy-top-access-tree" select="/*/protocol/access"></xsl:apply-templates>

      <xsl:for-each select="/*/*">
        <xsl:choose>
          <xsl:when test="name()='dataset'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='citation'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='software'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='protocol'">
            <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
              <xsl:copy-of select="@*"></xsl:copy-of>
              <xsl:apply-templates mode="handle-elements-under-main-module" select="."
              ></xsl:apply-templates>
            </xsl:element>
          </xsl:when>

          <xsl:when test="name()='additionalMetadata'">
            <xsl:apply-templates mode="handle-additionalMetadata" select="."></xsl:apply-templates>
          </xsl:when>

        </xsl:choose>
      </xsl:for-each>
    </xsl:element>
	 <xsl:message terminate="no">
		 <xsl:call-template name="output_message4_warn"/>
	  </xsl:message>
  </xsl:template>

  <!-- handle make changes under main module (dataset, citation, protocol and software) -->
  <xsl:template mode="handle-elements-under-main-module" match="*">
    <xsl:for-each select="./*">
      <xsl:choose>
        <xsl:when test="name()='access'">
          <xsl:apply-templates mode="do-nothing" select="."></xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="."></xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- main template which will copy nodes recursively-->
  <xsl:template match="*">
    <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates></xsl:apply-templates>
    </xsl:element>
  </xsl:template>

  <!-- fixing attributeList/attribute/measurementScale/datetime -> .../dateTime -->
  <xsl:template match="attributeList/attribute/measurementScale/datetime">
    <xsl:element name="dateTime" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates mode="copy-no-ns" select="./*"></xsl:apply-templates>
    </xsl:element>
  </xsl:template>

  <!-- change the name of element form method to methods -->
  <xsl:template match="dataTable/method | spatialRaster/method | spatialVector/method 
	  | view/method | storedProcedure/method | otherEntity/method">
    <xsl:element name="methods" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates mode="copy-no-ns-with-access-move" select="./*"></xsl:apply-templates>
    </xsl:element>
  </xsl:template>

  <!-- change the name of element form method to methods -->
  <xsl:template match="attribute/method">
    <xsl:element name="methods" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates mode="copy-no-ns-with-access-move" select="./*"></xsl:apply-templates>
    </xsl:element>
  </xsl:template>
	
	
	<!-- since under element "method", it can have distribution access movement, so this template will handle that-->
    <!-- copy node and children without namespace -->
  <xsl:template mode="copy-no-ns-with-access-move" match="*">
	 <xsl:choose>
		 <xsl:when test="name()='distribution' and name(parent::node())='implementation' and name(../..)='software'">			  
			 <xsl:call-template name="move-access"/>
		  </xsl:when>
		 <xsl:otherwise>
		      <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
                <xsl:copy-of select="@*"></xsl:copy-of>
                <xsl:apply-templates mode="copy-no-ns-with-access-move"></xsl:apply-templates>
              </xsl:element>
		 </xsl:otherwise>
	 </xsl:choose>   
  </xsl:template>

     <!--template to match physical/distribution and software/implementation/distribution which need to move around access module-->
	<xsl:template match="physical/distribution | software/implementation/distribution">
		<xsl:call-template name="move-access"/>
	</xsl:template>
	
  <!-- Move the access tree of data file level from additionalMetadata part to physical/distribution or software/implementation/distribution part.
           If we find the id of physical/distribution is in aditionalMetadata/describe and it 
             has sibling of access subtree, copy the subtree to physical/distribution -->
  <xsl:template name="move-access">
    <xsl:element name="distribution" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates mode="copy-no-ns" select="./*"></xsl:apply-templates>
      <!--distribution doesn't have any access node yet. Move the subtree from addtionalMetadata to distribution-->
      <!--find the id in addtionalMetacat/describes-->
      <xsl:variable name="id" select="@id"></xsl:variable>
      <!-- count how many additionalMetadata/access describing same distribution is -->
      <xsl:variable name="countAccessTree"
        select="count(/*/additionalMetadata[describes=$id]/access | /*/additionalMetadata[describes=$id]/metadata/access)"></xsl:variable>
      <xsl:choose>
        <xsl:when test="$countAccessTree=1">
          <!-- only has one access tree, we need copy it to distribution-->
          <xsl:apply-templates mode="copy-no-ns"
            select="/*/additionalMetadata[describes=$id]/access | /*/additionalMetadata[describes=$id]/metadata/access"
          ></xsl:apply-templates>
        </xsl:when>
        <xsl:when test="$countAccessTree &gt; 1">
          <!-- has more than one access tree, we need merge them-->
          <!--This means document have two or more addtionalMetadata
					          with access tree describing same distribution.
                       		<additionalMetadata>
                          		<describes>100</describe>
                          		<access>...</access>
                        	</additionalMetadata>
						 	<additionalMetadata>
                          		<describes>100</describe>
                          		<access>...</access>
                        	</additionalMetadata>-->
          <xsl:variable name="totalOrderNumber"
            select="count(/*/additionalMetadata[describes=$id]/access | /*/additionalMetadata[describes=$id]/metadata/access)"></xsl:variable>
          <xsl:variable name="totalAllowFirstNumber"
            select="count(/*/additionalMetadata[describes=$id]/access[@order='allowFirst'] | /*/additionalMetadata[describes=$id]/metadata/access[@order='allowFirst'])"></xsl:variable>
          <xsl:variable name="totalDenyFirstNumber"
            select="count(/*/additionalMetadata[describes=$id]/access[@order='denyFirst'] | /*/additionalMetadata[describes=$id]/metadata/access[@order='denyFirst'])"></xsl:variable>
          <xsl:choose>
            <xsl:when
              test="$totalOrderNumber=$totalAllowFirstNumber or $totalOrderNumber=$totalDenyFirstNumber">
              <!-- all access subtrees have same order, just merge it-->
              <xsl:element name="access">
                <xsl:copy-of
                  select="/*/additionalMetadata[describes=$id]/access/@* | /*/additionalMetadata[describes=$id]/metadata/access/@*"></xsl:copy-of>
                <xsl:for-each
                  select="/*/additionalMetadata[describes=$id]/access | /*/additionalMetadata[describes=$id]/metadata/access">
                  <xsl:apply-templates mode="copy-no-ns" select="./*"></xsl:apply-templates>
                </xsl:for-each>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:message terminate="no">
                <xsl:call-template name="output_message1_warn">
                <xsl:with-param name="current_node" select="current()"></xsl:with-param>
              </xsl:call-template> </xsl:message>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>


  <!-- copy access tree under dataset(or protocol, software and citation) to the top level -->
  <xsl:template mode="copy-top-access-tree" match="*">
    <xsl:apply-templates mode="copy-no-ns" select="."></xsl:apply-templates>
  </xsl:template>

  <!-- do nothing for this element (removing it)-->
  <xsl:template mode="do-nothing" match="*"> </xsl:template>

  <!-- copy node and children without namespace -->
  <!--<xsl:template mode="copy-no-ns" match="*">
    <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"></xsl:copy-of>
      <xsl:apply-templates mode="copy-no-ns"></xsl:apply-templates>
    </xsl:element>
  </xsl:template>-->
	
	
	<!-- copy node and children without showing default namespace. 
		But if the namespace is stmml, the namespace will be changed to stmml-1.1 -->
  <xsl:template mode="copy-no-ns" match="*">
   <xsl:choose>
	  <!--handle stmml element and attribute-->
	 <xsl:when test="namespace-uri()='http://www.xml-cml.org/schema/stmml'">
        <xsl:element name="stmml:{local-name()}" namespace="http://www.xml-cml.org/schema/stmml-1.1">
              <xsl:for-each select="@*">
	              <xsl:choose>
	                 <xsl:when test="namespace-uri()='http://www.w3.org/2001/XMLSchema-instance'">
                         <xsl:attribute name="xsi:{local-name()}" namespace="http://www.w3.org/2001/XMLSchema-instance">
                              <xsl:variable name="value" select="."></xsl:variable>
                                 <xsl:choose>
                                      <!--change stmml to stmml-1.1 in attribute-->
                                         <xsl:when test="contains($value, &quot;http://www.xml-cml.org/schema/stmml&quot;)">
                                              <xsl:call-template name="replace-string">
                                                 <xsl:with-param name="text" select="$value"></xsl:with-param>
                                                  <xsl:with-param name="replace" select="'http://www.xml-cml.org/schema/stmml'"></xsl:with-param>
                                                  <xsl:with-param name="with" select="'http://www.xml-cml.org/schema/stmml-1.1'"></xsl:with-param>
                                              </xsl:call-template>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <xsl:value-of select="."></xsl:value-of>
                                          </xsl:otherwise>
                              </xsl:choose>
                        </xsl:attribute>
		           </xsl:when>
		           <xsl:otherwise>
			           <xsl:copy-of select="."></xsl:copy-of>
		           </xsl:otherwise>
               </xsl:choose>
           </xsl:for-each>
           <xsl:apply-templates mode="copy-no-ns"></xsl:apply-templates>
        </xsl:element>
	 </xsl:when>
	  <!--handle non-stmml element-->
	 <xsl:otherwise>
		 <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
            <xsl:copy-of select="@*"></xsl:copy-of>
            <xsl:apply-templates mode="copy-no-ns"></xsl:apply-templates>
         </xsl:element>
     </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
	
	<!-- if the element has no element child and value is empty string or whitespace and element name is not recordDelimiter, physicalLineDelimiter and fieldDelimiter,
      the tranformation will be terminated. -->
  <xsl:template match="*[not(*) and ((text() and not(normalize-space(text()) != '')) or .='') 
       and  name(.) != 'recordDelimiter' and name(.) != 'physicalLineDelimiter' and name(.) != 'fieldDelimiter' ]">
      <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
            <xsl:copy-of select="@*"></xsl:copy-of>
            <xsl:value-of select="."/>
      </xsl:element>
      <xsl:message terminate="no">
        <xsl:call-template name="output_message3_warn">
          <xsl:with-param name="current_node" select="."/>
        </xsl:call-template>
      </xsl:message>
  </xsl:template>
    
  <xsl:template mode="copy-no-ns-with-access-move" match="*[not(*) and ((text() and not(normalize-space(text()) != '')) or .='') 
       and name(.) != 'recordDelimiter' and name(.) != 'physicalLineDelimiter' and name(.) != 'fieldDelimiter' ]">
      <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
            <xsl:copy-of select="@*"></xsl:copy-of>
            <xsl:value-of select="."/>
      </xsl:element>
      <xsl:message terminate="no">
        <xsl:call-template name="output_message3_warn">
          <xsl:with-param name="current_node" select="."/>
        </xsl:call-template>
      </xsl:message>
  </xsl:template>
    
  <xsl:template mode="copy-no-ns" match="*[not(*) and ((text() and not(normalize-space(text()) != '')) or .='') 
       and name(.) != 'recordDelimiter' and name(.) != 'physicalLineDelimiter' and name(.) != 'fieldDelimiter' ]">
      <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
            <xsl:copy-of select="@*"></xsl:copy-of>
            <xsl:value-of select="."/>
      </xsl:element>
      <xsl:message terminate="no">
        <xsl:call-template name="output_message3_warn">
          <xsl:with-param name="current_node" select="."/>
        </xsl:call-template>
      </xsl:message>
  </xsl:template>


  <!--Handle additionMetadata part. Here are 4 scenarios:
         1. <additionalMetadata>
					<describes>100</describes>
                     <foo>.....</foo>
             </additionalMetacata>
             The result will be (foo deosn't euqal access):
             <additionalMetadata>
					<describes>100</describes>
                     <metadata><foo>.....</foo></metadata>
             </additionalMetacata>
         2. <additionalMetadata>
					<describes>100</describes>
					<describes>200</describes>
                     <access>.....</access>
             </additionalMetacata>
            Both 100 and 200 are referenced ids of pysical/distribtuion or software/implementation/distribution.
            Since we moved the access part to distribution element. If multiple access rules are present 
            which reference the same distribution node, they are combined in th order they appear in 
            additionalMetadata sections. A conflict can occur here if  "order" attributes dont match. Fail
            with an erroro message.
            
            Since both are referenced id (and no conflict), we don't need to keep the info. 
           So the output is blank - remvoing the additionalMetadata tree.
         3. <additionalMetadata>
					<describes>300</describes>
					<describes>400</describes>
                     <access>.....</access>
             </additionalMetacata>
            300 is the referenced ids of pysical/distribtuion or software/implementation/distribution. 
            But 400 is not. So output will be:
            <additionalMetadata>
					<describes>400</describes>
                     <metadata><access>.....</access></metadata>
             </additionalMetacata>
            And we will give an warning message: message #2 referenced node is a not distribution id .
		4. <additionalMetadata>
                     <access>.....</access>
             </additionalMetacata>
            Since no describes, no access tree will move. So output will be:
            <additionalMetadata>
                     <metadata><access>.....</access></metadata>
             </additionalMetacata>
            And we will give an warning message:message #2 No distribution id in addtionalMetadata/describes 
            .
	-->
  <xsl:template mode="handle-additionalMetadata" match="*">
    <!-- this param for passing a suspicious node to an output message -->
    <xsl:param name="current_node"/>
    <!-- test if this additionalMetadata part has "access" element-->
    <xsl:variable name="accessCount" select="count(access | metadata/access)"></xsl:variable>
	
    <xsl:choose>
      <xsl:when test="$accessCount &lt; 1">
        <!-- no access tree here. Scenario 1 -->
        <additionalMetadata>
          <xsl:for-each select="./*">
            <xsl:choose>
              <xsl:when test="name()='describes'">
                <xsl:apply-templates mode="copy-no-ns" select="."></xsl:apply-templates>
              </xsl:when>
              <!--if it already has metadata tag under additionalMetadata, just copy it-->
              <xsl:when test="name()='metadata'">
                <xsl:apply-templates mode="copy-no-ns" select="."></xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <metadata>
                  <xsl:apply-templates mode="copy-no-ns" select="."></xsl:apply-templates>
                </metadata>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </additionalMetadata>
      </xsl:when>
      <xsl:otherwise>
        <!--additionalMetadata has EML access child-->
        <xsl:variable name="describesCount" select="count(describes)"></xsl:variable>
        <xsl:choose>
          <xsl:when test="$describesCount=0">
            <!-- scenario 4 - only has access but no describes, leave it there-->
            <additionalMetadata>
              <xsl:for-each select="./*">
                <xsl:choose>
                  <xsl:when test="name()='metadata'">
                    <xsl:apply-templates mode="copy-no-ns" select="."></xsl:apply-templates>
                  </xsl:when>
                  <xsl:otherwise>
                    <metadata>
                      <xsl:apply-templates mode="copy-no-ns" select="."></xsl:apply-templates>
                    </metadata>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
              <xsl:message terminate="no">
                <xsl:call-template name="output_message2_warn">
                  <xsl:with-param name="current_node" select="current()"></xsl:with-param>
                </xsl:call-template>
              </xsl:message>
            </additionalMetadata>
          </xsl:when>
          <xsl:otherwise>
            <!-- Scenario 2 and 3 -->
			 <xsl:variable name="describes" select="./describes"/>
            <xsl:call-template name="handle-describe-access-in-additional-metadata">
              <!--select node-set of describe which doesn't refer physical/distribtuion or software/implmentation/distribution and it doesn't have both "denyFirst" and "allowFirst"-->
              <xsl:with-param name="describes-list"
                select="./describes[(not(//physical/distribution/@id =.) and not(//software/implementation/distribution/@id = .)) or
				   ((//physical/distribution/@id =. or //software/implementation/distribution/@id = .) and (//additionalMetadata[describes = $describes and (access[@order='allowFirst'] or metadata/access[@order='allowFirst'])] and //additionalMetadata[describes = $describes and (access[@order='denyFirst'] or metadata/access[@order='denyFirst'])]))]"
              ></xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- parameter desribes will have the node-set of "describe" which doesn't reference any physical/distribtuion or
		software/implmentation/distribution. If size of node-set is zero, the template will do nothing, in other it will
		remove the additionalMetadata. If the size is not zero, we will keep the desribes and access-->
  <xsl:template name="handle-describe-access-in-additional-metadata">
    <xsl:param name="describes-list"></xsl:param>
    <xsl:choose>
      <xsl:when test="count($describes-list)=0">
        <!--Scenario 2: do nothing since all desribes are reference to physical/distribtuion or software/implmentation/distribution-->
      </xsl:when>
      <xsl:otherwise>
        <!--Scenario 3: some desribes doesn't refer to physical/distribtuion or software/implmentation/distribution. We need to keep them-->
        <additionalMetadata>
          <xsl:call-template name="recursive-describes">
            <xsl:with-param name="describes" select="$describes-list"></xsl:with-param>
          </xsl:call-template>
          <metadata>
            <xsl:apply-templates mode="copy-no-ns" select="./access | ./metadata/access"
            ></xsl:apply-templates>
          </metadata>
        </additionalMetadata>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Use a recursive way to print out describes which doesn't refer physical/distribtuion or software/implmentation/distribution -->
  <xsl:template name="recursive-describes">
    <xsl:param name="describes"></xsl:param>
    <xsl:param name="index" select="1"></xsl:param>
    <xsl:choose>
      <!--finish-->
      <xsl:when test="$index > count($describes)">
        <!-- do nothing-->
      </xsl:when>
      <xsl:otherwise>
        <describes>
          <xsl:value-of select="$describes[$index]"></xsl:value-of>
        </describes>
        <xsl:call-template name="recursive-describes">
          <xsl:with-param name="describes" select="$describes"></xsl:with-param>
          <xsl:with-param name="index" select="$index + 1"></xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--Template to replace string "replace" by string "with" in given string "text"-->
  <xsl:template name="replace-string">
    <xsl:param name="text"></xsl:param>
    <xsl:param name="replace"></xsl:param>
    <xsl:param name="with"></xsl:param>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"></xsl:value-of>
        <xsl:value-of select="$with"></xsl:value-of>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text,$replace)"></xsl:with-param>
          <xsl:with-param name="replace" select="$replace"></xsl:with-param>
          <xsl:with-param name="with" select="$with"></xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
    
    these templates output mesages for the user if an additionalMetdata section cant be moved. -->
  <!-- 
    this message for scenario 1, order attribute conflict -->
  <xsl:template name="output_message1_warn">
    <xsl:param name="current_node"/>
    <xsl:text>
      Warning:
      The EML 2.0.1 document you wish to transform has multiple access subtrees in addtionalMetadata 
      blocks which describe the same entity.  However, their "order" attributes do not match, so these 
      access rules cannot be combinded under the entity's distribution node. Please fix the incoming 
      (EML 2.0) document so that the  "order" attributes on all access nodes for an entity are the same.
      Example content to help locate the problem:     </xsl:text>
    <xsl:value-of select="$current_node"/>  </xsl:template>    
  <!-- 
    
    this message for scenario 4  -->
  <xsl:template name="output_message2_warn">
    <xsl:param name="current_node"/>
    <xsl:text>
      Warning: 
      This document doesn't follow  EML2.0.1 specs for including access trees. It appears to contain an
      additonalMetadata section with an access element, but there is no describes element referencing 
      the id of a physical/distribution or a software/implementation/distribution element (there might be 
      a reference to some other node, however). The rest of the document was successfully converted to 
      EML2.1, although the offending access tree was left as is. You should examine your incoming 
      document and change it to comply with EML 2.0.1 specs, or move this access tree using some 
      other method. 
      Example content to help locate a potential problem:     </xsl:text>
    <xsl:value-of select="$current_node"/>
  </xsl:template>
	
  <!-- message for empty string element-->
  <xsl:template name="output_message3_warn">
    <xsl:param name="current_node"/>
    <xsl:text>
      Warning:
      The EML 2.0.1 document has an empty string (or whitespace) in an element which cannot be empty in EML 2.1.1 sepcification - </xsl:text>
    <xsl:apply-templates select="$current_node" mode="get-full-path"/>
</xsl:template>    
	
	
	<!-- message for reminding  user  that the eml 211 document may be invalid-->
  <xsl:template name="output_message4_warn">
 
    <xsl:text>
      Warning:
      The EML 2.0.1 document has been transformed into an EML 2.1.1 document. However, you should check if it is valid. 
	  See http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-210info.html for more information.</xsl:text>
    
</xsl:template>    
  <!-- 
    
    end of user message templates -->
	
	<!-- get full path of given element-->
    <xsl:template match="node()" mode="get-full-path">
      <xsl:for-each select="ancestor-or-self::*">
        <xsl:text>/</xsl:text><xsl:value-of select="name()" />
      </xsl:for-each>
    </xsl:template>





</xsl:stylesheet>

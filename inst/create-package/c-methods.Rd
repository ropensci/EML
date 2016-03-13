\docType{methods}
\title{concatenate}
\name{c,section-method}
\alias{c,additionalInfo-method}
\alias{c,additionalMetadata-method}
\alias{c,address-method}
\alias{c,allow-method}
\alias{c,alternateIdentifier-method}
\alias{c,altitudeResolution-method}
\alias{c,associatedParty-method}
\alias{c,attribute-method}
\alias{c,attributeLabel-method}
\alias{c,attributeReference-method}
\alias{c,authentication-method}
\alias{c,bandDescription-method}
\alias{c,bounds-method}
\alias{c,changeHistory-method}
\alias{c,citation-method}
\alias{c,citetitle-method}
\alias{c,classificationSystem-method}
\alias{c,codeDefinition-method}
\alias{c,codesetURL-method}
\alias{c,commonName-method}
\alias{c,compressionMethod-method}
\alias{c,constraint-method}
\alias{c,contact-method}
\alias{c,controlPoint-method}
\alias{c,cornerPoint-method}
\alias{c,coverage-method}
\alias{c,creator-method}
\alias{c,dataSource-method}
\alias{c,dataTable-method}
\alias{c,datasetGPolygon-method}
\alias{c,datasetGPolygonExclusionGRing-method}
\alias{c,deliveryPoint-method}
\alias{c,deny-method}
\alias{c,depthResolution-method}
\alias{c,describes-method}
\alias{c,description-method}
\alias{c,descriptor-method}
\alias{c,descriptorValue-method}
\alias{c,distribution-method}
\alias{c,editor-method}
\alias{c,electronicMailAddress-method}
\alias{c,eml:language-method}
\alias{c,emphasis-method}
\alias{c,encodingMethod-method}
\alias{c,enumeratedDomain-method}
\alias{c,fieldDelimiter-method}
\alias{c,gRingPoint-method}
\alias{c,geographicCoverage-method}
\alias{c,geometry-method}
\alias{c,givenName-method}
\alias{c,horizCoordSysDef-method}
\alias{c,identificationReference-method}
\alias{c,identifierName-method}
\alias{c,implementation-method}
\alias{c,individualName-method}
\alias{c,institution-method}
\alias{c,instrumentation-method}
\alias{c,itemizedlist-method}
\alias{c,keyword-method}
\alias{c,keywordSet-method}
\alias{c,license-method}
\alias{c,licenseURL-method}
\alias{c,listitem-method}
\alias{c,literalCharacter-method}
\alias{c,literalLayout-method}
\alias{c,machineProcessor-method}
\alias{c,mediumFormat-method}
\alias{c,metadataProvider-method}
\alias{c,methodStep-method}
\alias{c,missingValueCode-method}
\alias{c,onlineUrl-method}
\alias{c,operatingSystem-method}
\alias{c,orderedlist-method}
\alias{c,organizationName-method}
\alias{c,originator-method}
\alias{c,otherEntity-method}
\alias{c,para-method}
\alias{c,parameter-method}
\alias{c,parameterDefinition-method}
\alias{c,pattern-method}
\alias{c,performer-method}
\alias{c,permission-method}
\alias{c,personnel-method}
\alias{c,phone-method}
\alias{c,physical-method}
\alias{c,physicalLineDelimiter-method}
\alias{c,positionName-method}
\alias{c,principal-method}
\alias{c,proceduralStep-method}
\alias{c,programmingLanguage-method}
\alias{c,protocol-method}
\alias{c,publicationPlace-method}
\alias{c,qualityControl-method}
\alias{c,quantitativeAccuracyReport-method}
\alias{c,quantitativeAttributeAccuracyAssessment-method}
\alias{c,quoteCharacter-method}
\alias{c,recipient-method}
\alias{c,recordDelimiter-method}
\alias{c,referencedEntityId-method}
\alias{c,relatedProject-method}
\alias{c,role-method}
\alias{c,salutation-method}
\alias{c,sampling-method}
\alias{c,section-method}
\alias{c,singleDateTime-method}
\alias{c,software-method}
\alias{c,spatialRaster-method}
\alias{c,spatialVector-method}
\alias{c,storageType-method}
\alias{c,storedProcedure-method}
\alias{c,subStep-method}
\alias{c,subscript-method}
\alias{c,superscript-method}
\alias{c,taxonomicClassification-method}
\alias{c,taxonomicCoverage-method}
\alias{c,temporalCoverage-method}
\alias{c,textDelimited-method}
\alias{c,textDomain-method}
\alias{c,textFixed-method}
\alias{c,timeScaleCitation-method}
\alias{c,title-method}
\alias{c,ulink-method}
\alias{c,userId-method}
\alias{c,value-method}
\alias{c,view-method}
\alias{c,vouchers-method}
\alias{c,dimension-method}
\alias{c,unit-method}
\alias{c,unitType-method}

\usage{
\S4method{c}{section}(x, ..., recursive = FALSE)

\S4method{c}{para}(x, ..., recursive = FALSE)
\S4method{c}{value}(x, ..., recursive = FALSE)
\S4method{c}{itemizedlist}(x, ..., recursive = FALSE)
\S4method{c}{orderedlist}(x, ..., recursive = FALSE)
\S4method{c}{emphasis}(x, ..., recursive = FALSE)
\S4method{c}{subscript}(x, ..., recursive = FALSE)
\S4method{c}{superscript}(x, ..., recursive = FALSE)
\S4method{c}{literalLayout}(x, ..., recursive = FALSE)
\S4method{c}{citetitle}(x, ..., recursive = FALSE)
\S4method{c}{ulink}(x, ..., recursive = FALSE)
\S4method{c}{listitem}(x, ..., recursive = FALSE)
\S4method{c}{individualName}(x, ..., recursive = FALSE)
\S4method{c}{organizationName}(x, ..., recursive = FALSE)
\S4method{c}{positionName}(x, ..., recursive = FALSE)
\S4method{c}{address}(x, ..., recursive = FALSE)
\S4method{c}{phone}(x, ..., recursive = FALSE)
\S4method{c}{electronicMailAddress}(x, ..., recursive = FALSE)
\S4method{c}{onlineUrl}(x, ..., recursive = FALSE)
\S4method{c}{userId}(x, ..., recursive = FALSE)
\S4method{c}{salutation}(x, ..., recursive = FALSE)
\S4method{c}{givenName}(x, ..., recursive = FALSE)
\S4method{c}{deliveryPoint}(x, ..., recursive = FALSE)
\S4method{c}{alternateIdentifier}(x, ..., recursive = FALSE)
\S4method{c}{title}(x, ..., recursive = FALSE)
\S4method{c}{creator}(x, ..., recursive = FALSE)
\S4method{c}{metadataProvider}(x, ..., recursive = FALSE)
\S4method{c}{associatedParty}(x, ..., recursive = FALSE)
\S4method{c}{keyword}(x, ..., recursive = FALSE)
\S4method{c}{keywordSet}(x, ..., recursive = FALSE)
\S4method{c}{additionalInfo}(x, ..., recursive = FALSE)
\S4method{c}{distribution}(x, ..., recursive = FALSE)
\S4method{c}{parameterDefinition}(x, ..., recursive = FALSE)
\S4method{c}{mediumFormat}(x, ..., recursive = FALSE)
\S4method{c}{parameter}(x, ..., recursive = FALSE)
\S4method{c}{altitudeResolution}(x, ..., recursive = FALSE)
\S4method{c}{depthResolution}(x, ..., recursive = FALSE)
\S4method{c}{horizCoordSysDef}(x, ..., recursive = FALSE)
\S4method{c}{allow}(x, ..., recursive = FALSE)
\S4method{c}{deny}(x, ..., recursive = FALSE)
\S4method{c}{principal}(x, ..., recursive = FALSE)
\S4method{c}{permission}(x, ..., recursive = FALSE)
\S4method{c}{attributeReference}(x, ..., recursive = FALSE)
\S4method{c}{contact}(x, ..., recursive = FALSE)
\S4method{c}{editor}(x, ..., recursive = FALSE)
\S4method{c}{institution}(x, ..., recursive = FALSE)
\S4method{c}{recipient}(x, ..., recursive = FALSE)
\S4method{c}{geographicCoverage}(x, ..., recursive = FALSE)
\S4method{c}{publicationPlace}(x, ..., recursive = FALSE)
\S4method{c}{performer}(x, ..., recursive = FALSE)
\S4method{c}{temporalCoverage}(x, ..., recursive = FALSE)
\S4method{c}{taxonomicCoverage}(x, ..., recursive = FALSE)
\S4method{c}{singleDateTime}(x, ..., recursive = FALSE)
\S4method{c}{timeScaleCitation}(x, ..., recursive = FALSE)
\S4method{c}{gRingPoint}(x, ..., recursive = FALSE)
\S4method{c}{datasetGPolygonExclusionGRing}(x, ..., recursive = FALSE)
\S4method{c}{datasetGPolygon}(x, ..., recursive = FALSE)
\S4method{c}{classificationSystem}(x, ..., recursive = FALSE)
\S4method{c}{identificationReference}(x, ..., recursive = FALSE)
\S4method{c}{identifierName}(x, ..., recursive = FALSE)
\S4method{c}{originator}(x, ..., recursive = FALSE)
\S4method{c}{vouchers}(x, ..., recursive = FALSE)
\S4method{c}{taxonomicClassification}(x, ..., recursive = FALSE)
\S4method{c}{commonName}(x, ..., recursive = FALSE)
\S4method{c}{authentication}(x, ..., recursive = FALSE)
\S4method{c}{compressionMethod}(x, ..., recursive = FALSE)
\S4method{c}{encodingMethod}(x, ..., recursive = FALSE)
\S4method{c}{recordDelimiter}(x, ..., recursive = FALSE)
\S4method{c}{physicalLineDelimiter}(x, ..., recursive = FALSE)
\S4method{c}{fieldDelimiter}(x, ..., recursive = FALSE)
\S4method{c}{quoteCharacter}(x, ..., recursive = FALSE)
\S4method{c}{literalCharacter}(x, ..., recursive = FALSE)
\S4method{c}{textFixed}(x, ..., recursive = FALSE)
\S4method{c}{textDelimited}(x, ..., recursive = FALSE)
\S4method{c}{role}(x, ..., recursive = FALSE)
\S4method{c}{personnel}(x, ..., recursive = FALSE)
\S4method{c}{descriptorValue}(x, ..., recursive = FALSE)
\S4method{c}{citation}(x, ..., recursive = FALSE)
\S4method{c}{descriptor}(x, ..., recursive = FALSE)
\S4method{c}{coverage}(x, ..., recursive = FALSE)
\S4method{c}{description}(x, ..., recursive = FALSE)
\S4method{c}{relatedProject}(x, ..., recursive = FALSE)
\S4method{c}{`eml:language`}(x, ..., recursive = FALSE)
\S4method{c}{operatingSystem}(x, ..., recursive = FALSE)
\S4method{c}{machineProcessor}(x, ..., recursive = FALSE)
\S4method{c}{programmingLanguage}(x, ..., recursive = FALSE)
\S4method{c}{implementation}(x, ..., recursive = FALSE)
\S4method{c}{licenseURL}(x, ..., recursive = FALSE)
\S4method{c}{license}(x, ..., recursive = FALSE)
\S4method{c}{proceduralStep}(x, ..., recursive = FALSE)
\S4method{c}{dataSource}(x, ..., recursive = FALSE)
\S4method{c}{methodStep}(x, ..., recursive = FALSE)
\S4method{c}{referencedEntityId}(x, ..., recursive = FALSE)
\S4method{c}{sampling}(x, ..., recursive = FALSE)
\S4method{c}{qualityControl}(x, ..., recursive = FALSE)
\S4method{c}{protocol}(x, ..., recursive = FALSE)
\S4method{c}{instrumentation}(x, ..., recursive = FALSE)
\S4method{c}{software}(x, ..., recursive = FALSE)
\S4method{c}{subStep}(x, ..., recursive = FALSE)
\S4method{c}{attribute}(x, ..., recursive = FALSE)
\S4method{c}{attributeLabel}(x, ..., recursive = FALSE)
\S4method{c}{storageType}(x, ..., recursive = FALSE)
\S4method{c}{missingValueCode}(x, ..., recursive = FALSE)
\S4method{c}{quantitativeAttributeAccuracyAssessment}(x, ...,
  recursive = FALSE)
\S4method{c}{codeDefinition}(x, ..., recursive = FALSE)
\S4method{c}{codesetURL}(x, ..., recursive = FALSE)
\S4method{c}{enumeratedDomain}(x, ..., recursive = FALSE)
\S4method{c}{pattern}(x, ..., recursive = FALSE)
\S4method{c}{textDomain}(x, ..., recursive = FALSE)
\S4method{c}{bounds}(x, ..., recursive = FALSE)
\S4method{c}{constraint}(x, ..., recursive = FALSE)
\S4method{c}{physical}(x, ..., recursive = FALSE)
\S4method{c}{geometry}(x, ..., recursive = FALSE)
\S4method{c}{quantitativeAccuracyReport}(x, ..., recursive = FALSE)
\S4method{c}{cornerPoint}(x, ..., recursive = FALSE)
\S4method{c}{controlPoint}(x, ..., recursive = FALSE)
\S4method{c}{bandDescription}(x, ..., recursive = FALSE)
\S4method{c}{dataTable}(x, ..., recursive = FALSE)
\S4method{c}{spatialRaster}(x, ..., recursive = FALSE)
\S4method{c}{spatialVector}(x, ..., recursive = FALSE)
\S4method{c}{storedProcedure}(x, ..., recursive = FALSE)
\S4method{c}{view}(x, ..., recursive = FALSE)
\S4method{c}{otherEntity}(x, ..., recursive = FALSE)
\S4method{c}{changeHistory}(x, ..., recursive = FALSE)
\S4method{c}{describes}(x, ..., recursive = FALSE)
\S4method{c}{additionalMetadata}(x, ..., recursive = FALSE)
\S4method{c}{dimension}(x, ..., recursive = FALSE)
\S4method{c}{unit}(x, ..., recursive = FALSE)
\S4method{c}{unitType}(x, ..., recursive = FALSE)

}
\arguments{
\item{x, ...}{otherEntities to concatenate}

\item{recursive}{Needed for compatibility with generic, otherwise ignored}
}
\description{
concatenate
}

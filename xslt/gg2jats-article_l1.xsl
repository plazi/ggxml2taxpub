<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs mods"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:tp="http://www.plazi.org/taxpub" version="1.1">

    <xsl:include href="gg2tp_l1.xsl" />

    <!--<xsl:strip-space elements="*"/>-->

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="document">
        <article>
            <front><xsl:call-template name="article-metadata"/></front>
            <body>
            <xsl:apply-templates select="* except mods:mods"/>
            </body>
        </article>
    </xsl:template>

    <xsl:template match="mods:mods">
        <journal-meta>
            <journal-id><xsl:value-of select="mods:identifier[@type = 'DOI']"/></journal-id>
            <issn><xsl:value-of select="mods:identifier[@type = 'ISSN']"/></issn>
        </journal-meta>
        <article-meta>
            <title-group>
                <article-title><xsl:value-of select="mods:titleInfo/mods:title"/></article-title>
            </title-group>
            <pub-date>
                <year><xsl:value-of select="mods:relatedItem[@type = 'host']/mods:part/mods:date"/></year>
            </pub-date>
        </article-meta>
    </xsl:template>

    <xsl:template match="subSection">

            <sec>
                <xsl:attribute name="sec-type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:apply-templates mode="main"/>
            </sec>
    </xsl:template>

    <xsl:template match="paragraph" mode="main">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="paragraph[descendant::heading][not(preceding-sibling::paragraph)]" mode="main">
        <title>
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="subSection[ancestor::paragraph]">
        <xsl:apply-templates select="child::*"/>
    </xsl:template>
    
    <!-- SKIPPED ELEMENTS --> 
    
    <!-- SKIPPING figureWrap everywhere -->
    <xsl:template match="figureWrap">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="figureWrap" mode="main">
    <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="figureCitation">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="figureLink">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="bibRefCitation" mode="main">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="taxonomicNameLabel[not(ancestor::subSubSection[@type = 'nomenclature'])]">
        <named-content content-type="taxonStatus">
            <xsl:apply-templates/>
        </named-content>
    </xsl:template>
    
    <xsl:template match="table" mode="main">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>

    <xsl:template match="treatment">
        <xsl:apply-templates />
    </xsl:template>
    
    
    <xsl:template name="article-metadata">
        <journal-meta>
            <journal-id journal-id-type="other">N/A</journal-id>
            <journal-title-group>
                <journal-title><xsl:value-of select="mods:mods/mods:relatedItem[@type = 'host']/mods:titleInfo/mods:title"/></journal-title>
            </journal-title-group>
            <issn> 
                <xsl:choose>
                    <xsl:when test="mods:identifier[@type = 'ISSN']"><xsl:value-of select="."/></xsl:when>
                    <xsl:otherwise>N/A</xsl:otherwise>
                </xsl:choose>
            </issn>
        </journal-meta>
        <article-meta>
<!--            <mixed-citation>
                <named-content content-type="treatment-title"><xsl:value-of select="//document/@docTitle"/></named-content>
                <uri content-type="zenodo-doi"><xsl:value-of select="//document/@ID-DOI"/></uri>
                <uri content-type="treatment-bank-uri"><xsl:value-of select="concat('http://treatment.plazi.org/id/', /document/@docId)"/></uri>
                <article-title><xsl:value-of select="//document/@masterDocTitle"/></article-title>
                <uri content-type="publication-doi"><xsl:value-of select="//document/@docSource"/></uri>
            </mixed-citation> -->          
            <title-group>
                <article-title><xsl:value-of select="/document/@docTitle"/></article-title>
            </title-group>
            <pub-date date-type="pub">
                <xsl:choose>
                    <xsl:when test="mods:mods/mods:relatedItem[@type = 'host']/mods:part/mods:detail[@type = 'pubDate']">
                        <xsl:apply-templates select="mods:mods/mods:relatedItem[@type = 'host']/mods:part/mods:detail[@type = 'pubDate'][1]/mods:number"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <year><xsl:value-of select="mods:mods/mods:relatedItem[@type = 'host']/mods:part/mods:date"/></year>
                    </xsl:otherwise>
                </xsl:choose>
                
            </pub-date>

        </article-meta>
    </xsl:template>
    
    <xsl:template match="mods:number[parent::mods:detail[@type = 'pubDate']]">
        <day><xsl:value-of select="substring(.,9,2)"/></day>
        <month><xsl:value-of select="substring(.,6,2)"/></month>
        <year><xsl:value-of select="substring(.,1,4)"/></year>
    </xsl:template>

    <xsl:template match="*">
        <xsl:message>
            <xsl:value-of select="local-name()"/>
            <xsl:text>NO TEMPLATE</xsl:text>
        </xsl:message>
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>

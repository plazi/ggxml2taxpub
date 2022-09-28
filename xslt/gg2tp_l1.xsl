<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tp="http://www.plazi.org/taxpub">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//treatment"/>
    </xsl:template>
    <xsl:template match="//treatment">
        <tp:taxon-treatment>
            <xsl:call-template name="treatment-metadata"/>
            <xsl:apply-templates select="//subSubSection[@type = 'nomenclature']"/>
            <xsl:apply-templates select="//subSubSection[not(@type = 'nomenclature')]"/>
        </tp:taxon-treatment>
    </xsl:template>

    <xsl:template match="subSubSection[@type = 'nomenclature']">
        <tp:nomenclature>
            <xsl:apply-templates select=".//taxonomicName"/>
            <!-- need to restrict this to nomenclature, as taxon-status is allowed only there -->
            <xsl:if test=".//taxonomicNameLabel">
                <tp:taxon-status>
                    <xsl:apply-templates select=".//taxonomicNameLabel"/>
                </tp:taxon-status>
            </xsl:if>
        </tp:nomenclature>
    </xsl:template>

    <xsl:template match="taxonomicName">
        <tp:taxon-name>
            <xsl:apply-templates/>
        </tp:taxon-name>
    </xsl:template>

    <xsl:template match="subSubSection">
        <tp:treatment-sec sec-type="{@type}">
            <xsl:apply-templates/>
        </tp:treatment-sec>
    </xsl:template>

    <xsl:template match="caption[@inLine]">
        <!-- loop through in-line captions, as they are regular text -->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="caption">
        <!-- ignore all other captions altogether for now -->
    </xsl:template>

    <xsl:template match="paragraph">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template name="treatment-metadata">
        <tp:treatment-meta>
            <mixed-citation>
                <named-content content-type="treatment-title"><xsl:value-of select="//document/@docTitle"/></named-content>
                <uri content-type="zenodo-doi"><xsl:value-of select="//document/@ID-DOI"/></uri>
                <uri content-type="treatment-bank-uri"><xsl:value-of select="concat('http://treatment.plazi.org/id/', /document/@docId)"/></uri>
                <article-title><xsl:value-of select="//document/@masterDocTitle"/></article-title>
                <uri content-type="publication-doi"><xsl:value-of select="//document/@docSource"/></uri>
            </mixed-citation>
        </tp:treatment-meta>
    </xsl:template>
    
    <xsl:template match="materialsCitation">
        <tp:material-citation>
            <xsl:apply-templates/>
        </tp:material-citation>
    </xsl:template>
    
    <xsl:template match="taxonomicName">
        <tp:taxon-name>
            <xsl:apply-templates/>
        </tp:taxon-name>
    </xsl:template>
    
    

    <!--    
     <xsl:template match="text()">
        <xsl:value-of select="translate(.,' &#9;&#10;', ' ')"/>
    </xsl:template>
-->
</xsl:stylesheet>

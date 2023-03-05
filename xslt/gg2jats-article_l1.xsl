<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs mods"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:tp="http://www.plazi.org/taxpub" version="1.1">

    <xsl:include href="gg2tp_l1.xsl" />

    <xsl:strip-space elements="*"/>

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="document">
        <article>
            <xsl:apply-templates select="mods:mods"/>
            <body>
            <xsl:apply-templates/>
            </body>
        </article>
    </xsl:template>

    <xsl:template match="mods:mods"/>

    <xsl:template match="subSection">

            <sec>
                <xsl:attribute name="sec-type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:apply-templates mode="main"/>
            </sec>
    </xsl:template>

    <xsl:template match="paragraph" mode="main">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="paragraph[descendant::heading][not(preceding-sibling::paragraph)]" mode="main">
        <title>
            <xsl:apply-templates/>
        </title>
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

    <xsl:template match="treatment">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="*">
        <xsl:message>
            <xsl:value-of select="local-name()"/>
            <xsl:text>NO TEMPLATE</xsl:text>
        </xsl:message>
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs mods"
    xmlns:mods="http://www.loc.gov/mods/v3" version="1.1">
    
    <xsl:import href="gg2tp_l1.xsl"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="document">
        <article>
            <xsl:apply-templates/>
        </article>
    </xsl:template>

    <xsl:template match="mods:mods"/>

    <xsl:template match="subSection">
        <sec>
            <xsl:attribute name="type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </sec>
    </xsl:template>

    <xsl:template match="paragraph">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="treatment">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:message><xsl:value-of select="local-name()"/><xsl:text>NO TEMPLATE</xsl:text></xsl:message>
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>

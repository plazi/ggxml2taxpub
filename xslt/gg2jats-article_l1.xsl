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
            <contrib-group>
                <xsl:apply-templates select="mods:name[mods:role/mods:roleTerm = 'Author']"/>
            </contrib-group>
            <pub-date>
                <year><xsl:value-of select="mods:relatedItem[@type = 'host']/mods:part/mods:date"/></year>
            </pub-date>
        </article-meta>
        
    </xsl:template>
    
    <xsl:template match="mods:name[mods:role/mods:roleTerm = 'Author']">
        <contrib contrib-type="author">
            <name-alternatives><string-name><xsl:apply-templates select="mods:namePart"/></string-name></name-alternatives>
        </contrib>
    </xsl:template>

    <xsl:template match="subSection">

            <sec>
                <xsl:attribute name="sec-type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="descendant::paragraph[descendant::heading]">
                        <xsl:apply-templates select="descendant::paragraph[descendant::heading][1]" mode="main"/>
                    </xsl:when>
                    <xsl:otherwise><title>N/A</title></xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="* except descendant::paragraph[descendant::heading][1]" mode="main"/>
            </sec>
    </xsl:template>
   

<!-- Reference Group sections -->

    <xsl:template match="subSection[@type = 'reference_group'][descendant::bibRef]">
        <sec sec-type="reference_group">
            <xsl:choose>
                <xsl:when test="descendant::paragraph[descendant::heading]">
                    <xsl:apply-templates select="descendant::paragraph[descendant::heading][1]" mode="main"/>
                </xsl:when>
                <xsl:otherwise><title>N/A</title></xsl:otherwise>
            </xsl:choose>
            <ref-list>
                <xsl:apply-templates select="paragraph[descendant::bibRef]" mode="main"/>
            </ref-list>
        </sec>
    </xsl:template>


    <xsl:template match="paragraph" mode="main">
        <p><xsl:apply-templates mode="main"/></p>
    </xsl:template>
    
    <xsl:template match="paragraph[descendant::heading][not(preceding-sibling::paragraph[descendant::heading])]" mode="main">
        <title>
            <xsl:apply-templates mode="main"/>
        </title>
    </xsl:template>
    
    <xsl:template match="paragraph[ancestor::paragraph]" mode="main">
        <xsl:apply-templates mode="main"/>
    </xsl:template>
    
    <xsl:template match="subSection[ancestor::paragraph]">
        <xsl:apply-templates select="child::*"/>
    </xsl:template>
    
    <xsl:template match="paragraph[not(ancestor::subSection) and not(ancestor::paragraph)]" mode="main">
        <sec sec-type="inferred">
            <title>Orphanage</title>
            <p><xsl:apply-templates mode="main"></xsl:apply-templates></p>
        </sec>
    </xsl:template>
    
    <xsl:template match="paragraph[not(ancestor::subSection) and not(ancestor::treatment) and not(ancestor::paragraph)]">
        <sec sec-type="inferred">
            <title>Orphanage</title>
            <p><xsl:apply-templates mode="main"/></p>
        </sec>
    </xsl:template>
    
    <!-- SKIPPED ELEMENTS --> 
    
    <!-- SKIPPING caption in both stylesheets -->
    <xsl:template match="caption">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="caption" mode="main">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <!-- SKIPPING figureWrap in both stylesheets -->
    
    <xsl:template match="figureWrap">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="figureWrap" mode="main">
    <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <!-- SKIPPING footnote in both stylesheets -->
    
    <xsl:template match="footnote" mode="main">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>
    
    <xsl:template match="footnote">
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
    
    
    
    <xsl:template match="table" mode="main">
        <xsl:message><xsl:text>SKIPPING</xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>

    <xsl:template match="treatment">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="docTitle" mode="main">
        <xsl:choose>
            <xsl:when test="parent::subSection"/>
            <xsl:otherwise><xsl:apply-templates mode="main"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="taxonomicName[not(ancestor::treatment)]" mode="main">
        <tp:taxon-name>
            <xsl:apply-templates select="descendant-or-self::*/text()"/>
        </tp:taxon-name>
    </xsl:template>
    
    
    <xsl:template match="taxonomicNameLabel[not(ancestor::subSubSection[@type = 'nomenclature'])]">
        <named-content content-type="taxonStatus">
            <xsl:apply-templates/>
        </named-content>
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
            <xsl:apply-templates select="mods:mods/mods:identifier[@type ='DOI']" mode="article"/>
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
            <contrib-group>
                <xsl:apply-templates select="mods:mods/mods:name[mods:role/mods:roleTerm = 'Author']"/>
            </contrib-group>
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
            <kwd-group>
                <xsl:apply-templates select="//taxonomicName" mode="article-kwd"/>
            </kwd-group>
        </article-meta>  
    </xsl:template>
    
    <xsl:template match="mods:number[parent::mods:detail[@type = 'pubDate']]">
        <day><xsl:value-of select="substring(.,9,2)"/></day>
        <month><xsl:value-of select="substring(.,6,2)"/></month>
        <year><xsl:value-of select="substring(.,1,4)"/></year>
    </xsl:template>
    
    <xsl:template match="mods:identifier[@type ='DOI']" mode="article">
        <article-id pub-id-type="doi"><xsl:value-of select="."/></article-id>
    </xsl:template>
    
    <!-- bibRefs -->

    
    <xsl:template match="paragraph[ancestor::subSection[@type = 'reference_group']][descendant::bibRef]" mode="main">
                <ref>
                    <mixed-citation><xsl:value-of select="descendant::bibRef"/></mixed-citation>
                </ref>
        
    </xsl:template>

    <xsl:template match="*">
        <xsl:message>
            <xsl:value-of select="local-name()"/>
            <xsl:text>NO TEMPLATE</xsl:text>
        </xsl:message>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="*" mode="main">
        <xsl:message>
            <xsl:value-of select="local-name()"/>
            <xsl:text>NO TEMPLATE (MAIN MODE)</xsl:text>
        </xsl:message>
        <xsl:apply-templates mode="main"/>
    </xsl:template>
    
    <xsl:template match="taxonomicName" mode="article-kwd">
        <xsl:element name="kwd">
            <xsl:attribute name="content-type">
                <xsl:choose>
                    <xsl:when test="ancestor::subSubSection[@type = 'nomenclature']">
                        <xsl:text>nominate-taxon</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>mentioned-taxon</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <tp:taxon-name>
                <xsl:value-of select="."/>
            </tp:taxon-name>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>

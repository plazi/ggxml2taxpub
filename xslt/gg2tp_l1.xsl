<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tp="http://www.plazi.org/taxpub" xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="mods">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//treatment"/>
    </xsl:template>
    <xsl:template match="//treatment">
        <tp:taxon-treatment>
            <xsl:call-template name="treatment-metadata"/>
            <xsl:apply-templates select=".//subSubSection[@type = 'nomenclature']"/>
            <xsl:apply-templates select=".//subSubSection[not(@type = 'nomenclature')]"/>
        </tp:taxon-treatment>
    </xsl:template>

    <xsl:template match="subSubSection[@type = 'nomenclature']">
        <tp:mixed-nomenclature>
            <xsl:apply-templates/>
        </tp:mixed-nomenclature>
    </xsl:template>

    <xsl:template match="taxonomicName">
        <tp:taxon-name>
            <xsl:apply-templates/>
        </tp:taxon-name>
    </xsl:template>
    
    <xsl:template match="taxonomicNameLabel">
        <tp:taxon-status>
                    <xsl:apply-templates select="descendant-or-self::*/text()"/>
        </tp:taxon-status>
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
    
<xsl:template match="paragraph[ancestor::subSubSection[@type = 'nomenclature']]">
            <xsl:apply-templates/>
</xsl:template>
    
    <xsl:template name="treatment-metadata">
        <tp:treatment-meta>
            <kwd-group>
                <xsl:apply-templates select="//treatment//taxonomicName" mode="kwd"/>
            </kwd-group>
            <mixed-citation>
                <named-content content-type="treatment-title">
                    <xsl:value-of select="//document/@docTitle"/>
                </named-content>
                <uri content-type="zenodo-doi">
                    <xsl:value-of select="//document/@ID-DOI"/>
                </uri>
                <uri content-type="treatment-bank-uri">
                    <xsl:value-of
                        select="concat('http://treatment.plazi.org/id/', /document/@docId)"/>
                </uri>
                <article-title>
                    <xsl:value-of select="//document/@masterDocTitle"/>
                </article-title>
                <xsl:apply-templates select="//document/mods:mods/mods:identifier[@type = 'DOI']"/>
                <xsl:apply-templates select="//document/mods:mods/mods:identifier[@type = 'ISSN']"/>
                <xsl:apply-templates select="//document/mods:mods/mods:relatedItem[@type = 'host']"
                />
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
            <xsl:apply-templates select="descendant-or-self::*/text()"/>
        </tp:taxon-name>
    </xsl:template>

    <xsl:template match="taxonomicName" mode="kwd">
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

    <!-- article metadata -->

    <xsl:template match="mods:identifier[@type = 'DOI']">
        <pub-id pub-id-type="doi">
            <xsl:value-of select="./text()"/>
        </pub-id>
    </xsl:template>

    <!-- journal metadata -->

    <xsl:template match="mods:identifier[@type = 'ISSN']">
        <issn>
            <xsl:value-of select="./text()"/>
        </issn>
    </xsl:template>

    <xsl:template match="mods:relatedItem[@type = 'host']">
        <source>
            <xsl:apply-templates select="mods:titleInfo/mods:title"/>
        </source>
    </xsl:template>



    <!--    
     <xsl:template match="text()">
        <xsl:value-of select="translate(.,' &#9;&#10;', ' ')"/>
    </xsl:template>
-->

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:tp="http://www.plazi.org/taxpub" xmlns:pm="http://www.crossref.org/schema/4.3.6" exclude-result-prefixes="xs xlink mods pm" version="2.0">
    <!-- 
    -//NLM//DTD JATS (Z39.96) Journal Publishing DTD with OASIS Tables with MathML3 v1.1 20151215//EN
    -->
        
    <xsl:import href="strip.xsl"/>
    <xsl:param name="commentsOn">no</xsl:param>
    <xsl:param name="strippedSource"><xsl:call-template name="strip"/></xsl:param>
    
    <xsl:output encoding="UTF-8"
        doctype-public="-//TaxPub//DTD Taxonomic Treatment Publishing DTD v1.0 20180101//EN"
        doctype-system="https://raw.githubusercontent.com/plazi/TaxPub/TaxPubJATS-blue/tax-treatment-NS0-v1.dtd" method="xml" exclude-result-prefixes="#all"/>

    
    <xsl:template match="/">
        <xsl:apply-templates select="$strippedSource/document"/>
    </xsl:template>
    
    <xsl:template match="document"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = /</xsl:comment></xsl:if>
            <xsl:apply-templates select="treatment"/>
    </xsl:template>
    

    <xsl:template match="subSection"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = subSection</xsl:comment></xsl:if>
        <sec>
           <xsl:apply-templates/>
        </sec>
    </xsl:template>
    
    <xsl:template match="heading"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = heading</xsl:comment></xsl:if>
        <title>
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>
   
    <xsl:template match="paragraph"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph</xsl:comment></xsl:if>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="subSection[@type = 'reference_group']"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = subSection[@type = 'reference_group']</xsl:comment></xsl:if>
        <ref-list>
            <xsl:apply-templates select="heading"/>
            <xsl:apply-templates select="paragraph[bibRef] | bibRef"/>
        </ref-list>
    </xsl:template>

    <xsl:template match="heading"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = heading</xsl:comment></xsl:if>
        <title>
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>
    
    

    <xsl:template match="paragraph[bibRef]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph[bibRef]</xsl:comment></xsl:if>
        <xsl:apply-templates select="bibRef"/>
    </xsl:template>

    <xsl:template match="paragraph[descendant::heading]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph[descendant::heading]</xsl:comment></xsl:if>
        <xsl:apply-templates select="descendant::heading"/>
    </xsl:template>
    
    <xsl:template match="paragraph[descendant::heading][preceding-sibling::paragraph[descendant::heading]]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph[descendant::heading][preceding-sibling::paragraph[descendant::heading]]]</xsl:comment></xsl:if>
        <p><bold><xsl:value-of select="descendant::heading"/></bold></p>
    </xsl:template>
    
    <xsl:template match="paragraph[tr]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph[tr]</xsl:comment></xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    

    
    <xsl:template match="paragraph[subSection[@type = 'keywords']]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph[subSection[@type = 'keywords']]</xsl:comment></xsl:if>
        <keywords><xsl:apply-templates/></keywords>
    </xsl:template>
    
    

    <xsl:template match="bibRef"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = bibRef</xsl:comment></xsl:if>
        <xsl:variable name="ref-id" select="@refId"/>
        <ref id="{$ref-id}">
            <mixed-citation>
                <xsl:apply-templates/>
            </mixed-citation>
        </ref>
    </xsl:template>


<!-- bibref subelements -->
    
    <xsl:template match="bibRef/*">
        <!--
            <xsl:message><xsl:text>copying bibRef child: </xsl:text><xsl:value-of select="local-name()"/></xsl:message>
        <xsl:copy-of select="."/>
        -->
        <xsl:message><xsl:text>Skipping bibRef child: </xsl:text><xsl:value-of select="local-name()"/></xsl:message>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="bibRef/paragraph">
        <xsl:apply-templates/>
    </xsl:template>
    
    

    <xsl:template match="bibRef//year">
        <year><xsl:apply-templates/></year>
    </xsl:template>



    <xsl:template match="bibRef//author">
        <string-name><xsl:apply-templates/></string-name>
    </xsl:template>
    
    
    <xsl:template match="bibRef//title">
        <article-title><xsl:apply-templates/></article-title>
    </xsl:template>
    
    <xsl:template match="bibRef//title/*">
        <italic><xsl:apply-templates/></italic>
    </xsl:template>    
    
    
    
    <xsl:template match="bibRef//journalOrPublisher">
        <source><xsl:apply-templates/></source>
    </xsl:template>
    
    <xsl:template match="bibRef/part[1]">
        <volume><xsl:apply-templates/></volume>
    </xsl:template>
    
    <xsl:template match="bibRef/part[2]">
        <issue><xsl:apply-templates/></issue>
    </xsl:template>
    
    <!-- at least in 401 hyphen used in pagination spans is U+2013 "en dash" U *not* U+002D the keyboard character "hyphen/minus' -->    

    <xsl:template match="bibRef/pagination[not(contains(., '–'))]">
        <fpage><xsl:value-of select="."/></fpage>        
    </xsl:template>

    <xsl:template match="bibRef/pagination[contains(., '–')]">
        <fpage><xsl:value-of select="substring-before(.,'–')"/></fpage>
        <xsl:text>–</xsl:text>
        <lpage><xsl:value-of select="substring-after(.,'–')"/></lpage>
    </xsl:template>
    
    <xsl:template match="bibRef/DOI">
        <object-id object-id-type="doi"><xsl:value-of select="."/></object-id>
    </xsl:template>

    <xsl:template match="bibRef/volumeTitle | bibRef/editor">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="parseIsoDate">
        <xsl:variable name="isoDate" select="/document/@mods:pubDate"/>
        <day>
            <xsl:value-of select="tokenize($isoDate, '-')[3]"/>
        </day>
        <month>
            <xsl:value-of select="tokenize($isoDate, '-')[2]"/>
        </month>
        <year>
            <xsl:value-of select="tokenize($isoDate, '-')[1]"/>
        </year>
    </xsl:template>

    <xsl:template match="bibRefCitation"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = bibRefCitation</xsl:comment></xsl:if>
        <xsl:variable name="refId" select="@refId"/>
        <xref>
            <xsl:choose>
                <xsl:when test="normalize-space($refId)">
                    <xsl:attribute name="rid" select="$refId"/>
                </xsl:when>
                <xsl:otherwise><xsl:message>WARNING: NO refID attribute in source bibRefCitation</xsl:message></xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </xref>
    </xsl:template>



    <xsl:template match="taxonomicNameLabel"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = taxonomicNameLabel</xsl:comment></xsl:if>
            <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="caption"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = caption</xsl:comment></xsl:if>
        <fig id="fig-{replace(normalize-space(@startId), '\p{P}', '-')}" fig-type="figure" position="float">
            <caption>
                <p>
                    <xsl:apply-templates/>
                </p>
            </caption>
            <graphic xlink:href="{@httpUri}"/>
        </fig>
    </xsl:template>
    
    <xsl:template match="caption[child::paragraph]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = caption[child::paragraph]</xsl:comment></xsl:if>
        <fig id="fig-{replace(normalize-space(@startId), '\p{P}', '-')}" fig-type="figure" position="float">
            <caption>
                    <xsl:apply-templates/>
            </caption>
            <graphic xlink:href="{@httpUri}"/>
        </fig>
    </xsl:template>

    <xsl:template match="figureCitation"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = figureCitation</xsl:comment></xsl:if>
        <xsl:variable name="refId">
            <xsl:value-of
                select="replace(normalize-space(@captionStartId), '\p{P}', '-')"/>
        </xsl:variable>
        <xref rid="fig-{$refId}">
            <xsl:apply-templates/>
        </xref>
    </xsl:template>
    
    <xsl:template match="tableCitation"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = tableCitation</xsl:comment></xsl:if>
        <xsl:variable name="refString" select="normalize-space(@captionTargetBox)"/>
        <xsl:variable name="refId">
            <xsl:value-of
                select="ancestor::document//table[normalize-space(@box) = $refString]/generate-id()"/>
        </xsl:variable>
        <xref>
            <xsl:apply-templates/>
        </xref>
    </xsl:template>

    <xsl:template match="table"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = table</xsl:comment></xsl:if>
        <table id="{generate-id()}">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="tr"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = tr</xsl:comment></xsl:if>
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <xsl:template match="td"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = td</xsl:comment></xsl:if>
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>

<xsl:template match="table/paragraph"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = table/paragraph</xsl:comment></xsl:if>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="td[heading]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = td[heading]</xsl:comment></xsl:if>
    <th><xsl:value-of select=".//*[normalize-space(.)]/text()/normalize-space()"/></th>
</xsl:template>
    

<!--
    <xsl:template match="*"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = *</xsl:comment></xsl:if>
        <xsl:message>
            <xsl:text>UNPROCESSED NODE: </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:message>
        <xsl:if test="$commentsOn = 'yes'"><xsl:comment>UNPROCESSED NODE: <xsl:value-of select="local-name()"/></xsl:comment></xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
-->
<!-- TAXPUB -->
    <xsl:template match="treatment"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = treatment</xsl:comment></xsl:if>
        <tp:taxon-treatment>
            <xsl:call-template name="treatment-metadata"/>
            <xsl:apply-templates/>
            <xsl:call-template name="references_sec"/>
        </tp:taxon-treatment>
    </xsl:template>
    

    
    <xsl:template match="subSubSection[@type = 'nomenclature']">
        <xsl:if test="$commentsOn = 'yes'"><xsl:comment>subSubSection[@type = 'nomenclature']</xsl:comment></xsl:if>
        <tp:nomenclature>
           <tp:taxon-name><xsl:value-of select="normalize-space(descendant::heading[1])"/>
               <object-id><xsl:value-of select="normalize-space(descendant::heading[2]/paragraph[1])"/></object-id></tp:taxon-name>
            <xref><xsl:value-of select="normalize-space(descendant::heading[2]//subSubSection)"/></xref>
        </tp:nomenclature>
    </xsl:template>
    
    <xsl:template match="paragraph[child::treatmentCitationGroup]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="treatmentCitationGroup">
        <xsl:if test="$commentsOn = 'yes'"><xsl:comment>treatment-citation-group</xsl:comment></xsl:if>
        <tp:nomenclature-citation-list>
            <xsl:apply-templates/>
        </tp:nomenclature-citation-list>
    </xsl:template>
    
    <xsl:template match="paragraph[child::treatmentCitation]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="bibRefCitation[child::treatmentCitation]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="treatmentCitation">
        <xsl:if test="$commentsOn = 'yes'"><xsl:comment>treatment-citation</xsl:comment></xsl:if>
        <tp:nomenclature-citation>
            <xsl:apply-templates/>
        </tp:nomenclature-citation>
    </xsl:template>
    
    <xsl:template match="materials-examined"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = materials-examined</xsl:comment></xsl:if>
        <tp:treatment-sec sec-type="materials-examined">
            <xsl:apply-templates/>
        </tp:treatment-sec>
    </xsl:template>
    
    <xsl:template match="materialsCitation"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = materialsCitation</xsl:comment></xsl:if>
        <tp:material-citation>
            <xsl:apply-templates/>
        </tp:material-citation>
    </xsl:template>
    
    <xsl:template match="materialsCitation//*[not(self::* = paragraph)]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = materialsCitation//*[not(self::* = paragraph)]</xsl:comment></xsl:if>
        <named-content>
            <xsl:attribute name="content-type">
                <xsl:call-template name="named-content-type"><xsl:with-param name="local-name" select="local-name()"></xsl:with-param></xsl:call-template>
            </xsl:attribute>
            <xsl:apply-templates/>
        </named-content>
    </xsl:template>
    
    <xsl:template name="named-content-type">
        <xsl:param name="local-name"/>
        <xsl:value-of select="$local-name"/>
    </xsl:template>
    
    <xsl:template match="subSubSection[ancestor::treatment][not(@type = 'nomenclature')]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = subSubSection[ancestor::treatment]</xsl:comment></xsl:if>
        <tp:treatment-sec sec-type="{@type}">
            <xsl:apply-templates/>
        </tp:treatment-sec>
    </xsl:template>
    
    <xsl:template match="paragraph[ancestor::materialsCitation]"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = paragraph[ancestor::materialsCitation]</xsl:comment></xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="taxonomicName"><xsl:if test="$commentsOn = 'yes'"><xsl:comment>template match = taxonomicName</xsl:comment></xsl:if>

        <tp:taxon-name>
<!--
Include GG normalized attributes for 2nd pass
             <gg:taxonomicName>
                <xsl:for-each select="@*">
                    <xsl:copy/>
                </xsl:for-each>
            </gg:taxonomicName>
-->
            <xsl:value-of select="normalize-space(.)"/>
        </tp:taxon-name>

    </xsl:template>
    
   <xsl:template match="superScript">
       <sup><xsl:apply-templates/></sup>
   </xsl:template>
    
    <xsl:template name="treatment-metadata">
        <tp:treatment-meta>
            <mixed-citation><xsl:value-of select="/document/@docAuthor"/><xsl:text>&#160;</xsl:text><xsl:value-of select="/document/@docTitle"/></mixed-citation>
        </tp:treatment-meta>
    </xsl:template>
    
    <xsl:template match="bibRef">
                <ref>
                    <mixed-citation><xsl:apply-templates/></mixed-citation>
                </ref>
    </xsl:template>
   
</xsl:stylesheet>

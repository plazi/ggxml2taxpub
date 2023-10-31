<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="treatment" id="tmt">
            <!-- nested treatments -->
            <sch:report test="descendant::treatment">Error: tmt01: A <sch:name/> must not have a descendant treatment.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="subSection" id="subsect">
            <!-- nested treatments -->
            <sch:report test="descendant::subSection">Error:subsect01:  A <sch:name/> must not have a descendant subSection.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="paragraph" id="para">
            <!-- nested treatments -->
            <sch:report test="descendant::subSection">Error: para01: A <sch:name/> must not have a descendant subSection.</sch:report>
            <sch:assert test="ancestor::subSection | ancestor::subSubSection | ancestor::footnote | ancestor::caption">Error: para02: A <sch:name/> must have an ancestor subSection, subSubSection, footnote, or caption.</sch:assert>
            <sch:report test="ancestor::subSubSection and ancestor::subSection">Error: para03: A <sch:name/> must have an ancestor subSection or subSubSection.</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
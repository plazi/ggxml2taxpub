<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="treatment">
            <!-- nested treatments -->
            <sch:report test="descendant::treatment">Error: A treatment must not have a descendant treatment.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="subSection">
            <!-- nested treatments -->
            <sch:report test="descendant::subSection">Error: A subSection must not have a descendant subSection.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="paragraph">
            <!-- nested treatments -->
            <sch:report test="descendant::subSection">Error: A paragraph must not have a descendant subSection.</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
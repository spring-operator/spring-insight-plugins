<#ftl strip_whitespace=true>
<#import "/insight-1.0.ftl" as insight />

<@insight.group label="Eclipse Persistence Query">
    <@insight.entry name="Query name" value=operation.action />
    <@insight.entry name="Exception" value=operation.exception if=operation.exception?? />
</@insight.group>

<@insight.sourceCodeLocation location=operation.sourceCodeLocation />

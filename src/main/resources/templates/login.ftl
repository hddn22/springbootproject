<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert ${messageType}" role="alert">
            <#--        ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}-->
            Неверные данные
        </div>
    </#if>
    <#if message??>
        <div class="alert ${messageType}" role="alert">
            <#--        ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}-->
            ${message}
        </div>
    </#if>
    <@l.login "/login" false />

</@c.page>
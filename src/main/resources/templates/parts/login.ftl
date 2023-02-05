<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group">
            <label for="username">Имя пользователя </label>
            <input class="form-control ${(usernameError??)?string('is-invalid', '')}"
                   type="text" name="username" placeholder="Введите имя пользователя"
                   value="<#if user??>${user.username}</#if>"/>
            <#if usernameError??>
                <div class="invalid-feedback" >
                    ${usernameError}
                </div>
            </#if>
        </div>
        <div class="form-group">
            <label for="password">Пароль пользователя</label>
            <input class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   type="password" name="password" placeholder="Введите пароль"/>
            <#if passwordError??>
                <div class="invalid-feedback" >
                    ${passwordError}
                </div>
            </#if>
        </div>
        <#if isRegisterForm>
            <div class="form-group">
                <label for="password">Подтвердите пароль</label>
                <input class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       type="password" name="password2" placeholder="Повторите пароль"/>
                <#if password2Error??>
                    <div class="invalid-feedback" >
                        ${password2Error}
                    </div>
                </#if>
            </div>
        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input class="form-control ${(emailError??)?string('is-invalid', '')}"
                   type="email" name="email" placeholder="Введите электронную почту"
                   value="<#if user??>${user.email}</#if>"/>
            <#if emailError??>
                <div class="invalid-feedback" >
                    ${emailError}
                </div>
            </#if>
        </div>
            <div class="col-sm-6">
                <div class="g-recaptcha" data-sitekey="6LfpPjEkAAAAAFkm941kjtR9-hL2GDGSSmm0zDjd"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-success"><#if isRegisterForm>Зарегистрироваться<#else>Войти</#if></button>
        <#if !isRegisterForm>
            <a class="btn btn-outline-primary" href="/registration">Зарегистрироваться</a>
        </#if>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <button type="submit" class="btn btn-danger" type="submit">Выйти</button>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
</#macro>
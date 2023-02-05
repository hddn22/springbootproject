<#import "parts/common.ftl" as c>

<@c.page>
    <h5>${username}</h5>
    ${message?ifExists}
    <form method="post">

        <div class="form-group">
            <label for="password">Пароль пользователя</label>
            <input class="form-control" type="text" name="password" placeholder="Введите пароль"/>
        </div>
            <div class="form-group">
                <label for="email">Электронная почта</label>
                <input class="form-control" type="email" name="email" placeholder="Введите электронную почту" value="${email!''}"/>
            </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit" class="btn btn-success">Сохранить</button>
    </form>
</@c.page>
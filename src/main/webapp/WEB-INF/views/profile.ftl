<#import "parts/common.ftl" as c>
<@c.page "Profile">
    <div class="profile-main-block container">
        <div class="float-left profile-main-inf-l profile-main-inf col-3 min-width">
            <div class="profile-photo">
                <#if user??>
                    <#if user.getImg()??>
                        <img src="${context.getContextPath()}/img/${user.getImg().getFullName()}">
                    <#else>
                        <img src="https://www.cierpgaud.fr/wp-content/uploads/2018/07/avatar.jpg">
                    </#if>
                </#if>
            </div>


            <div class="profile-name">
                <span>
                    <#if user??>
                        ${user.firstName} ${user.lastName}
                    </#if>
                </span>
            </div>
            <#if isCurrentUser>
                <form action="${context.getContextPath()}/profileSettings">
                    <input type="submit" value="Edit" class="profile-edit-submit"/>
                </form>
            <#else>
                <form action="${context.getContextPath()}/subscribe/${userId}">
                    <input type="submit" value="Subscribe" class="profile-edit-submit"/>
                </form>
            </#if>
        </div>
        <div class="float-left profile-main-inf-r profile-main-inf col-8">
            <div class="row">
                <nav class="navbar navbar-expand navbar-light pl-0">
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="#">Overview</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Projects</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${context.getContextPath()}/profileSettings">Settings</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link add-link"
                                   href="${context.getContextPath()}/newProject">Add project</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
            <#if projects??>
                <#if projects?size==0>
                    <h3 style="color: #0770c3">Oops, user doesn't have any projects..</h3>
                <#else>
                    <#list projects as project>
                        <#if project_index % 2 == 0>
                            <div class="row">
                        </#if>
                        <div class="profile-project-card col-5">
                            <a href="${context.getContextPath()}/project/${project.id}">
                                <h3 class="profile-project-name">
                                    ${project.name}
                                </h3>
                            </a>
                            <span class="profile-project-about">
                                About this project
                            </span>
                        </div>
                        <div class="col-1"></div>
                        <#if project_index % 2 == 1>
                            </div>
                        </#if>
                    </#list>
                </#if>
            <#else>
                <button>
                    <a class="nav-link add-link" href="${context.getContextPath()}/newProject">Add project</a>
                </button>
            </#if>
        </div>
    </div>
</@c.page>
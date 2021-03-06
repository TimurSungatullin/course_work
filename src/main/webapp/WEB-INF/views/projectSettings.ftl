<#import "parts/projectTemplate.ftl" as p>
<@p.projectTemplate"Settings">
    <div class="container">
    <hr>
    <div class="row">
        <h4 class="ml-5">Update project:</h4>
        <div class="container ml-3">
            <form action="${context.getContextPath()}/project/settings/${project.id}" method="post">
                <div class="form-group">
                    <div class="col-md-6">
                        <label for="name">Name of project</label>
                        <input type="text" name="name" id="name" class="form-control" value="${project.name}"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-6">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description"
                                  name="description">${project.description}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-dark">Update</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="container" align="center">
            <#if user.githubToken??>
                <#if repos??>
                    <#if project.gitRepositoryName??>
                        <h3>Github</h3>
                        <h4><a href="${project.gitLink}">${project.gitRepositoryName}</a></h4>
                    <#else>
                        <label for="repos">Select repo for your project from your repos:
                        </label>
                        <form action="${context.getContextPath()}/project/weavingRepo" method="post">
                            <select name="repos" id="repos" required>
                                <#list repos as repo>
                                    <option value="${repo.name}">${repo.name}</option>
                                </#list>
                            </select>
                            <input type="hidden" name="projectId" value="${project.id}">
                            <button type="submit" class="btn btn-primary btn-dark">Select</button>
                        </form>
                    </#if>
                </#if>
            <#else>
                <div class="jumbotron col-md-8" align="center">
                    <h1 class="display-4">Connecting to GitHub</h1>
                    <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra
                        attention to featured content or information.</p>
                    <hr class="my-4">
                    <p>It uses utility classes for typography and spacing to space content out within the larger
                        container.</p>
                    <a class="btn btn-info btn-lg" role="button" href="${authLink}">Connect</a>
                </div>
            </#if>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="container">
            <p style="color: darkred;"><b>Delete this project? Please, NOOOOO</b></p>
            <form action="${context.getContextPath()}/project/delete/${project.id}" method="post">
                <button class="btn btn-outline-danger" type="submit">Delete</button>
            </form>
        </div>
    </div>
</@p.projectTemplate>
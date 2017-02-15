<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
        }

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {
            height: 450px
        }

        /* Set gray background color and 100% height */
        .sidenav {
            padding-top: 20px;
            background-color: #f1f1f1;
            height: 100%;
        }

        /* Set black background color, white text and some padding */
        footer {
            background-color: #555;
            color: white;
            padding: 15px;
        }

        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 767px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }

            .row.content {
                height: auto;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Logo</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="/secure/create.jsp">Create</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/secure/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <c:forEach items="${moviePage.iterator()}" var="aMovie">
            <div class="card col-sm-12 col-md-4">
                <h4 class="card-title"><c:out value="${aMovie.name}"/></h4>
                <img class="card-img-top" width="100" src="<c:out value="${aMovie.posterUrl}"/>" alt="Card image cap">
                <div class="card-block">
                    <p class="card-text"><c:out value="${aMovie.description}"/></p>
                    <p class="card-text">
                        <small class="text-muted"><c:out value="${aMovie.mpaaRating}"/></small>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="row">
        <div class="col-sm-4 col-xs-4" >
            <c:if test="${moviePage.hasPrevious()}">
                <div class="pull-left"><a href="/secure/movies?page=<c:out value="${moviePage.number - 1}"/>&size=<c:out value="${moviePage.size}"/>"> Previous
                    Page</a></div>
            </c:if>
        </div>

        <div class="col-sm-4 col-xs-4">
           Page <c:out value="${moviePage.number+1}"/> of <c:out value="${moviePage.totalPages}"/>, Total Records Found:<c:out value="${moviePage.totalElements}"/>
            <div>
                <form method="post" action="/secure/movies" id="sizeform">
                    Results Per Page:
                    <select name="size" onchange="sizeform.submit();">
                    <option value="2" <c:out value="${moviePage.size==2?'selected':''}"/> >
                        2
                    </option>
                        <option value="4" <c:out value="${moviePage.size==4?'selected':''}"/> >
                        4
                    </option>
                        <option value="8" <c:out value="${moviePage.size==8?'selected':''}"/> >
                        8
                    </option>
                </select>
                </form>
            </div>
        </div>


        <div class="col-sm-4 col-xs-4">

            <c:if test="${moviePage.hasNext()}">
                <div class="pull-right"><a href="/secure/movies?page=<c:out value="${moviePage.number + 1}"/>&size=<c:out value="${moviePage.size}"/> "> Next
                    Page</a></div>
            </c:if>
        </div>

    </div>
</div>
</div>


<footer class="container-fluid text-center">
    <p>Welcome To CJ's Web App</p>
</footer>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>ZenithMind</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        </head>

        <body>

            <%-- Don't show nav on login page usually, but kept simple here --%>
                <header class="main-header">
                    <div class="nav-container">
                        <a href="${pageContext.request.contextPath}/dashboard" class="logo">
                            <span>Zenith</span>Mind
                        </a>
                        <nav class="nav-links">
                            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                            <a href="${pageContext.request.contextPath}/modules">Modules</a>
                            <a href="${pageContext.request.contextPath}/mood">Mood</a>
                        </nav>
                    </div>
                </header>

                <main class="main-content">
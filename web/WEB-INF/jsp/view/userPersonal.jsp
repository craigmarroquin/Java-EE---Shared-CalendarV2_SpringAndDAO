<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.Calendar.Event" %>
<%@ page import="com.DAO.UserDao" %>
<%@ page import="org.springframework.context.ConfigurableApplicationContext" %>
<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext" %>
<%@ page import="com.DAO.EventDao" %>
<%@ page import="com.DAO.EventMapper" %>
<%@ page import="java.util.List" %>
<% String appContextFile = "AppContext.xml"; // Use the settings from this xml file %>
<% ConfigurableApplicationContext context = new ClassPathXmlApplicationContext("AppContext.xml"); %>


<html>
<head>
    <title>User Page</title>
    <link rel="stylesheet" type="text/css" href="styles/styles.css"/>
</head>
<body>


<h1>Welcome <%=session.getAttribute("first_name")%></h1>
<br/>
<br/>

<% // Display message if the user has no events
    EventDao eventDao = (EventDao) context.getBean("eventDao");
    System.out.println(session.getAttribute("username"));
    if (eventDao.eventsExists(session.getAttribute("username").toString()) == false) {%>
<h3>Not subscribed to any events!</h3>
<p><em>Create one or follow one from the Home page!</em>
<p></p>
<%
    } else {
        List<Event> events = eventDao.selectAllEvent(session.getAttribute("username").toString());
        for (Event e : events) {
            int eventId = e.getId();
            String eventName = e.getEventName();
            String eventDate = e.getEventDate();
            String eventDesc = e.getDescription();
            String eventAuthor = e.getEventAuthor();%>

Event Id: <%= eventId %> <br/>
Event: <%= eventName %> <br/>
Date: <%= eventDate %> <br/>
Description: <%= eventDesc %> <br/>
Creator: <%= eventAuthor %> <br/><br/>
<%
        }
    }
%>

<br />


<br/>

<form action="event?action=create" method="POST">
    <input type="submit" value="Create Event"><br/>
</form>
<form action="home?action=logout" method="POST">
    <input type="submit" value="Log out"><br/>
</form>

<form action="home" method="POST">
    <input type="submit" value="Home Page">
</form>
<br/>


</body>
</html>
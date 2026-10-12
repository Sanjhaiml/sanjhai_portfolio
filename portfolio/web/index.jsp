<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalTime" %>
<%
  // ---- Dynamic feature 1: time-of-day greeting, computed on the server ----
  int hour = LocalTime.now().getHour();
  String greeting;
  if (hour < 5)       greeting = "Burning the midnight oil? So am I, in a sense.";
  else if (hour < 12)  greeting = "Good morning \u2014 thanks for stopping by early.";
  else if (hour < 17)  greeting = "Good afternoon \u2014 glad you found your way here.";
  else if (hour < 21)  greeting = "Good evening \u2014 hope your day went well.";
  else                 greeting = "Working late? Same here \u2014 welcome.";

  // ---- Dynamic feature 2: application-scoped visit counter ----
  Object counterObj = application.getAttribute("visitCount");
  long visits = (counterObj == null) ? 0L : (Long) counterObj;
  synchronized (application) {
    visits = visits + 1;
    application.setAttribute("visitCount", visits);
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sanjhai M L &mdash; Portfolio</title>
  <meta name="description" content="Portfolio of Sanjhai M L, CSE undergraduate and aspiring data scientist working across AI, computational geometry and sustainable technology.">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

  <div id="site-nav"></div>

  <section class="hero">
    <div class="wrap hero-grid">
      <div>
        <div class="hero-kicker">Chennai region, Tamil Nadu &middot; B.E. CSE, class of 2028</div>
        <h1>Sanjhai M L</h1>
        <p class="tagline">Aspiring data scientist and ML engineer who likes to trace the geometry hiding inside ordinary things &mdash; a kolam drawn at the doorstep, a network of clay pots keeping a harvest cool, a routing problem with no easy shortcut.</p>
        <div class="hero-actions">
          <a class="btn primary" href="projects.jsp">View projects</a>
          <a class="btn" href="contact.jsp">Get in touch</a>
        </div>
        <p class="hero-greeting"><%= greeting %></p>
      </div>
      <div class="hero-art" aria-hidden="true">
        <svg class="draw-in" viewBox="0 0 400 360" xmlns="http://www.w3.org/2000/svg">
          <path class="kolam-line" d="M60,60
            C60,20 140,20 140,60
            C140,100 200,100 200,60
            C200,20 280,20 280,60
            C280,100 340,100 340,60
            M60,60 C20,60 20,140 60,140
            C100,140 100,200 60,200
            C20,200 20,280 60,280
            M340,60 C380,60 380,140 340,140
            C300,140 300,200 340,200
            C380,200 380,280 340,280
            M60,280 C60,320 140,320 140,280
            C140,240 200,240 200,280
            C200,320 280,320 280,280
            C280,240 340,240 340,280
            M140,60 C140,140 100,140 100,180
            C100,220 140,220 140,280
            M260,60 C260,140 300,140 300,180
            C300,220 260,220 260,280
            M140,140 C160,160 240,160 260,140
            M140,200 C160,180 240,180 260,200
          "/>
          <g>
            <circle class="kolam-dot" cx="60" cy="60" r="3.5"/>
            <circle class="kolam-dot" cx="140" cy="60" r="3.5"/>
            <circle class="kolam-dot" cx="200" cy="60" r="3.5"/>
            <circle class="kolam-dot" cx="280" cy="60" r="3.5"/>
            <circle class="kolam-dot" cx="340" cy="60" r="3.5"/>
            <circle class="kolam-dot" cx="60" cy="140" r="3.5"/>
            <circle class="kolam-dot" cx="340" cy="140" r="3.5"/>
            <circle class="kolam-dot" cx="60" cy="200" r="3.5"/>
            <circle class="kolam-dot" cx="340" cy="200" r="3.5"/>
            <circle class="kolam-dot" cx="60" cy="280" r="3.5"/>
            <circle class="kolam-dot" cx="140" cy="280" r="3.5"/>
            <circle class="kolam-dot" cx="200" cy="280" r="3.5"/>
            <circle class="kolam-dot" cx="280" cy="280" r="3.5"/>
            <circle class="kolam-dot" cx="340" cy="280" r="3.5"/>
          </g>
        </svg>
      </div>
    </div>
  </section>

  <section>
    <div class="wrap">
      <div class="eyebrow">Right now</div>
      <h2>What I'm working on this season</h2>
      <div class="grid cols-3">
        <div class="card">
          <div class="meta">Software Developer Intern</div>
          <h3>Tarcin Robotic LLP</h3>
          <p>Contributing to software development projects and application enhancement, working with modern development tools alongside the team.</p>
        </div>
        <div class="card">
          <div class="meta">Research &middot; under review</div>
          <h3>Kolam symmetry &amp; structure</h3>
          <p>A paper modelling the symmetry and structure of traditional Kolam patterns using computational geometry, submitted to a Scopus-indexed journal.</p>
        </div>
        <div class="card">
          <div class="meta">Student Ambassador</div>
          <h3>Relevantz</h3>
          <p>Representing Relevantz among student communities and promoting industry engagement, events and career opportunities.</p>
        </div>
      </div>
    </div>
  </section>

  <section>
    <div class="wrap">
      <div class="eyebrow">Explore</div>
      <h2>Find your way around</h2>
      <div class="grid cols-3">
        <a class="card card-link" href="projects.jsp">
          <h3>Projects</h3>
          <p>AgriCool+, the Kolam recreation engine, RekhaSutra 360, and a handful of proposals still in progress.</p>
        </a>
        <a class="card card-link" href="achievements.html">
          <h3>Achievements</h3>
          <p>Awards, publications, patents in progress, and 90+ problems solved on LeetCode.</p>
        </a>
        <a class="card card-link" href="skills.html">
          <h3>Skills</h3>
          <p>Languages, ML tooling, core CS concepts, and the value-added courses I'm currently building on.</p>
        </a>
      </div>
    </div>
  </section>

  <div id="site-footer"></div>
  <p class="visually-hidden">Visitor count this application run: <%= visits %></p>

  <script src="js/script.js"></script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sanjhai.portfolio.Project" %>
<%@ page import="com.sanjhai.portfolio.ProjectService" %>
<%
  // Dynamic feature: the list below comes from a Java data-service
  // class (ProjectService), not from text hard-coded in this page.
  List<Project> projects = ProjectService.getAll();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Projects &mdash; Sanjhai M L</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

  <div id="site-nav"></div>

  <section class="page-head">
    <div class="wrap">
      <div class="eyebrow">Projects</div>
      <h1>Proposals, prototypes, and one hackathon submission</h1>
      <p>This list is rendered server-side from a small Java data service, so adding a new project only means editing one class, not this page. Use the filter to narrow it down.</p>
    </div>
  </section>

  <section>
    <div class="wrap">
      <div class="filter-bar" role="group" aria-label="Filter projects by category">
        <button class="filter-btn" data-filter="all" aria-pressed="true">All</button>
        <button class="filter-btn" data-filter="ai-iot" aria-pressed="false">AI &amp; IoT</button>
        <button class="filter-btn" data-filter="research" aria-pressed="false">Research &amp; competitions</button>
        <button class="filter-btn" data-filter="web" aria-pressed="false">Web</button>
      </div>

      <div class="grid cols-2">
        <% for (Project p : projects) { %>
        <div class="card" data-category="<%= p.getCategory() %>">
          <span class="pill <%= p.getStatusClass() %>"><%= p.getStatus() %></span>
          <h3><%= p.getTitle() %></h3>
          <p><%= p.getDescription() %></p>
          <div class="tag-row">
            <% for (String tech : p.getTech()) { %>
              <span class="tag"><%= tech %></span>
            <% } %>
          </div>
        </div>
        <% } %>
      </div>
    </div>
  </section>

  <section>
    <div class="wrap">
      <div class="eyebrow">Publications &amp; scholarly impact</div>
      <h2>Papers in print and in review</h2>
      <div class="grid cols-2">
        <div class="card">
          <span class="pill published">Published</span>
          <h3>Minimum Spanning Tree&ndash;Based Network Design Using Prim's &amp; Kruskal's Algorithms</h3>
          <p>Published in an international peer-reviewed journal. Focused on scalable, cost-efficient network infrastructure design.</p>
        </div>
        <div class="card">
          <span class="pill selected">Accepted &middot; IJSREM, Mar 2026</span>
          <h3>Network Routing Optimization Using Eulerian Path Algorithm</h3>
          <p>Develops efficient routing approaches for complex network systems.</p>
        </div>
        <div class="card">
          <span class="pill selected">Accepted &middot; IJSREM, Mar 2026</span>
          <h3>Bio-Inspired Routing Framework Using Ant Colony Optimization</h3>
          <p>Applies nature-inspired intelligence to optimise network routing.</p>
        </div>
        <div class="card">
          <span class="pill review">Peer review complete</span>
          <h3>Adaptive Hybrid Coverage (AHC) for Dynamic Robotic Motion Planning</h3>
          <p>Proposes an adaptive framework for robotic navigation in unpredictable environments; completed double-blind peer review.</p>
        </div>
        <div class="card">
          <span class="pill review">Under review &middot; Scopus-indexed</span>
          <h3>Modelling Kolam Symmetry &amp; Structure Using Computational Geometry Techniques</h3>
          <p>Applies computational geometry and pattern analysis to model traditional Kolam structures.</p>
        </div>
      </div>
    </div>
  </section>

  <div id="site-footer"></div>
  <script src="js/script.js"></script>
</body>
</html>

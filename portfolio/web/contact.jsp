<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sanjhai.portfolio.FileMessageStore" %>
<%
  String status = (String) request.getAttribute("formStatus");
  String statusText = (String) request.getAttribute("formStatusText");
  String fName = (String) request.getAttribute("formName");
  String fEmail = (String) request.getAttribute("formEmail");
  String fSubject = (String) request.getAttribute("formSubject");
  String fMessage = (String) request.getAttribute("formMessage");
  if (fName == null) fName = "";
  if (fEmail == null) fEmail = "";
  if (fSubject == null) fSubject = "";
  if (fMessage == null) fMessage = "";

  // Dynamic feature: how many messages the file-backed store holds right now.
  long messageCount = FileMessageStore.count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact &mdash; Sanjhai M L</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

  <div id="site-nav"></div>

  <section class="page-head">
    <div class="wrap">
      <div class="eyebrow">Contact</div>
      <h1>Say hello</h1>
      <p>The fastest way to reach me is email or phone. If you'd rather use the form, it's processed by a servlet on this site and saved so I can follow up.</p>
    </div>
  </section>

  <section>
    <div class="wrap two-col">
      <div>
        <h2>Direct contact</h2>
        <ul class="list-clean">
          <li>Phone: <a href="tel:+919487818160" style="color:var(--marigold);">+91 94878 18160</a></li>
          <li>Email: <a href="mailto:sanjhaiml@gmail.com" style="color:var(--marigold);">sanjhaiml@gmail.com</a></li>
          <li>College email: <a href="mailto:24ucs139@kamarajengg.edu.in" style="color:var(--marigold);">24ucs139@kamarajengg.edu.in</a></li>
          <li>GitHub: <a href="https://github.com/Sanjhaiml" target="_blank" rel="noopener" style="color:var(--marigold);">github.com/Sanjhaiml</a></li>
          <li>LinkedIn: <a href="https://linkedin.com/in/sanjhaiml2103" target="_blank" rel="noopener" style="color:var(--marigold);">linkedin.com/in/sanjhaiml2103</a></li>
        </ul>
        <p style="margin-top:22px; font-size:0.88rem;"><%= messageCount %> message<%= messageCount == 1 ? "" : "s" %> received through this form so far.</p>
      </div>

      <div>
        <h2>Send a message</h2>

        <% if ("success".equals(status)) { %>
          <div class="alert success"><%= statusText %></div>
        <% } else if ("error".equals(status)) { %>
          <div class="alert error"><%= statusText %></div>
        <% } %>

        <form id="contactForm" action="contact-submit" method="post" novalidate>
          <div class="field">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<%= fName %>" required>
            <div class="error">Please enter your name (at least 2 characters).</div>
          </div>
          <div class="field">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= fEmail %>" required>
            <div class="error">Please enter a valid email address.</div>
          </div>
          <div class="field">
            <label for="subject">Subject</label>
            <input type="text" id="subject" name="subject" value="<%= fSubject %>" required>
            <div class="error">Please add a short subject.</div>
          </div>
          <div class="field">
            <label for="message">Message</label>
            <textarea id="message" name="message" rows="6" required><%= fMessage %></textarea>
            <div class="error">Please write at least 10 characters.</div>
          </div>
          <button type="submit" class="btn primary">Send message</button>
        </form>
      </div>
    </div>
  </section>

  <div id="site-footer"></div>
  <script src="js/script.js"></script>
</body>
</html>

# Sanjhai M L — Portfolio (HTML / CSS / JS / Servlet & JSP)

A multi-page personal portfolio built with plain HTML, CSS and JavaScript
for the static pages, and JSP + Servlets for the dynamic parts: a
time-aware greeting and visit counter on the home page, a data-driven
project list, and a contact form that a servlet validates and saves.

## What's dynamic, and why

| Page            | Feature                                                            |
|-----------------|---------------------------------------------------------------------|
| `index.jsp`     | Server computes a greeting from the time of day, and increments an application-scoped visit counter. |
| `projects.jsp`  | Project cards are rendered from `ProjectService` (a Java class), not hard-coded in the page — add a project by editing one file. |
| `contact.jsp` + `ContactServlet` | Form is POSTed to a servlet, validated server-side, saved to `WEB-INF/data/messages.txt`, and the page shows how many messages have been received. |

Everything else (About, Academic Details, Achievements, Skills,
Internships) is static HTML, with a small shared JavaScript layer that
injects the same nav bar and footer into every page (`partials/nav.html`,
`partials/footer.html`, wired up in `js/script.js`) and adds a
category filter on the Projects page and client-side validation on the
Contact form.

## Folder structure

```
portfolio/
├── web/                     ← this is the web app root (Tomcat "docBase")
│   ├── index.jsp            Home (dynamic)
│   ├── about.html
│   ├── academic.html
│   ├── projects.jsp         Projects (dynamic)
│   ├── achievements.html
│   ├── skills.html
│   ├── internships.html
│   ├── contact.jsp          Contact (dynamic)
│   ├── css/style.css
│   ├── js/script.js
│   ├── partials/nav.html, footer.html
│   ├── images/profile.jpg
│   └── WEB-INF/
│       ├── web.xml          servlet mapping, startup listener, welcome file
│       ├── classes/         compiled .class files go here (see below)
│       ├── lib/             drop mysql-connector-j-*.jar here only if you switch to MySQL
│       └── data/            messages.txt is created here automatically at startup
├── src/com/sanjhai/portfolio/   Java source (compile into web/WEB-INF/classes)
│   ├── AppLifecycleListener.java
│   ├── ContactServlet.java
│   ├── FileMessageStore.java
│   ├── Message.java
│   ├── Project.java
│   ├── ProjectService.java
│   └── ContactDAO.java       optional MySQL version, not wired up by default
├── sql/schema.sql            optional MySQL schema, only needed if you use ContactDAO
└── README.md
```

## Requirements

- JDK 8 or newer
- Apache Tomcat 9.x (this project uses the `javax.servlet` package; for
  Tomcat 10+, which switched to `jakarta.servlet`, replace that import
  prefix in the three servlet-related Java files and in `web.xml`'s
  namespace)

## Compile and deploy

1. **Compile the servlets**, using Tomcat's `servlet-api.jar` (found in
   Tomcat's own `lib/` folder) on the classpath:

   ```bash
   cd portfolio
   javac -cp "/path/to/tomcat/lib/servlet-api.jar" \
         -d web/WEB-INF/classes \
         src/com/sanjhai/portfolio/*.java
   ```

2. **Deploy** by copying the `web/` folder into Tomcat as an application
   (renaming it to whatever context path you want, e.g. `portfolio`):

   ```bash
   cp -r web /path/to/tomcat/webapps/portfolio
   ```

3. **Start Tomcat** and visit `http://localhost:8080/portfolio/`.

If you're using an IDE (Eclipse, IntelliJ, NetBeans) with a Dynamic Web
Project / Tomcat integration instead, just import `web/` as the web
content root and `src/` as the Java source folder, and let the IDE
handle compiling and deploying.

## Viewing the static pages without a server

`about.html`, `academic.html`, `achievements.html`, `skills.html` and
`internships.html` can be opened directly as files in a browser — but
the shared nav/footer (loaded via `fetch()`) and the two `.jsp` pages
only work once the site is served over HTTP, i.e. through Tomcat.

## Switching the contact form to a real database

By default, messages are appended to `WEB-INF/data/messages.txt` — this
needs no setup at all. To use MySQL instead:

1. Run `sql/schema.sql` in MySQL to create `portfolio_db` and its
   `contact_messages` table.
2. Add the MySQL Connector/J jar to `web/WEB-INF/lib`.
3. Fill in the connection details at the top of `ContactDAO.java`.
4. In `ContactServlet.java`, replace `FileMessageStore.append(message)`
   with `ContactDAO.save(message)`, and in `contact.jsp`, replace
   `FileMessageStore.count()` with `ContactDAO.count()`.

## Updating content

- **Projects** — edit `ProjectService.java` (no JSP changes needed).
- **Everything else** — edit the relevant `.html` file directly; the
  nav and footer are shared, so you only maintain them in
  `partials/nav.html` and `partials/footer.html`.

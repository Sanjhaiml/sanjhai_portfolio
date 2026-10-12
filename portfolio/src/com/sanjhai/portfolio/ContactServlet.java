package com.sanjhai.portfolio;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Handles POSTs from the contact form on contact.jsp.
 * Mapped to /contact-submit in WEB-INF/web.xml.
 *
 * Server-side processing performed here:
 *   1. Re-validates every field (never trust client-side JS alone).
 *   2. On success, persists the message via FileMessageStore and
 *      forwards back to contact.jsp with a success flag.
 *   3. On failure, forwards back with an error flag and the values
 *      the visitor already typed, so nothing is lost.
 */
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = trim(request.getParameter("name"));
        String email = trim(request.getParameter("email"));
        String subject = trim(request.getParameter("subject"));
        String body = trim(request.getParameter("message"));

        boolean valid = name.length() >= 2
                && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")
                && subject.length() >= 3
                && body.length() >= 10;

        request.setAttribute("formName", name);
        request.setAttribute("formEmail", email);
        request.setAttribute("formSubject", subject);
        request.setAttribute("formMessage", body);

        if (!valid) {
            request.setAttribute("formStatus", "error");
            request.setAttribute("formStatusText",
                "Please check the highlighted fields \u2014 something looks incomplete.");
        } else {
            try {
                FileMessageStore.append(new Message(name, email, subject, body));
                request.setAttribute("formStatus", "success");
                request.setAttribute("formStatusText",
                    "Thanks, " + name + " \u2014 your message has been received. I'll get back to you soon.");
                // Clear the form on success.
                request.setAttribute("formName", "");
                request.setAttribute("formEmail", "");
                request.setAttribute("formSubject", "");
                request.setAttribute("formMessage", "");
            } catch (IOException e) {
                request.setAttribute("formStatus", "error");
                request.setAttribute("formStatusText",
                    "Something went wrong saving your message. Please try again in a moment.");
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/contact.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // A direct GET just lands back on the contact page.
        response.sendRedirect("contact.jsp");
    }

    private static String trim(String value) {
        return value == null ? "" : value.trim();
    }
}

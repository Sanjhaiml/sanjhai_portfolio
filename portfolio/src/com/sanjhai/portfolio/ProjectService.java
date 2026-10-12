package com.sanjhai.portfolio;

import java.util.ArrayList;
import java.util.List;

/**
 * Supplies the project list shown on projects.jsp.
 *
 * This keeps data out of the JSP: the page only loops over
 * whatever this class returns. Today that's an in-memory list;
 * swapping it for a database-backed implementation (see
 * ContactDAO for the JDBC pattern used elsewhere in this app)
 * would not require any change to projects.jsp.
 */
public class ProjectService {

    public static List<Project> getAll() {
        List<Project> projects = new ArrayList<Project>();

        projects.add(new Project(
            "AgriCool+ \u2014 Smart Zero-Energy Crop Cooling Pod",
            "ai-iot",
            "Selected \u2014 MSME",
            "selected",
            "A low-cost, solar-powered crop storage solution combining clay-based passive cooling, " +
            "IoT sensors and AI-based spoilage prediction. Includes custom micro-controller firmware, " +
            "prediction models and a mobile dashboard with SMS alerts, refined through field testing " +
            "and farmer feedback.",
            new String[]{"Python", "Django", "MongoDB", "REST API", "IoT"}
        ));

        projects.add(new Project(
            "Kolam Design Recreation",
            "research",
            "Selected \u2014 SIH",
            "selected",
            "Submitted for Smart India Hackathon: a Python program that identifies the design " +
            "principles behind traditional Kolam patterns and recreates them through a menu-driven " +
            "interface with dynamic Turtle graphics, built on a modular system for adding new patterns.",
            new String[]{"Python", "Turtle", "Matplotlib"}
        ));

        projects.add(new Project(
            "RekhaSutra 360",
            "ai-iot",
            "In progress",
            "review",
            "An intelligent heritage restoration and visual knowledge platform. Uses computer vision, " +
            "image processing and OCR to restore heritage imagery and recognise ancient scripts, with " +
            "modules spanning cultural preservation, education, healthcare and digital archiving.",
            new String[]{"Computer Vision", "OCR", "Image Processing", "AI"}
        ));

        projects.add(new Project(
            "This portfolio site",
            "web",
            "Live",
            "published",
            "The site you're looking at: static HTML/CSS/JS pages for content that doesn't change " +
            "often, and JSP/Servlet pages for the parts that do \u2014 the home page greeting and visit " +
            "counter, and the contact form below.",
            new String[]{"HTML", "CSS", "JavaScript", "JSP", "Servlets"}
        ));

        projects.add(new Project(
            "Additional submitted proposals",
            "research",
            "Submitted",
            "review",
            "A further set of proposals taken to college-level or external selection rounds: two FEAR " +
            "projects, a second Smart India Hackathon submission, a proposal for E-Cell IIT Bombay, and " +
            "an entry for a STATHON.",
            new String[]{"Proposal Writing", "Research"}
        ));

        return projects;
    }
}

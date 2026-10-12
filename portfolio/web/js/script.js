/* =========================================================
   SANJHAI M L — Portfolio
   Client-side interactivity: shared nav/footer injection,
   mobile menu, active-link state, project category filter,
   and contact-form validation before it POSTs to the servlet.
   ========================================================= */

(function () {
  "use strict";

  function currentPage() {
    var path = window.location.pathname.split("/").pop() || "index.jsp";
    var map = {
      "": "home",
      "index.jsp": "home",
      "about.html": "about",
      "academic.html": "academic",
      "projects.jsp": "projects",
      "achievements.html": "achievements",
      "skills.html": "skills",
      "internships.html": "internships",
      "contact.jsp": "contact"
    };
    return map[path] || "home";
  }

  function markActiveLink() {
    var page = currentPage();
    document.querySelectorAll("[data-nav]").forEach(function (link) {
      if (link.getAttribute("data-nav") === page) {
        link.setAttribute("aria-current", "page");
      }
    });
  }

  function wireNavToggle() {
    var toggle = document.getElementById("navToggle");
    var links = document.getElementById("navLinks");
    if (!toggle || !links) return;
    toggle.addEventListener("click", function () {
      var open = links.classList.toggle("open");
      toggle.setAttribute("aria-expanded", open ? "true" : "false");
    });
  }

  function injectPartial(selector, url, afterInject) {
    var host = document.querySelector(selector);
    if (!host) return;
    fetch(url)
      .then(function (res) {
        if (!res.ok) throw new Error("Failed to load " + url);
        return res.text();
      })
      .then(function (html) {
        host.innerHTML = html;
        if (typeof afterInject === "function") afterInject();
      })
      .catch(function (err) {
        console.warn(err);
      });
  }

  document.addEventListener("DOMContentLoaded", function () {
    injectPartial("#site-nav", "partials/nav.html", function () {
      wireNavToggle();
      markActiveLink();
    });
    injectPartial("#site-footer", "partials/footer.html");

    initProjectFilter();
    initContactForm();
  });

  /* ---------------- Projects: client-side category filter ---------------- */
  function initProjectFilter() {
    var bar = document.querySelector(".filter-bar");
    if (!bar) return;
    var buttons = bar.querySelectorAll(".filter-btn");
    var cards = document.querySelectorAll("[data-category]");

    buttons.forEach(function (btn) {
      btn.addEventListener("click", function () {
        buttons.forEach(function (b) { b.setAttribute("aria-pressed", "false"); });
        btn.setAttribute("aria-pressed", "true");
        var category = btn.getAttribute("data-filter");
        cards.forEach(function (card) {
          var matches = category === "all" || card.getAttribute("data-category") === category;
          card.style.display = matches ? "" : "none";
        });
      });
    });
  }

  /* ---------------- Contact form: validate before POST to ContactServlet ---------------- */
  function initContactForm() {
    var form = document.getElementById("contactForm");
    if (!form) return;

    var rules = {
      name: function (v) { return v.trim().length >= 2; },
      email: function (v) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v.trim()); },
      subject: function (v) { return v.trim().length >= 3; },
      message: function (v) { return v.trim().length >= 10; }
    };

    form.addEventListener("submit", function (evt) {
      var valid = true;
      Object.keys(rules).forEach(function (name) {
        var input = form.elements[name];
        if (!input) return;
        var field = input.closest(".field");
        var ok = rules[name](input.value || "");
        field.classList.toggle("invalid", !ok);
        if (!ok) valid = false;
      });
      if (!valid) evt.preventDefault();
    });

    form.querySelectorAll("input, textarea").forEach(function (el) {
      el.addEventListener("input", function () {
        el.closest(".field").classList.remove("invalid");
      });
    });
  }
})();

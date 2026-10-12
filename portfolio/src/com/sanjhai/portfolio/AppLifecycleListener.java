package com.sanjhai.portfolio;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Runs once when the application starts up: points FileMessageStore at
 * WEB-INF/data, and zeroes the visit counter that index.jsp increments
 * and reads on every load of the home page.
 */
public class AppLifecycleListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        String webInfPath = event.getServletContext().getRealPath("/WEB-INF");
        FileMessageStore.init(webInfPath);
        event.getServletContext().setAttribute("visitCount", 0L);
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        // Nothing to release explicitly \u2014 the file writer opens/closes per message.
    }
}

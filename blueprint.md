# Project Blueprint: examera

## Overview

examera is a cross-platform application for Android, iOS, and the web, designed to provide users with comprehensive information about various upcoming, ongoing, and past exams. The app will feature a user-friendly interface, powerful filtering options, and premium features for subscribed users. The backend will be built with a focus on scalability to support a large user base.

## Style and Design

*   **Aesthetics:** Clean, modern, and intuitive design following Material Design 3 principles.
*   **Layout:** Visually balanced with clear spacing and a card-based layout for displaying exam information.
*   **Typography:** Expressive and hierarchical typography to enhance readability and user understanding.
*   **Color Palette:** A vibrant and energetic color palette to create a positive user experience.
*   **Iconography:** Modern and intuitive icons to aid navigation and comprehension.
*   **Interactivity:** Smooth animations and interactive elements with a "glow" effect to provide a premium feel.

## Features

### Core Features (Free)

*   **Exam Listings:** Display exams in a card-based layout with essential information.
*   **Exam Details:** A detailed view for each exam with information about the exam date, application deadline, application link, official website/notice, syllabus, eligibility, fees, etc.
*   **Filtering:** Allow users to filter exams based on eligibility, status (upcoming, ongoing, past), and syllabus.
*   **Ad-Supported:** Display Google AdSense ads for revenue.
*   **Profile Management:** Basic profile section for personal details.

### Premium Features (Subscription)

*   **Ad-Free Experience:** Remove all ads for subscribed users.
*   **Save/Bookmark Exams:** Allow users to save exams for easy access.
*   **Exam Status Tracking:** Users can mark exams as "applied," "attempted," etc.
*   **Notifications:** Push notifications for important exam dates and deadlines.
*   **Result Tracking:** A dedicated section to track exam results.
*   **New Exam Notice Notification:** Users can choose to get notified about new exams from a list of categories

### Monetization

*   **Subscription:** A yearly subscription of Rs. 99 for an ad-free experience and access to premium features.
*   **Freemium Model:** A popup will prompt users to subscribe when they attempt to access premium features.

## Architecture

*   **Frontend:** Flutter
*   **Backend:** Golang (REST API)
*   **Architecture Pattern:** Feature-first, layered architecture (Presentation, Domain, Data).
*   **State Management:** `provider`
*   **Routing:** `go_router`
*   **Database:** PostgreSQL
*   **Authentication:** JWT-based authentication (Golang), Email + password (bcrypt), OAuth later (Google Sign-In), PostgreSQL users table
*   **Notifications:** Firebase Cloud Messaging (push delivery only)
*   **Ads:** Google AdSense

## Plan

1.  **Project Setup:**
    *   Initialize a new Flutter project.
    *   Configure for Android, iOS, and web platforms.

2.  **Core UI Development:**
    *   Implement the main navigation (bottom navigation bar).
    *   Create the home screen with a list of exam cards.
    *   Design the exam details screen.
    *   Develop the profile screen.

3.  **Backend Integration (Initial):**
    *   Set up JWT-based authentication, Email + password (bcrypt), OAuth later (Google Sign-In), PostgreSQL users table
    *   Implement user registration and login.

4.  **Feature Implementation:**
    *   Develop the exam filtering and search functionality.
    *   Implement the "save exam" feature.
    *   Create the subscription popup and a basic subscription flow.
    *   Integrate Google AdSense.

5.  **Backend Development (Full):**
    *   Design and implement the PostgreSQL database schema.
    *   Develop a robust REST API to serve data to the Flutter app.

6.  **Testing and Deployment:**
    *   Write unit and widget tests.
    *   Prepare the app for deployment to the respective app stores and web.

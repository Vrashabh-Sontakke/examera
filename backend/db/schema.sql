-- Database Schema for Examera

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    is_subscribed BOOLEAN DEFAULT FALSE,
    subscription_expiry TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Exams table
CREATE TABLE exams (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    exam_date DATE,
    application_deadline DATE,
    application_link TEXT,
    official_website TEXT,
    syllabus_link TEXT,
    eligibility TEXT,
    fee JSONB, -- Storing fee structure as JSON
    status VARCHAR(50), -- upcoming, ongoing, past
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User-Exam interactions (Saved/Tracked)
CREATE TABLE user_exams (
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    exam_id INTEGER REFERENCES exams(id) ON DELETE CASCADE,
    is_saved BOOLEAN DEFAULT FALSE,
    tracking_status VARCHAR(50), -- applied, attempted, result_awaiting, passed, failed
    notification_sent BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_id, exam_id)
);

-- Subscriptions table (History)
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP NOT NULL,
    payment_id VARCHAR(255)
);

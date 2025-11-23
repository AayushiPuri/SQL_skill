-- =============================================================================
-- schema.sql
--
-- This file contains the sanitized DDL (Data Definition Language) for the
-- PostgreSQL database schema. It defines the tables, columns, primary keys,
-- and foreign key relationships to ensure data integrity.
-- =============================================================================

-- The Configuration Table
-- Purpose: Stores the settings for each data stream source (e.g., a camera).
CREATE TABLE stream_sources (
    id SERIAL PRIMARY KEY,
    source_name VARCHAR(255) NOT NULL,
    source_uri TEXT UNIQUE NOT NULL,
    line_coordinates TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- The Lifetime Summary Table
-- Purpose: To maintain a persistent, overall summary of counts for each source.
CREATE TABLE lifetime_event_summary (
    source_id INT PRIMARY KEY,
    forward_direction_count BIGINT DEFAULT 0,
    backward_direction_count BIGINT DEFAULT 0,
    last_updated_at TIMESTAMP WITH TIME ZONE,
    CONSTRAINT fk_source
      FOREIGN KEY(source_id) REFERENCES stream_sources(id) ON DELETE CASCADE
);

-- The Detailed Event Log Table
-- Purpose: To create a timestamped record for every single event detected.
CREATE TABLE event_log (
    event_id BIGSERIAL PRIMARY KEY,
    source_id INT NOT NULL,
    event_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    direction VARCHAR(50),
    object_tracking_id INT,
    CONSTRAINT fk_source
      FOREIGN KEY(source_id) REFERENCES stream_sources(id) ON DELETE CASCADE
);

-- Add indexes on foreign keys and timestamps for faster query performance
CREATE INDEX idx_event_log_source_id ON event_log (source_id);
CREATE INDEX idx_event_log_timestamp ON event_log (event_timestamp);

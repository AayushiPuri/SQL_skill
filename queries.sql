-- =============================================================================
-- queries.sql
--
-- This file contains representative SQL statements (DML and DQL) used by the
-- application to interact with the database.
-- =============================================================================


-- =========== Data Manipulation Language (DML) Examples ===========

-- INSERT: Logging a new event as it occurs in real-time.
INSERT INTO event_log (source_id, direction, object_tracking_id)
VALUES (1, 'forward', 101);


-- UPDATE: Atomically updating the summary table.
-- Using "SET count = new_total" instead of "SET count = count + 1" is a
-- deliberate design choice to prevent data drift if the application restarts.
UPDATE lifetime_event_summary
SET
    forward_direction_count = 542, -- The new total calculated by the Python app
    last_updated_at = NOW()
WHERE
    source_id = 1;


-- =========== Data Query Language (DQL) Examples ===========

-- Query 1: Get total lifetime counts for all active stream sources.
-- Used for a high-level summary dashboard.
SELECT
    s.id,
    s.source_name,
    COALESCE(les.forward_direction_count, 0) AS total_forward,
    COALESCE(les.backward_direction_count, 0) AS total_backward
FROM
    stream_sources s
LEFT JOIN
    lifetime_event_summary les ON s.id = les.source_id
WHERE
    s.is_active = true
ORDER BY
    s.source_name;


-- Query 2: Get a time-series count of events for a specific source over the last 24 hours.
-- Used to populate a "Crossings Over Time" graph.
SELECT
    DATE_TRUNC('hour', event_timestamp) AS hour_bucket,
    COUNT(*) AS total_events,
    SUM(CASE WHEN direction = 'forward' THEN 1 ELSE 0 END) AS forward_events
FROM
    event_log
WHERE
    source_id = 1
    AND event_timestamp >= NOW() - INTERVAL '24 hours'
GROUP BY
    hour_bucket
ORDER BY
    hour_bucket ASC;


-- Query 3: Retrieve the 15 most recent "backward" direction events.
-- Used to populate an "Unusual Events Log" on the dashboard.
SELECT
    el.event_timestamp,
    ss.source_name,
    el.object_tracking_id
FROM
    event_log el
JOIN
    stream_sources ss ON el.source_id = ss.id
WHERE
    el.direction = 'backward'
ORDER BY
    el.event_timestamp DESC
LIMIT 15;

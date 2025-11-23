# SQL Project Work Sample: Database for a Real-Time Analytics System

## Introduction

This repository contains sanitized, representative SQL samples from a confidential client project. Due to a non-disclosure agreement (NDA), the original source code and proprietary details cannot be shared.

The purpose of this repository is to demonstrate my hands-on expertise in **SQL and relational database design**. The files here showcase the database architecture and complex query logic I developed to support a high-performance, real-time data processing application.

---

## Project Context

The database schema outlined here was the foundation for a Python application that performed real-time video analytics. The database was responsible for:
- Storing the configuration for each video stream.
- Maintaining persistent, lifetime counts of detected events.
- Logging every individual event for detailed, time-series analysis.

---

## Contents of This Repository

*   **`schema.sql`**: Contains the Data Definition Language (DDL) for the PostgreSQL database. It demonstrates my ability to design a normalized, relational data model with primary keys, foreign keys, and indexes to ensure data integrity and query performance.

*   **`queries.sql`**: Provides a collection of complex SQL queries representative of those used in the project's API. They showcase my proficiency in joining tables, performing time-series aggregations (`DATE_TRUNC`), using conditional logic (`CASE`), and retrieving data for analytics dashboards.

*   **`data_flow_logic.sql`**: Includes examples of the Data Manipulation Language (DML) used to accurately insert and update data, including the critical `UPDATE ... SET` logic that prevented data drift.

These samples accurately reflect the technical skills and design principles I applied to achieve the project's data management goals.

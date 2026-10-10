-- ============================================================================
-- TRAINER PERFORMANCE DASHBOARD | STEP 2 of 6: DIMENSION VIEWS (3)
-- Purpose: stable lookup tables (trainer, batch, module) that the reporting
-- views join to, so readable names appear in the dashboard.
-- Run after: 01_staging_views.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.dim_trainer` AS
SELECT * FROM `your-project-id.trainer_performance.stg_trainer_details`;

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.dim_batch` AS
SELECT * FROM `your-project-id.trainer_performance.stg_batch`;

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.dim_module` AS
SELECT * FROM `your-project-id.trainer_performance.stg_course_trainer`;

-- ============================================================================
-- TRAINER PERFORMANCE DASHBOARD | STEP 3 of 6: GROUP A - TRAINER PERFORMANCE
-- Grain: trainer x date. Combines attendance, trainer details and demos.
-- Dashboard filters: branch_name, trainer_name, trainer_id, activity_date
-- Dashboard metrics: SUM of every is_* flag and demo/conversion column
-- Run after: 02_dimension_views.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.vw_group_a_trainer_performance` AS
SELECT
  COALESCE(a.attendance_date, d.demo_date)           AS activity_date,
  COALESCE(a.trainer_id, d.trainer_id)               AS trainer_id,
  t.trainer_name,
  t.branch_name,
  CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END AS is_present,
  CASE WHEN a.attendance_status = 'Absent' AND a.leave_type = 'Full Day'
       THEN 1 ELSE 0 END                             AS is_full_day_leave,
  CASE WHEN a.leave_type = 'Half Day' THEN 1 ELSE 0 END  AS is_half_day_leave,
  CASE WHEN a.leave_type = 'Short Day' THEN 1 ELSE 0 END AS is_short_day_leave,
  d.total_demo,
  d.conversion                                       AS total_conversions,
  d.reference_demo                                   AS reference,
  d.reference_conversion                             AS reference_conversions
FROM `your-project-id.trainer_performance.stg_attendance` a
FULL OUTER JOIN `your-project-id.trainer_performance.stg_demo` d
  ON a.trainer_id = d.trainer_id AND a.attendance_date = d.demo_date
LEFT JOIN `your-project-id.trainer_performance.dim_trainer` t
  ON t.trainer_id = COALESCE(a.trainer_id, d.trainer_id);

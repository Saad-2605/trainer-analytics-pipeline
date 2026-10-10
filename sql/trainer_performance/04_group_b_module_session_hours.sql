-- ============================================================================
-- TRAINER PERFORMANCE DASHBOARD | STEP 4 of 6: GROUP B - MODULE & SESSION HOURS
-- Grain: trainer x date x batch x module (one row per teaching session).
-- Dashboard filters: trainer_name, trainer_id, course_name, module_name,
--                    session_type, batch_mode
-- Dashboard metrics: SUM(duration_hours), SUM(no_of_students),
--                    COUNT DISTINCT of ongoing_batch_id / passout_batch_id
-- Run after: 03_group_a_trainer_performance.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.vw_group_b_module_session_hours` AS
SELECT
  s.session_date,
  s.trainer_id,
  t.trainer_name,
  s.batch_id,
  b.batch_status,
  CASE WHEN b.batch_status = 'Ongoing' THEN s.batch_id END  AS ongoing_batch_id,
  CASE WHEN b.batch_status = 'Pass Out' THEN s.batch_id END AS passout_batch_id,
  b.mode                                             AS batch_mode,
  s.module_id,
  m.module_name,
  m.course_id,
  m.course_name,
  s.session_type,
  s.no_of_students,
  s.duration_hours
FROM `your-project-id.trainer_performance.stg_session` s
LEFT JOIN `your-project-id.trainer_performance.dim_trainer` t ON t.trainer_id = s.trainer_id
LEFT JOIN `your-project-id.trainer_performance.dim_batch` b   ON b.batch_id   = s.batch_id
LEFT JOIN (SELECT DISTINCT module_id, module_name, course_id, course_name
           FROM `your-project-id.trainer_performance.dim_module`) m
  ON m.module_id = s.module_id;

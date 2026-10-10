-- ============================================================================
-- TRAINER PERFORMANCE DASHBOARD | STEP 5 of 6: GROUP C - BATCH & COURSE ENROLLMENT
-- Grain: one row per batch (pre-aggregated, safe to SUM directly).
-- Dashboard filters: trainer_name, trainer_id, course_name, batch_id
-- Dashboard metrics: SUM(total_students), SUM(active_students),
--                    SUM(dormant_students)
-- Run after: 04_group_b_module_session_hours.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.vw_group_c_batch_course_enrollment` AS
SELECT
  st.batch_id,
  b.trainer_id,
  t.trainer_name,
  b.batch_status,
  st.course_id,
  c.course_name,
  COUNT(DISTINCT st.student_id)                       AS total_students,
  COUNTIF(st.student_status = 'Active')              AS active_students,
  COUNTIF(st.student_status = 'Dormant')             AS dormant_students
FROM `your-project-id.trainer_performance.stg_student_trainer` st
LEFT JOIN `your-project-id.trainer_performance.dim_batch` b   ON b.batch_id = st.batch_id
LEFT JOIN `your-project-id.trainer_performance.dim_trainer` t ON t.trainer_id = b.trainer_id
LEFT JOIN (SELECT DISTINCT course_id, course_name
           FROM `your-project-id.trainer_performance.dim_module`) c ON c.course_id = st.course_id
GROUP BY 1, 2, 3, 4, 5, 6;

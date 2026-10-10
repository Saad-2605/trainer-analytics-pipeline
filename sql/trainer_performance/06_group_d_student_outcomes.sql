-- ============================================================================
-- TRAINER PERFORMANCE DASHBOARD | STEP 6 of 6: GROUP D - STUDENT OUTCOMES
-- Grain: one row per student (safe to SUM directly).
-- Dashboard filters: trainer_name, course_name
-- Dashboard metrics: SUM(is_placed), SUM(is_interned)
-- Note: placement/internship are one-time events, so do not tie these
-- scorecards to the page-level date range in Looker Studio.
-- Run after: 05_group_c_batch_course_enrollment.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.vw_group_d_student_outcomes` AS
SELECT
  st.student_id,
  st.student_name,
  st.trainer_id,
  t.trainer_name,
  st.course_id,
  c.course_name,
  CASE WHEN p.student_id IS NOT NULL THEN 1 ELSE 0 END AS is_placed,
  CASE WHEN i.student_id IS NOT NULL THEN 1 ELSE 0 END AS is_interned,
  p.designation                                      AS placement_designation,
  p.company                                          AS placement_company,
  p.placement_salary,
  p.joining_date                                     AS placement_joining_date,
  i.designation                                      AS internship_designation,
  i.company                                          AS internship_company,
  i.stipend,
  i.joining_date                                     AS internship_joining_date
FROM `your-project-id.trainer_performance.stg_student_trainer` st
LEFT JOIN `your-project-id.trainer_performance.dim_trainer` t ON t.trainer_id = st.trainer_id
LEFT JOIN (SELECT DISTINCT course_id, course_name
           FROM `your-project-id.trainer_performance.dim_module`) c ON c.course_id = st.course_id
LEFT JOIN `your-project-id.trainer_performance.stg_placements` p ON p.student_id = st.student_id
LEFT JOIN `your-project-id.trainer_performance.stg_internship` i ON i.student_id = st.student_id;

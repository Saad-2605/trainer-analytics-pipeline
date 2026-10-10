-- ============================================================================
-- SESSION FEEDBACK DASHBOARD | STEP 3 of 3: COMMENTS VIEW
-- Feeds the table at the bottom of the dashboard
-- (student name, suggestion, remarks).
-- Keeps only rows where the student wrote a suggestion or a remark.
-- Run after: 02_feedback_score_summary.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.session_feedback.feedback_comments` AS
SELECT
  trainer_name,
  branch_name,
  student_name,
  suggestion,
  remarks
FROM `your-project-id.session_feedback.stg_feedback_union`
WHERE (suggestion IS NOT NULL AND suggestion != '')
   OR (remarks IS NOT NULL AND remarks != '');

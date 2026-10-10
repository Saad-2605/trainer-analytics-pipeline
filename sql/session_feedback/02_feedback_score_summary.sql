-- ============================================================================
-- SESSION FEEDBACK DASHBOARD | STEP 2 of 3: SCORE SUMMARY VIEW
-- Feeds the 5 gauge charts (scale 1-5) in Looker Studio.
-- One row per trainer + branch with the average of each rating column.
-- Run after: 01_stg_feedback_union.sql
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.session_feedback.feedback_score_summary` AS
SELECT
  trainer_name,
  branch_name,
  COUNT(*)                                           AS total_responses,
  ROUND(AVG(content_covered), 2)                     AS avg_content_covered,
  ROUND(AVG(task_discussion), 2)                     AS avg_task_discussion,
  ROUND(AVG(pace_of_session), 2)                     AS avg_pace_of_session,
  ROUND(AVG(interaction_engagement), 2)              AS avg_interaction_engagement,
  ROUND(AVG(overall_experience), 2)                  AS avg_overall_experience
FROM `your-project-id.session_feedback.stg_feedback_union`
GROUP BY trainer_name, branch_name;

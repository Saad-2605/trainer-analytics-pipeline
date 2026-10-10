-- ============================================================================
-- SESSION FEEDBACK DASHBOARD | STEP 1 of 3: STAGING VIEW
-- Source: one table per trainer (Google Form -> Google Sheet -> BigQuery)
-- Purpose: stack every trainer's responses into one table (UNION ALL) and
-- rename the raw form columns to clean, consistent names.
-- Replace `your-project-id` and `session_feedback` with your own project ID
-- and dataset name before running.
--
-- ADDING A NEW TRAINER: load their sheet as a new table, paste one more
-- "UNION ALL + SELECT" block at the end of this file, then re-run this whole
-- file. Steps 2 and 3 update automatically.
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.session_feedback.stg_feedback_union` AS

SELECT
  Timestamp                                          AS response_time,
  Email_address                                      AS email,
  Branch                                             AS branch_name,
  Trainer                                            AS trainer_name,
  Name                                               AS student_name,
  Contact_No__                                       AS contact_no,
  Content_Covered_                                   AS content_covered,
  Task_Discussion_                                   AS task_discussion,
  Pace_of_the_session_                               AS pace_of_session,
  Interaction_Engagement_                            AS interaction_engagement,
  Overall_Experience_                                AS overall_experience,
  Please_share_your_suggestion_in_case_any_further_improvements_are_required_ AS suggestion,
  Remarks__if_any__                                  AS remarks
FROM `your-project-id.session_feedback.AMAN_FEEDBACK`

UNION ALL

SELECT
  Timestamp                                          AS response_time,
  Email_address                                      AS email,
  Branch                                             AS branch_name,
  Trainer                                            AS trainer_name,
  Name                                               AS student_name,
  Contact_No__                                       AS contact_no,
  Content_Covered_                                   AS content_covered,
  Task_Discussion_                                   AS task_discussion,
  Pace_of_the_session_                               AS pace_of_session,
  Interaction_Engagement_                            AS interaction_engagement,
  Overall_Experience_                                AS overall_experience,
  Please_share_your_suggestion_in_case_any_further_improvements_are_required_ AS suggestion,
  Remarks__if_any__                                  AS remarks
FROM `your-project-id.session_feedback.PRIYA_FEEDBACK`

UNION ALL

SELECT
  Timestamp                                          AS response_time,
  Email_address                                      AS email,
  Branch                                             AS branch_name,
  Trainer                                            AS trainer_name,
  Name                                               AS student_name,
  Contact_No__                                       AS contact_no,
  Content_Covered_                                   AS content_covered,
  Task_Discussion_                                   AS task_discussion,
  Pace_of_the_session_                               AS pace_of_session,
  Interaction_Engagement_                            AS interaction_engagement,
  Overall_Experience_                                AS overall_experience,
  Please_share_your_suggestion_in_case_any_further_improvements_are_required_ AS suggestion,
  Remarks__if_any__                                  AS remarks
FROM `your-project-id.session_feedback.RIYA_FEEDBACK`
;

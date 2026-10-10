-- ============================================================================
-- TRAINER PERFORMANCE DASHBOARD | STEP 1 of 6: STAGING VIEWS (9)
-- Source: raw Google Sheets tables linked into BigQuery
-- Purpose: trim text fields, standardise column names, drop blank rows
-- Replace `your-project-id` and `trainer_performance` with your own
-- project ID and dataset name before running.
-- Run order: this file first, then 02 -> 06.
-- ============================================================================

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_attendance` AS
SELECT
  DATE                                               AS attendance_date,
  TRIM(TRAINER_ID)                                   AS trainer_id,
  TRIM(ATTENDANCE)                                   AS attendance_status,
  TRIM(ARRIVAL)                                      AS arrival_status,
  TRIM(LEAVE)                                        AS leave_type,
  `LOG IN`                                           AS log_in_time,
  `LOG OUT`                                          AS log_out_time
FROM `your-project-id.trainer_performance.ATTENDANCE`
WHERE TRAINER_ID IS NOT NULL AND TRIM(TRAINER_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_trainer_details` AS
SELECT
  TRIM(TRAINER_ID)                                   AS trainer_id,
  TRIM(TRAINER_NAME)                                 AS trainer_name,
  TRIM(BRANCH_NAME)                                  AS branch_name,
  JOINING_DATE                                       AS joining_date,
  SALARY                                             AS salary,
  EXPERIENCE                                         AS experience_years,
  TRIM(MOBILE)                                       AS mobile,
  TRIM(EMAIL)                                        AS email,
  TRIM(WORKING)                                      AS is_working
FROM `your-project-id.trainer_performance.TRAINER_DETAILS`
WHERE TRAINER_ID IS NOT NULL AND TRIM(TRAINER_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_batch` AS
SELECT
  TRIM(TRAINER_ID)                                   AS trainer_id,
  TRIM(BATCH_ID)                                     AS batch_id,
  TRIM(MODULE_ID)                                    AS starting_module_id,
  LOWER(TRIM(TYPE))                                  AS batch_type,
  START_DATE                                         AS start_date,
  START_TIME                                         AS start_time,
  LOWER(TRIM(MODE))                                  AS mode,
  TRIM(STATUS)                                       AS batch_status
FROM `your-project-id.trainer_performance.BATCH`
WHERE BATCH_ID IS NOT NULL AND TRIM(BATCH_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_demo` AS
SELECT
  DATE                                               AS demo_date,
  TRIM(TRAINER_ID)                                   AS trainer_id,
  `START TIME`                                       AS start_time,
  `END TIME`                                         AS end_time,
  TOTAL_DEMO                                         AS total_demo,
  CONVERSION                                         AS conversion,
  REFERENCE                                          AS reference_demo,
  REFERENCE_CONVERSION                               AS reference_conversion
FROM `your-project-id.trainer_performance.DEMO`
WHERE TRAINER_ID IS NOT NULL AND TRIM(TRAINER_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_session` AS
SELECT
  DATE                                               AS session_date,
  TRIM(TRAINER_ID)                                   AS trainer_id,
  TRIM(BATCH_ID)                                     AS batch_id,
  LOWER(TRIM(TYPE))                                  AS session_type,
  LOWER(TRIM(MODE))                                  AS mode,
  TRIM(MODULE_ID)                                    AS module_id,
  NO_OF_STUDENTS                                     AS no_of_students,
  STARTING_TIME                                      AS starting_time,
  DURATION_HOURS                                     AS duration_hours
FROM `your-project-id.trainer_performance.TODO_DS`
WHERE TRAINER_ID IS NOT NULL AND TRIM(TRAINER_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_student_trainer` AS
SELECT
  TRIM(STUDENT_ID)                                   AS student_id,
  TRIM(STUDENT_NAME)                                 AS student_name,
  TRIM(BATCH_ID)                                     AS batch_id,
  TRIM(TRAINER_ID)                                   AS trainer_id,
  TRIM(STATUS)                                       AS student_status,
  TRIM(COURSE_ID)                                    AS course_id
FROM `your-project-id.trainer_performance.Student_Trainer`
WHERE STUDENT_ID IS NOT NULL AND TRIM(STUDENT_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_course_trainer` AS
SELECT
  TRIM(COURSE_ID)                                    AS course_id,
  TRIM(COURSE_NAME)                                  AS course_name,
  TRIM(MODULE_ID)                                    AS module_id,
  TRIM(MODULE_NAME)                                  AS module_name,
  TRIM(TRAINER_ID)                                   AS trainer_id,
  TRIM(TRAINER_NAME)                                 AS trainer_name
FROM `your-project-id.trainer_performance.Course_Trainer`
WHERE MODULE_ID IS NOT NULL AND TRIM(MODULE_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_placements` AS
SELECT
  TRIM(STUDENT_ID)                                   AS student_id,
  TRIM(DESIGNATION)                                  AS designation,
  TRIM(COMPANY)                                      AS company,
  SALARY                                             AS placement_salary,
  JOINING_DATE                                       AS joining_date,
  TRIM(MODE)                                         AS mode,
  TRIM(REFERENCE)                                    AS reference
FROM `your-project-id.trainer_performance.Placements`
WHERE STUDENT_ID IS NOT NULL AND TRIM(STUDENT_ID) != '';

CREATE OR REPLACE VIEW `your-project-id.trainer_performance.stg_internship` AS
SELECT
  TRIM(STUDENT_ID)                                   AS student_id,
  JOINING_DATE                                       AS joining_date,
  TRIM(DESIGNATION)                                  AS designation,
  TRIM(COMPANY)                                      AS company,
  STIPEND                                            AS stipend,
  TRIM(DURATION)                                     AS duration,
  TRIM(MODE)                                         AS mode,
  TRIM(TRAINER_ID)                                   AS trainer_id
FROM `your-project-id.trainer_performance.Internship`
WHERE STUDENT_ID IS NOT NULL AND TRIM(STUDENT_ID) != '';

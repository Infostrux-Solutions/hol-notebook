/*
-- This script sets up a Snowflake environment for the IFF HOL event in Paris, March 2025.

-- 1. Switch to ORGADMIN role to create a new organization account.
-- 2. Create a new organization account named IFF_HOL_03_2025 with specified admin details and settings.
-- 3. Switch to ACCOUNTADMIN role to perform account-level operations.
-- 4. Create a new database named IFF_HOL_03_2025.
-- 5. Create two warehouses (WH_1_IFF_HOL_03_2025 and WH_2_IFF_HOL_03_2025) with specified configurations.
-- 6. Create a new role ROLE_IFF_HOL_03_2025 and grant ownership of the database and usage/operate permissions on the warehouses to this role.
-- 7. Grant permissions to create notebooks, Streamlit apps, and models on future schemas in the database to the role.
-- 8. Grant the new role to the SYSADMIN role and to the user FABIAN.
-- 9. Switch to the new role and create a schema named LAB within the database.
-- 10. Switch back to ACCOUNTADMIN role to create API and external access integrations.
-- 11. Create an API integration for GitHub with allowed prefixes and enable it.
-- 12. Create a Git repository in the LAB schema linked to the specified GitHub repository.
-- 13. Create a network rule for accessing PyPI and an external access integration using this rule.
-- 14. Grant usage on the external access integration and read access on the Git repository to the new role.
-- 15. Switch back to the new role to complete the setup.
*/
USE ROLE ORGADMIN;

CREATE ORGANIZATION ACCOUNT IFF_HOL_03_2025
    ADMIN_NAME = 'FABIAN'
    ADMIN_PASSWORD = '*****'
    FIRST_NAME = 'FABIAN'
    LAST_NAME = 'HERNANDEZ'
    EMAIL = 'fabian@infostrux.com'
    MUST_CHANGE_PASSWORD = TRUE
    EDITION = 'BUSINESS_CRITICAL'
    REGION = 'AWS_US_WEST_2'
    COMMENT = 'Snowflake account for IFF HOL in Paris-March, 2025';

USE ROLE ACCOUNTADMIN;

CREATE DATABASE IFF_HOL_03_2025;

CREATE WAREHOUSE WH_1_IFF_HOL_03_2025
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  WAREHOUSE_TYPE = 'STANDARD'
  MAX_CLUSTER_COUNT = 10
  MIN_CLUSTER_COUNT = 1
  SCALING_POLICY = 'STANDARD'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE WAREHOUSE WH_2_IFF_HOL_03_2025
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  WAREHOUSE_TYPE = 'STANDARD'
  MAX_CLUSTER_COUNT = 10
  MIN_CLUSTER_COUNT = 1
  SCALING_POLICY = 'STANDARD'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;
  
CREATE OR REPLACE ROLE ROLE_IFF_HOL_03_2025;
GRANT OWNERSHIP ON DATABASE IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT USAGE ON WAREHOUSE WH_1_IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT OPERATE ON WAREHOUSE WH_1_IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT USAGE ON WAREHOUSE WH_2_IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT OPERATE ON WAREHOUSE WH_2_IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT CREATE NOTEBOOK ON FUTURE SCHEMAS IN DATABASE IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT CREATE STREAMLIT ON FUTURE SCHEMAS IN DATABASE IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT CREATE MODEL ON FUTURE SCHEMAS IN DATABASE IFF_HOL_03_2025 TO ROLE ROLE_IFF_HOL_03_2025;
GRANT ROLE ROLE_IFF_HOL_03_2025 TO ROLE SYSADMIN;

-- User assignment.
GRANT ROLE ROLE_IFF_HOL_03_2025 TO USER FABIAN;

USE ROLE ROLE_IFF_HOL_03_2025;
CREATE SCHEMA IFF_HOL_03_2025.LAB; 

USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION iff_hol_03_2025_git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/Infostrux-Solutions/')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY IFF_HOL_03_2025.LAB.hol_iff
  API_INTEGRATION = iff_hol_03_2025_git_api_integration
  ORIGIN = 'https://github.com/Infostrux-Solutions/hol-notebook.git';

CREATE OR REPLACE NETWORK RULE pypi_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org',  'files.pythonhosted.org');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION pypi_access_integration
  ALLOWED_NETWORK_RULES = (pypi_network_rule)
  ENABLED = true;


GRANT USAGE ON INTEGRATION pypi_access_integration TO ROLE ROLE_IFF_HOL_03_2025;
GRANT READ ON GIT REPOSITORY IFF_HOL_03_2025.LAB.hol_iff TO ROLE ROLE_IFF_HOL_03_2025;



USE ROLE ROLE_IFF_HOL_03_2025;-- Deploy 
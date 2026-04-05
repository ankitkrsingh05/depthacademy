-- ============================================================================================================================
-- Schema: regions, countries, locations, departments, jobs, employees, dependents
-- ============================================================================================================================
--
-- SCHEMA REFERENCE
-- ─────────────────
--   regions        (region_id PK, region_name)
--   countries      (country_id PK, country_name, region_id FK)
--   locations      (location_id PK, street_address, postal_code, city, state_province, country_id FK)
--   departments    (department_id PK, department_name, location_id FK)
--   jobs           (job_id PK, job_title, min_salary, max_salary)
--   employees      (employee_id PK, first_name, last_name, email, phone_number,
--                   hire_date, job_id FK, salary, manager_id FK→employees, department_id FK)
--   dependents     (dependent_id PK, first_name, last_name, relationship, employee_id FK)
-- ============================================================================================================================


-- ============================================================================================================================
-- SECTION A — BASICS: SELECT, FROM, AS, DISTINCT  (Q1–Q20)
-- ============================================================================================================================

-- Q1.  The HR team needs a clean employee roster. Retrieve every column from the
--      employees table, but present employee_id as "ID", first_name as "First",
--      last_name as "Last", and salary as "Monthly Pay".

-- Q2.  Finance wants a payroll preview. For every employee, show their full name
--      as a single column "Full Name", their annual salary as "Annual Salary",
--      and an estimated tax burden column called "Tax Estimate" at 30% of annual salary.

-- Q3.  The IT team needs to audit email domains across the company. Display each
--      employee's ID, their full email, and just the domain portion of the email
--      (everything after the '@') in a column called "Email Domain".

-- Q4.  A workforce planner wants to know which role-department combinations are
--      actually staffed. List every unique pairing of job and department that
--      currently exists among employees, excluding rows where either value is missing.

-- Q5.  The recognition committee is preparing long-service awards. Show each
--      employee's name, their hire date, and the approximate number of complete
--      years they have worked for the company in a column called "Years of Service".

-- Q6.  The compensation team suspects some employees hold roles not formally
--      catalogued. Build a combined view of all job IDs seen in the employees table
--      alongside all job IDs defined in the jobs catalogue, clearly labelling
--      which table each came from.

-- Q7.  Management wants a human-readable summary line per employee for a printed
--      report. Produce a single column called "Employee Summary" that reads like:
--      "ID 101 | Steven King | Dept 90 | $24000.00"

-- Q8.  The benefits team is pulling a dependent register. Display all records from
--      the dependents table with friendlier column names: "Dep ID", "First",
--      "Last", "Relation", and "Emp ID".

-- Q9.  A regional analyst needs a country-to-region mapping. List every unique
--      combination of region and country, ordered by region first, then country.

-- Q10. The compensation committee is reviewing job pay structures. For every job,
--      display the title, the lowest and highest possible salary, the midpoint
--      salary, and how wide the salary band is. Label all columns clearly.

-- Q11. HR is standardising display names. For each employee, show their name and
--      a proposed system "Username" built from the first character of their
--      first name joined to their last name, all in lowercase.

-- Q12. Finance needs a quick view of take-home pay. For every employee show their
--      last name, current monthly salary, and an estimated monthly net pay after
--      deducting 35% for taxes and other deductions. Round to 2 decimal places.

-- Q13. The recruitment team wants to know the growth ceiling of each role.
--      For every job, show its title and the percentage by which max_salary
--      exceeds min_salary, labelled "% Growth Potential". Round to 1 decimal place.

-- Q14. A location audit is underway. Show all unique cities where the company
--      has offices, paired with the country code for that city, ordered
--      alphabetically by city name.

-- Q15. The facilities team needs a department-to-location index. List every
--      department name and its assigned location. Where no location is on record,
--      display the word 'Unassigned' rather than a blank.

-- Q16. The org-chart team needs to identify who the managers are. Retrieve all
--      distinct employee IDs that appear in the manager_id column (i.e., those
--      who manage at least one person). Exclude blanks, order ascending.

-- Q17. Show each employee's last name alongside a salary summary label in the format:
--      "Earns $X/month, $Y/year" where X is monthly salary and Y is annual salary.
--      Cast numbers to text as needed.

-- Q18. Payroll is reviewing job-level salary equity. Show the ratio of max_salary
--      to min_salary for every job, rounded to 2 decimal places, ordered from
--      the most compressed ratio to the widest.

-- Q19. A data quality team needs to know which employees are missing a phone number.
--      List the full name and email of every employee whose phone number is not on record.

-- Q20. The HR team wants a headcount snapshot by relationship type in the dependents
--      table. Show each distinct relationship and how long (in characters) that
--      relationship label is. Label the length column "Word Length".


-- ============================================================================================================================
-- SECTION B — FILTERING: WHERE, AND, OR, NOT, BETWEEN, IN, LIKE, IS NULL  (Q21–Q60)
-- ============================================================================================================================

-- Q21. The hiring team wants to study seasonal recruitment. Find all employees
--      who were hired during the first quarter (January through March) of any year.

-- Q22. The executive team defines "high earners" as anyone whose total annual
--      compensation exceeds 100,000. Identify all such employees.

-- Q23. A name-analysis project needs employees whose last name begins with any vowel.
--      Return their full name and department.

-- Q24. An academic study is looking at even-year hiring patterns.
--      Find all employees who joined the company in an even-numbered calendar year.

-- Q25. The sales compensation team wants to review outliers. Find all employees in
--      departments 50, 80, or 90 whose salary falls outside the range of 6000 to 12000.

-- Q26. The job evaluation committee flags roles where the pay band is extremely wide.
--      Find all jobs where the difference between max and min salary exceeds 10,000.

-- Q27. IT security needs to check for employees who have no phone number on file
--      but do have a manager — a combination that raises a data-completeness flag.

-- Q28. The location data team is cleaning records. Find all office locations that
--      have no state or province recorded and are not in the United States.

-- Q29. The culture team is studying whether hire day correlates with retention.
--      Find all employees who were hired on a Monday.

-- Q30. The compensation review board is looking at employees whose pay is very
--      close to the 8000 benchmark — within 10% either way. Identify them.

-- Q31. The naming committee is studying alliterative names for a fun internal
--      newsletter. Find employees whose first name and last name start with the
--      same letter (case-insensitive).

-- Q32. An international HR report needs countries with multi-word names.
--      Find all countries whose name contains a space character.

-- Q33. Data governance is auditing short phone numbers. Find all employees whose
--      phone number is recorded but contains fewer than 10 characters.

-- Q34. The family benefits team wants to find dependents who share the same last
--      name as the employee they belong to. List the employee's name, the
--      dependent's name, and their relationship.

-- Q35. The data integrity team suspects some employees reference a job that no
--      longer exists in the official jobs catalogue. Identify those employees.

-- Q36. A complex staffing review: find all employees in department 80 who joined
--      before 2005 and earn above 9000, plus all employees in department 90
--      regardless of salary. Combine into one result set.

-- Q37. The real estate team needs offices in countries whose name ends with the
--      letters 'ia'. Find all locations in those countries.

-- Q38. Finance is reviewing "clean" salary figures. Find all employees whose
--      monthly salary is a whole number evenly divisible by 1000.

-- Q39. A text analytics project is comparing email length to name length.
--      Find all employees whose email address is longer (in characters) than
--      their last name.

-- Q40. The executive search team wants senior roles visible in the job catalogue.
--      Find all jobs that contain either the word 'Vice' or the word 'Chief'
--      in the title (case-insensitive).

-- Q41. HR wants to study mid-month joining patterns. Find all employees whose
--      hire date falls on the last day of a calendar month.

-- Q42. An internal investigation needs to find employees who share both the same
--      department and the same manager as employee 101, excluding employee 101.

-- Q43. The board wants to know which employees earn more than every single employee
--      in department 60. Find them.

-- Q44. The strategy team needs to know if any region has no countries assigned
--      to it at all — a potential data gap. Find such regions.

-- Q45. The succession planning team defines "mid-level managers" as employees who
--      both have a manager above them AND have at least one person reporting to them.
--      Identify all such employees.

-- Q46. The payroll compliance team needs to flag employees who earn below the
--      minimum salary specified for their job role in the jobs catalogue.

-- Q47. The employee wellbeing team wants to identify employees who have a
--      spouse dependent AND at least one child dependent — a specific family profile
--      for a benefits programme. Find those employees.

-- Q48. Facilities is looking for offices in cities whose name contains the word 'South'.
--      Find those departments and their locations.

-- Q49. Find all employees whose hire date falls between the hire date of employee 100
--      and the hire date of employee 200 (exclusive of both endpoints).

-- Q50. The HR data team is checking for duplicate surnames — employees who share
--      their last name with at least one other employee. Find those employees.

-- Q51. Find all employees whose monthly salary, when divided by their employee_id,
--      gives a result greater than 100.

-- Q52. The analytics team wants to isolate employees hired only in recent years.
--      Find all employees who were NOT hired in any year from 2001 through 2005.

-- Q53. Security is auditing locations that are entirely missing address data.
--      Find all locations where both street_address and state_province are NULL.

-- Q54. A department audit is checking if any department's name begins with 'A'
--      or ends with 'g' (case-insensitive). Find employees in those departments.

-- Q55. The analytics team wants employees whose job no longer appears in the jobs
--      catalogue AND who belong to a department located in the United States.

-- Q56. Find all employees who earn above the average salary of their own job title
--      group (i.e., above the average salary of all employees sharing their job_id).

-- Q57. The payroll team needs to flag employees who have worked more than 10 years
--      AND still earn below 5000 per month.

-- Q58. Find all dependents whose first name appears more than once across the
--      entire dependents table (shared first names among dependents).

-- Q59. An accessibility audit needs employees without a recorded phone number
--      who also work in a department with more than 5 total employees.

-- Q60. Find all employees who were hired in the same calendar month and year as
--      at least one other employee (i.e., they share a hire cohort).


-- ============================================================================================================================
-- SECTION C — SORTING & LIMITING  (Q61–Q75)
-- ============================================================================================================================

-- Q61. The welcome team is preparing welcome-back gifts for the 10 most recently
--      hired employees. List them. Break any hire-date ties by employee ID descending.

-- Q62. The typesetting team needs names ordered by name length for a poster layout.
--      List all employees ordered by the length of their last name (longest first),
--      then alphabetically for names of equal length.

-- Q63. The compensation committee wants to spotlight the top 5 earners in the
--      mid-salary band (4000–7999). List them, highest salary first.

-- Q64. The benefits team needs a list ordered by how many dependents each employee
--      has, most dependents first. Employees with no dependents should appear last,
--      then sort by last name alphabetically within each group.

-- Q65. Leadership wants a league table of the 5 departments with the highest average
--      salary. Show department ID and average salary rounded to 2 decimal places.

-- Q66. The performance team wants to surface employees whose pay deviates the most
--      from the company average — either above or below. List all employees ordered
--      by absolute deviation from the company average, largest deviation first.

-- Q67. Compensation is reviewing pay band widths. List all jobs ordered from widest
--      salary band to narrowest. Break ties alphabetically by job title.

-- Q68. A report needs employees ranked 6th through 15th by their hire date
--      (oldest employees first). Use offset-based pagination to retrieve exactly those rows.

-- Q69. Produce a master employee list ordered by department (put employees with no
--      department at the very end), then within each department by salary descending,
--      then by last name alphabetically.

-- Q70. The branding team is building city name badges and needs cities ranked by
--      name length (longest first), then alphabetically for equal-length names.
--      Show only unique city names.

-- Q71. The long-service award panel needs the 5 employees with the earliest hire date.
--      Show their name, hire date, and approximate years of service.

-- Q72. HR is building an index sorted by the last 3 letters of each employee's surname.
--      List all employees in that order.

-- Q73. The compensation team is benchmarking job roles. List all jobs sorted by
--      their midpoint salary (halfway between min and max) from highest to lowest.

-- Q74. The executive dashboard needs the 3rd, 4th, and 5th highest-paid employees.
--      If multiple employees share the same salary at a boundary position,
--      include all of them.

-- Q75. HR wants a list where employees who report to someone appear before those
--      who do not (top-level executives last), and within each group, sorted by
--      salary descending.


-- ============================================================================================================================
-- SECTION D — AGGREGATE FUNCTIONS  (Q76–Q95)
-- ============================================================================================================================

-- Q76. The HR helpdesk wants to know: how many employees have a phone number on file,
--      and how many do not? Return both counts in a single row.

-- Q77. Finance needs a one-line payroll summary: total monthly payroll, total annual
--      payroll, average monthly salary, and the spread (standard deviation) of salaries
--      across the company.

-- Q78. The benefits team hypothesises that employees with dependents negotiate higher
--      salaries. Find the average salary of employees who have at least one dependent
--      versus those who have none, and show the difference between the two averages.

-- Q79. A data stewardship team needs to quantify the data quality problem.
--      Count how many distinct job IDs are referenced by employees but do not
--      exist in the official jobs catalogue.

-- Q80. The family benefits programme manager needs to know the average number of
--      dependents per employee across the whole company. Include employees with
--      zero dependents in the calculation. Round to 2 decimal places.

-- Q81. The job evaluation committee wants to identify the role with the narrowest
--      pay band. Return the job title and the band width (max minus min salary).

-- Q82. Finance is building a historical payroll trend. Show the total payroll cost
--      grouped by the year employees were hired, ordered chronologically.

-- Q83. Leadership wants to know the highest salary among employees who were hired
--      before the company's average hire date.

-- Q84. The HR analytics team needs a distribution snapshot. Count how many employees
--      earn strictly above the company average, strictly below it, and exactly equal
--      to it. Return all three counts in one row.

-- Q85. A bonus pool is set aside for the top 10 highest-paid employees.
--      What is the average salary within that group?

-- Q86. The total salary paid each month to the direct team of employee 100 is needed
--      for a budget review. Return that sum.

-- Q87. Actuarial is asking for the median salary across the entire company.
--      Return a single value.

-- Q88. Quality control wants to know how many employees have a salary that falls
--      within one standard deviation of the company mean — the "normal" earning band.

-- Q89. Which department has the single highest total monthly payroll?
--      Return the department ID and its total payroll in one row.

-- Q90. The recruitment calendar team wants to know hiring volume by month.
--      Count how many employees were hired in each calendar month (1 = January,
--      12 = December), across all years. Order by month number.

-- Q91. Show the average salary specifically for employees whose last name falls
--      alphabetically in the first half of the alphabet (A through M). Round to 2 dp.

-- Q92. The family benefits team needs a count of dependents per relationship type,
--      but only for employees who earn above 8000. Include only relationships
--      with at least one qualifying dependent.

-- Q93. Which job_id has the highest combined total of all its employees' salaries?
--      Return the job ID and the total.

-- Q94. The compliance team needs to know the ratio of max_salary to min_salary for
--      every job — how much higher the ceiling is than the floor. Round to 2 dp,
--      order from highest ratio to lowest.

-- Q95. What is the average salary of employees who have been with the company
--      longer than 15 years? Return a single rounded figure.


-- ============================================================================================================================
-- SECTION E — GROUP BY & HAVING  (Q96–Q115)
-- ============================================================================================================================

-- Q96.  The executive dashboard needs a per-department snapshot: headcount, average
--       salary, total payroll, lowest salary, highest salary, and salary spread.
--       Order by average salary descending.

-- Q97.  A management effectiveness review requires, for each manager: the number of
--       direct reports, the average salary of those reports, and the highest salary
--       among them. Exclude employees who have no manager. Order by team size descending.

-- Q98.  The recruitment planning team wants to see hiring volume broken down by year
--       and quarter. Show hire_year, hire_quarter (1–4), and headcount. Order chronologically.

-- Q99.  Compliance needs to know, per job role, whether every employee in that role
--       is paid within the job's official salary band. Flag each job as
--       'All Compliant' or 'Has Violations'.

-- Q100. The compensation team wants to surface departments with extreme pay inequality.
--       Find all departments where the gap between the highest and lowest salary
--       within that department exceeds 5000. Show department, min, max, and the gap.

-- Q101. A staffing model requires knowing every role-department pairing that has
--       more than one employee assigned. Show the pairing and its headcount.

-- Q102. The talent acquisition team wants to study strong hiring years. For each year,
--       show how many employees were hired and their average salary — but only for
--       years in which more than 5 people were hired.

-- Q103. The workforce optimisation team needs to flag managers whose teams are both
--       large (more than 5 direct reports) and underpaid (average below 6000).
--       Show manager ID, team size, and team average salary.

-- Q104. An equity audit asks: in which departments is the ratio of highest to lowest
--       salary greater than 1.5 (indicating significant pay disparity)?
--       Return department ID and the ratio, rounded to 2 decimal places.

-- Q105. Finance wants a payroll summary grouped by salary band:
--       Band 1 (<4000), Band 2 (4000–7999), Band 3 (8000–11999), Band 4 (≥12000).
--       Show headcount, total payroll, and average salary per band.

-- Q106. The real estate team needs to know which countries host more than one
--       company office location. Return country_id and location count.

-- Q107. The regional workforce report needs, for each world region: the number of
--       distinct countries represented, distinct office locations, and total
--       employee headcount. This spans all five related tables.

-- Q108. The turnover analysis team wants to know which departments have not hired
--       anyone recently — specifically, departments where the most recent hire was
--       before the year 2005.

-- Q109. Compensation analytics needs to flag job roles where the average salary of
--       employees in that role exceeds the job's own listed max_salary by more than
--       20%. This is a serious pay-band breach.

-- Q110. The family benefits programme team needs, per department, a count of how many
--       employees have registered at least one dependent. Order by count descending.

-- Q111. The recruitment team wants to celebrate the most popular hiring month.
--       Find the calendar month(s) in which the most employees were hired. If there
--       is a tie, include all tied months.

-- Q112. The compensation strategy team needs to see which departments pay above the
--       company average. For each department, show the gap between its average salary
--       and the company-wide average — but only return departments where this
--       gap is positive (i.e., above-average paying departments).

-- Q113. The space management team needs to know which office buildings house more
--       than one department. Find those locations and list the department IDs sharing them.

-- Q114. For each department, count how many employees earn at least 10% above their
--       own department's average salary. Show department ID and the count.

-- Q115. The global payroll dashboard needs a breakdown by region and hire year:
--       headcount and total payroll for each combination. This requires traversing
--       employees → departments → locations → countries → regions.


-- ============================================================================================================================
-- SECTION F — CASE WHEN  (Q116–Q127)
-- ============================================================================================================================

-- Q116. HR wants a tiered classification of employees for the annual review:
--       below 4000 → 'Tier 1', 4000–6999 → 'Tier 2', 7000–9999 → 'Tier 3',
--       10000–14999 → 'Tier 4', 15000 and above → 'Tier 5'.
--       In the same query, count how many employees fall into each tier.

-- Q117. The compensation team needs a compliance label per employee showing whether
--       they are paid below their role's minimum, within the band, or above the maximum.
--       The labels should be: 'Under Min', 'Within Band', 'Over Max'. Join to the jobs table.

-- Q118. The culture team is segmenting employees by the era in which they were hired
--       for a heritage campaign: before 2000 → 'Founding Era', 2000–2004 → 'Growth Era',
--       2005–2009 → 'Expansion Era', 2010 onwards → 'Modern Era'. Count employees
--       in each era in the same query.

-- Q119. The benefits eligibility system needs a family-size label per employee:
--       0 dependents → 'Single', 1 → 'Small Family', 2–3 → 'Family', 4 or more → 'Large Family'.
--       Use the dependents data to determine each employee's count.

-- Q120. The finance team defines budget impact based on where an employee sits in the
--       company salary distribution: top 10% → 'High Impact', bottom 10% → 'Low Impact',
--       everyone else → 'Standard'. Derive the thresholds from the data itself.

-- Q121. The workforce report needs a per-department headcount split by seniority:
--       'Junior' (below 5000), 'Mid' (5000–9999), 'Senior' (10000 and above).
--       Show department_id, junior_count, mid_count, senior_count — one row per department.

-- Q122. The business continuity team wants to flag departments by staffing risk:
--       1 employee → 'High Risk', 2–3 → 'Medium Risk', 4 or more → 'Low Risk'.
--       Show this risk label per employee based on how many people are in their department.

-- Q123. The job catalogue team needs a market positioning label for each role:
--       max_salary above 20000 → 'Executive Level', above 10000 → 'Professional Level',
--       above 5000 → 'Support Level', otherwise → 'Entry Level'.

-- Q124. A salary compliance audit needs counts by outcome. Label each employee as
--       'Under Min', 'Within Band', or 'Over Max' (relative to their job's band),
--       then group by that label to show how many employees fall into each category
--       and the average salary per category.

-- Q125. The global mobility team needs each employee's region labelled:
--       region_id 1 → 'Americas', 2 → 'Europe', 3 → 'Asia', 4 → 'Middle East & Africa',
--       anything else → 'Unknown'. This requires joining through departments, locations,
--       countries, and regions.

-- Q126. The talent analytics team wants to know what share of each department is made
--       up of high earners (salary ≥ 10000). For each department, calculate the
--       percentage of staff in that bracket. Round to 1 decimal place.

-- Q127. The promotion eligibility tool needs a flag per employee:
--       'Eligible' if they have been in the company more than 3 years AND their salary
--       is still below their job's ceiling.
--       'Maxed Out' if their salary equals or exceeds the job's maximum.
--       'Too New' if they have been here 3 years or fewer and are below the ceiling.


-- ============================================================================================================================
-- SECTION G — JOINS  (Q128–Q155)
-- ============================================================================================================================

-- Q128. The global directory needs every employee's full name, department name,
--       job title, city, country name, and region name on one row. Order by region,
--       country, then department.

-- Q129. The org chart tool needs every employee shown alongside their manager's
--       full name, department, and salary. Employees without a manager must
--       still appear in the output.

-- Q130. The pay equity report needs each employee's name, their own salary, and
--       the average salary of their department — all in one row.
--       Use a derived table rather than a window function.

-- Q131. The real estate dashboard needs each department's name, city, and country,
--       plus a headcount. Departments with no employees at all must still appear.

-- Q132. Workforce planning needs to know which employees hold a job role that is
--       also held by someone in a completely different department. Show the employee,
--       their job title, and their department.

-- Q133. The compensation benchmarking sheet needs each employee's name, their salary,
--       the min and max salary defined for their job, and their salary as a
--       percentage of the job's maximum. Round to 1 decimal place.

-- Q134. The buddy system matching team needs all pairs of employees who share the
--       same manager AND the same department. Show both employee IDs and names.
--       Each pair should appear only once.

-- Q135. The employee profile page needs each person's name and a single comma-separated
--       string listing all their dependents' relationships (e.g., "Child, Spouse").
--       Employees with no dependents should show NULL or an empty value.

-- Q136. The tenure integrity team suspects some employees were hired before their
--       own manager. Find those employees, and show both the employee's and
--       the manager's hire date for comparison.

-- Q137. The department snapshot card needs the department name, the name and salary
--       of the highest-paid employee in that department, and the name and salary
--       of the lowest-paid employee. Each department should appear on one row.

-- Q138. The internal mobility team needs to find employees who work in the same
--       city as their manager. Return both names and the shared city.

-- Q139. A cross-departmental skills audit needs all job roles that have at least
--       one employee in department 80 AND at least one in department 50.
--       Return those job IDs (or titles).

-- Q140. The facilities dashboard needs every office location, how many departments
--       are based there, and the total number of employees across all those departments.
--       Include locations with zero departments.

-- Q141. Leadership is concerned about inverted pay hierarchies. Find all employees
--       who earn more than their direct manager. Show both names and both salaries.

-- Q142. The enhanced benefits programme targets employees with more than 2 dependents
--       who also work in departments where average pay exceeds 6000. Find them.

-- Q143. The family benefits team needs a personalised letter for employees with
--       exactly one dependent. Show the employee's name, the dependent's name,
--       and their relationship.

-- Q144. The management reporting tool needs each manager's full name, department,
--       and all of their direct reports' names concatenated into a single column.

-- Q145. The HR data quality team needs to find employees whose job_id points to a
--       role that no longer exists in the jobs catalogue. Show the employee and
--       the orphaned job_id.

-- Q146. The regional executive report needs, per region: total employees, total
--       payroll, and the name and salary of the single highest-paid employee in
--       that region.

-- Q147. The country infrastructure report needs all countries that have at least
--       2 company office locations within them. Show country name and location count.

-- Q148. A name-matching curiosity: find all employees who share their last name
--       with one of their own dependents. Show the employee, the dependent, and
--       the relationship.

-- Q149. The span-of-control report needs each manager's name, how many employees
--       they directly manage, and how many distinct departments those employees
--       belong to.

-- Q150. For each employee, the peer benchmarking tool shows how many colleagues in
--       the same department earn strictly more than they do. Label this
--       "Colleagues Earning More".

-- Q151. The reporting line tool needs a 3-level org chain per employee:
--       the employee, their direct manager, and their manager's manager.
--       Where a level does not exist, display NULL.

-- Q152. The department family benefits report needs, per department, the average
--       salary of employees who have dependents and separately the average salary
--       of those who do not — both values on the same row per department.

-- Q153. The workforce planning team wants all jobs where the ceiling salary is at
--       least double the floor salary, plus the current headcount in each such role.

-- Q154. The dual-role analysis team needs all employees who both manage others
--       AND have at least one dependent themselves. Show their name, their count of
--       direct reports, and their count of dependents.

-- Q155. For each job title, find the employee in that job who has been in the company
--       the longest. Show the job title, the employee's name, and their hire date.


-- ============================================================================================================================
-- SECTION H — SET OPERATIONS: UNION, INTERSECT  (Q156–Q163)
-- ============================================================================================================================

-- Q156. The company contact directory combines staff and their registered family members.
--       Build a unified name list with full name, email (NULL for dependents), and a
--       column labelling each row as 'Employee' or 'Dependent'. Order by last name, then first.

-- Q157. The name-overlap team wants all last names that appear in both the employees
--       and dependents tables, along with how many times each appears in each table.

-- Q158. A data reconciliation task needs all department IDs that appear in the
--       employees table combined with all department IDs that exist in the departments
--       table, labelled by source. This surfaces staffed vs. unstaffed departments.

-- Q159. Using set logic, find all department IDs that simultaneously satisfy:
--       (a) have more than 3 employees, AND (b) have an average salary above 6000.
--       Express each condition as a separate query and combine them.

-- Q160. Build a full name pool from both employees and dependents (including duplicates).
--       Then identify names that appear more than once across both tables — these
--       may represent family members also employed by the company.

-- Q161. The job catalogue clean-up team needs a list of all job IDs that exist in
--       the official catalogue but currently have no employees assigned to them.

-- Q162. Using set logic, find all employees who satisfy all three of these criteria:
--       (a) salary above 6000, (b) department is 50, 80, or 90,
--       (c) hire date before 2006. Express each as a separate query and intersect them.

-- Q163. The payroll reconciliation team needs every combination of (manager_id, department_id)
--       that appears in the employees table combined with every (manager_id, department_id)
--       that appears in a subquery of employees earning above 8000. Label each source.
--       This helps identify high-earning clusters by management chain.


-- ============================================================================================================================
-- SECTION I — SUBQUERIES  (Q164–Q183)
-- ============================================================================================================================

-- Q164. Find the employee who earns the highest salary in the company.

-- Q165. Find all employees who earn more than the company average salary.

-- Q166. Find all employees who work in the same department as employee 103.

-- Q167. Find all employees who earn more than every employee in department 60.

-- Q168. List all employees who have at least one dependent registered.

-- Q169. List all employees who have no dependents registered.

-- Q170. Find all employees who work in a department located in the United States.

-- Q171. Find all employees whose salary equals the minimum salary in the whole company.

-- Q172. Find the job title that has the highest maximum salary in the jobs catalogue.

-- Q173. Find all employees who report directly to the employee with no manager
--       (i.e., the top-level executive).

-- Q174. Find all employees whose salary is strictly between the company's average
--       salary and the company's maximum salary.

-- Q175. Find all departments that have at least one employee earning above 10000.

-- Q176. Find all job roles (from the jobs table) that currently have no employees
--       assigned to them.

-- Q177. Find the employee with the second highest salary in the company.

-- Q178. Find all employees whose salary is higher than the average salary of their
--       own department.

-- Q179. For each employee, find out how many other employees share their department.
--       Show the employee's name, department_id, and that count.

-- Q180. Find all employees who earn the same salary as at least one other employee
--       in a different department.

-- Q181. Find all employees whose manager earns less than they do.

-- Q182. Find all employees whose salary is within 500 of the company average salary
--       (either above or below).

-- Q183. Find all employees who were hired after the most recently hired employee
--       in department 90.


-- ============================================================================================================================
-- SECTION I (EXTENDED) — COMMON SQL INTERVIEW QUESTIONS  (Q184–Q200)
-- ============================================================================================================================

-- Q184. [INTERVIEW] What is the difference between WHERE and HAVING?
--       Demonstrate using the employees table: write two queries — one using WHERE
--       to filter individual employee rows by salary, and one using HAVING to filter
--       departments by their average salary. Explain when each is appropriate.

-- Q185. [INTERVIEW] What is the difference between RANK(), DENSE_RANK(), and ROW_NUMBER()?
--       Demonstrate all three on the employees table ordered by salary descending.
--       Find rows where RANK and DENSE_RANK give different values — what does that tell you?

-- Q186. [INTERVIEW] How do you find duplicate records in a table?
--       Using the employees table, find all last names that appear more than once.
--       Then extend your answer: find all employees who share both their last name
--       and their department with another employee.

-- Q187. [INTERVIEW] How do you find the Nth highest salary?
--       Write a query to find the 3rd highest salary in the company without
--       using window functions. Then write the same query using a window function.
--       Which approach is more robust when there are ties?

-- Q188. [INTERVIEW] What is the difference between INNER JOIN, LEFT JOIN, and FULL OUTER JOIN?
--       Using the employees and dependents tables, write three queries — one for each
--       join type — and explain what rows each one includes that the others do not.

-- Q189. [INTERVIEW] How do you delete duplicate rows while keeping one?
--       First, identify which employee IDs have more than one dependent with the
--       same relationship type — a form of duplication. Write the SELECT that would
--       detect these. (Do not actually delete — just identify.)

-- Q190. [INTERVIEW] What is a self join and when would you use it?
--       Using the employees table, show each employee alongside their manager's name.
--       Then extend: show all employees who earn more than their manager.

-- Q191. [INTERVIEW] What is the difference between UNION and UNION ALL?
--       Using the employees and dependents tables, demonstrate both. Then explain
--       a real scenario (in this HR system) where UNION ALL would be preferred over UNION.

-- Q192. [INTERVIEW] How do you calculate a running total in SQL?
--       Show the running total of salaries in the employees table, ordered by hire date.
--       Explain what changes if you partition the running total by department.

-- Q193. [INTERVIEW] What is a correlated subquery and how does it differ from a regular subquery?
--       Write a query using a correlated subquery to find all employees who earn above
--       the average salary of their own department. Then rewrite it using a JOIN
--       to a derived table. Which is more efficient and why?

-- Q194. [INTERVIEW] How do you pivot data in SQL without a PIVOT keyword?
--       The HR team wants a single-row summary per department showing the count of
--       employees in each salary band (Junior <5000, Mid 5000–9999, Senior 10000+)
--       as separate columns. Write this using conditional aggregation.

-- Q195. [INTERVIEW] What does NULL mean in SQL, and how does it affect comparisons?
--       Write three queries using the employees table:
--       (a) Find employees with no manager using IS NULL.
--       (b) Demonstrate that salary = NULL returns no rows (and explain why).
--       (c) Use COALESCE to replace NULL manager_id with the text 'No Manager'.

-- Q196. [INTERVIEW] How do you find employees who appear in one dataset but not another?
--       Find all employees who have NO dependents. Write this three ways:
--       (a) using LEFT JOIN with a NULL check,
--       (b) using NOT IN with a subquery,
--       (c) using NOT EXISTS.

-- Q197. [INTERVIEW] What is the difference between a subquery in the SELECT clause
--       vs. a subquery in the FROM clause (derived table)?
--       Using the employees table, retrieve each employee's salary alongside the
--       company average — first by placing the subquery in SELECT, then by using a
--       derived table in FROM joined to the employees table.

-- Q198. [INTERVIEW] How would you write a query to detect data quality issues?
--       The HR database may have the following problems. Write a separate query
--       to detect each one:
--       (a) Employees with a salary outside their job's defined min–max band.
--       (b) Employees whose department_id does not exist in the departments table.
--       (c) Dependents whose employee_id does not exist in the employees table.

-- Q199. [INTERVIEW] What is the difference between COUNT(*), COUNT(column), and COUNT(DISTINCT column)?
--       Demonstrate all three on the employees table using the manager_id column.
--       Explain what each one counts and why they may return different numbers.

-- Q200. [INTERVIEW] How do you optimise a slow SQL query?
--       Given the following slow scenario: "find all employees earning above their
--       department average, joining to departments, locations, and jobs" — write
--       the query first using correlated subqueries (slow), then rewrite it using
--       CTEs or derived tables (faster). Describe what makes the second version
--       more efficient.


-- ============================================================================================================================
-- SECTION J — COMMON TABLE EXPRESSIONS  (Q201–Q212)
-- ============================================================================================================================

-- Q201. The HR leadership team needs a department health report. For each department,
--       they want the name (from the departments table), headcount, average salary,
--       total monthly payroll, and salary standard deviation — but only for departments
--       with at least 3 employees. The final output should be sorted by average
--       salary descending. Structure your solution in clearly labelled stages.

-- Q202. The people analytics team is building an attrition risk model. An employee
--       is flagged "At Risk" if they satisfy all three of the following:
--       they earn below their department's average salary,
--       they have been with the company for more than 5 years, and
--       they have no registered dependents.
--       Return the employee's name, department, salary, the department average,
--       and their years of service. Build your solution step by step.

-- Q203. Finance needs a payroll share report. For each department, show the department
--       name and what percentage of the total company payroll it accounts for.
--       Show only departments whose share exceeds 10%. Structure the calculation
--       in logical steps before presenting the final result.

-- Q204. The succession planning team needs a 3-level organisational hierarchy report.
--       Show each person's name and their position in the hierarchy:
--       Level 1 are those with no manager (the root),
--       Level 2 report directly to Level 1,
--       Level 3 report to Level 2.
--       Include the name of the person's manager at each level.
--       Build this incrementally rather than in a single complex query.

-- Q205. The performance review system needs the top 2 earners per department.
--       Where two employees share the same salary, both should be considered for
--       a position. Break ties using employee_id. Show department, employee name,
--       salary, and their rank within the department.

-- Q206. The retention programme has a three-step eligibility check. An employee
--       qualifies for the programme if:
--       Step 1: they have at least one registered dependent.
--       Step 2: among those, they earn above their department's average salary.
--       Step 3: among those, their manager is also an employee with at least one dependent.
--       Return the qualifying employees' names, their salary, and their dependent count.

-- Q207. The board has asked for a "payroll efficiency" metric per department,
--       defined as total monthly payroll divided by headcount squared.
--       A lower number means payroll is more evenly distributed.
--       Rank all departments by this metric from most efficient to least.
--       Show department ID, headcount, total payroll, and the metric value.

-- Q208. The compensation committee wants to identify the top quartile of earners in
--       the company. Show only those employees, along with their name, salary,
--       and department. Do not hard-code a salary threshold — derive it from the data.

-- Q209. The management analytics team needs to know, for each manager, the average
--       gap between the manager's own salary and each of their direct report's
--       salaries. A large positive gap means the manager earns significantly more.
--       Show the manager's name, their salary, the average gap, and how many
--       people they manage. Sort by average gap descending.

-- Q210. The job compliance team needs a full audit. For each employee, show whether
--       their salary falls below their job's minimum, within the band, or above
--       the maximum. Then summarise: show how many employees fall into each
--       compliance category and the average salary per category.
--       Produce both the row-level detail and the summary — use a structured approach.

-- Q211. The global workforce report needs a cross-region breakdown. For each region,
--       show the region name, the total number of employees, the total payroll,
--       and the name and salary of the single highest-paid employee in that region.
--       This requires connecting employees all the way through to regions.
--       Structure the solution in clearly named stages.

-- Q212. CAPSTONE — The CHRO (Chief Human Resources Officer) has requested a single
--       comprehensive workforce analytics dashboard. For every employee, the report
--       must show:
--       (a) their full name and department name,
--       (b) their salary ranked across the entire company,
--       (c) their salary ranked within their own department,
--       (d) their salary ranked within their region (via the full location chain),
--       (e) the running total of payroll within their department as you move from
--           the highest earner to the lowest,
--       (f) their salary as a percentage of their department's total payroll,
--       (g) the salary of the next-highest earner in their department, and
--       (h) a label: 'Top 10%' if they are in the top 10% of earners company-wide,
--           otherwise 'Standard'.
--       Build the solution in clearly separated, named stages. Each stage should
--       have a single, clear purpose.

-- ============================================================================================================================
-- END
-- ============================================================================================================================

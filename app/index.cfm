<cfquery datasource="employees" name="topTenEmployees">
    SELECT *
    FROM employees
    ORDER BY last_name DESC, first_name ASC
    LIMIT 10
</cfquery>

<cfdump var="#topTenEmployees#">
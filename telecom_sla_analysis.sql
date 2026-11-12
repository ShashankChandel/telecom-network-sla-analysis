
SELECT
    Region,
    Total_Tickets,
    Resolved_Tickets,
    ROUND(100.0 * Resolved_Tickets / Total_Tickets, 2)
        AS Resolution_Rate,
    SLA_Target,
    CASE
        WHEN 100.0 * Resolved_Tickets / Total_Tickets >= SLA_Target
        THEN 'Met'
        ELSE 'Breached'
    END AS SLA_Status
FROM regional_sla
ORDER BY Resolution_Rate ASC;
WITH monthly_metrics AS (
    SELECT
        strftime('%Y-%m', Created_At) AS Month,
        COUNT(*) AS Total_Closed_Incidents,
        SUM(CASE WHEN SLA_Status = 'Breached' THEN 1 ELSE 0 END)
            AS SLA_Breaches,
        SUM(CASE WHEN SLA_Status = 'Met' THEN 1 ELSE 0 END)
            AS SLA_Met
    FROM incidents
    WHERE Status = 'Closed'
    GROUP BY strftime('%Y-%m', Created_At)
)
SELECT
    Month,
    Total_Closed_Incidents,
    SLA_Breaches,
    SLA_Met,
    ROUND(100.0 * SLA_Met / Total_Closed_Incidents, 2)
        AS SLA_Compliance_Pct
FROM monthly_metrics
ORDER BY Month;
SELECT
    Root_Cause,
    COUNT(*) AS Total_Closed_Incidents,
    SUM(CASE WHEN SLA_Status = 'Breached' THEN 1 ELSE 0 END)
        AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE WHEN SLA_Status = 'Breached' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS Breach_Rate_Pct,
    ROUND(AVG(Resolution_Hours), 2) AS Avg_MTTR_Hours
FROM incidents
WHERE Status = 'Closed'
GROUP BY Root_Cause
ORDER BY Breach_Rate_Pct DESC;
WITH regional_metrics AS (
    SELECT
        Region,
        COUNT(*) AS Total_Closed_Incidents,
        SUM(CASE WHEN SLA_Status = 'Breached' THEN 1 ELSE 0 END)
            AS SLA_Breaches,
        ROUND(
            100.0 * SUM(CASE WHEN SLA_Status = 'Met' THEN 1 ELSE 0 END)
            / COUNT(*), 2
        ) AS SLA_Compliance_Pct,
        ROUND(AVG(Resolution_Hours), 2) AS Avg_MTTR_Hours
    FROM incidents
    WHERE Status = 'Closed'
    GROUP BY Region
)
SELECT
    Region,
    Total_Closed_Incidents,
    SLA_Breaches,
    SLA_Compliance_Pct,
    Avg_MTTR_Hours,
    RANK() OVER (ORDER BY SLA_Compliance_Pct DESC)
        AS SLA_Performance_Rank
FROM regional_metrics
ORDER BY SLA_Performance_Rank;

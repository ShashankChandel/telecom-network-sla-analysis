
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

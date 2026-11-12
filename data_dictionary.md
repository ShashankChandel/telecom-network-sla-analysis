# Telecom Network SLA & Outage Intelligence
## Data Dictionary

This project uses a synthetic dataset of 5,000 telecom incident records.

| Column | Data Type | Description |
|---|---|---|
| Incident_ID | String | Unique identifier assigned to an incident |
| Created_At | Datetime | Date and time when the incident was created |
| Acknowledged_At | Datetime | Date and time when the incident was acknowledged |
| Resolved_At | Datetime | Date and time when the incident was resolved; may be missing for open incidents |
| Region | String | Geographic region associated with the incident |
| Service_Type | String | Telecom service associated with the incident |
| Severity | String | Incident priority category (P1–P4) |
| Root_Cause | String | Recorded or simulated cause category of the incident |
| SLA_Target_Hours | Integer | Assumed SLA resolution target in hours |
| Resolution_Hours | Float | Incident resolution duration in hours; missing for unresolved incidents |
| Customers_Affected | Integer | Simulated number of customers affected by the incident |
| Repeat_Incident | String | Simulated repeat-incident indicator (Yes/No) |
| Status | String | Incident status (Open/Closed) |
| SLA_Status | String | SLA classification (Met, Breached, or the applicable open-ticket category) |

## Dataset Notes

- All records are synthetic and intended for portfolio demonstration.
- SLA targets are illustrative assumptions, not actual customer contract terms.
- Customers_Affected represents simulated incident-level counts, not unique customers.
- Repeat_Incident is a simulated label and should not be interpreted as verified historical recurrence.
- Resolution fields may be missing when an incident has not been resolved.
- SLA compliance calculations should clearly state whether they include only closed incidents.

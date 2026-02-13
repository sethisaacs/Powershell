# This performs a GET request for Snipe_IT built in DB column names and custom field column names
# Replace SNIPEURL with company Snipe-IT URL, keep /api.... and everything after
# Replace TOKEN with API Key
# Replace c:\path\to\file with save location

# Custom Fields
Invoke-RestMethod -Uri "SNIPEURL/api/v1/fields" -Method Get -Headers @{"Authorization" = "Bearer TOKEN"; "Accept" = "application/json"} | Select-Object -ExpandProperty rows | Select-Object name, db_column_name | Export-Csv -Path "c:\path\to\file" -NoTypeInformation

# Built-in column names
Invoke-RestMethod -Uri "SNIPEURL/api/v1/hardware?limit=1" -Method Get -Headers @{"Authorization" = "Bearer TOKEN"; "Accept" = "application/json"} | Select-Object -ExpandProperty rows | Get-Member -MemberType NoteProperty | Select-Object Name

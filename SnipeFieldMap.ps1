# Replace SNIPEURL with company Snipe-IT URL, keep /api.... and everything after
# Replace TOKEN with API Key
# Replace c:\path\to\file with save location


Invoke-RestMethod -Url "SNIPEURL/api/v1/fields" -Method Get -Headers @{"Authorization" = "Bearer TOKEN"; "Accept" = "application/json"} | Select-Object -ExpandProperty rows | Select-Object name, db_column_name | Export-Csv -Path "c:\path\to\file" -NoTypeInformation

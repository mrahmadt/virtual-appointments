



function createEvent ($userIDorPrincipalName, $access_token, $startDateTime, $endDateTime, $subject, $body, $attendees) {
    try {
    $utc_startDateTime = $startDateTime.ToString('yyyy-MM-ddTHH:mm:ss')
    $utc_endDateTime = $endDateTime.ToString('yyyy-MM-ddTHH:mm:ss')
    #2020-04-06T16:00:00
    
    $attendees_json = ""
    foreach($attendee in $attendees.Split(";"))
    {
        $attendees_json += ',{"emailAddress": {"address": "'+$attendee.trim()+'"},"type": "required"}'
    }

    #Create Event
    $newEventApiUrl = ("https://graph.microsoft.com/v1.0/users/$userIDorPrincipalName/calendar/events")
$Body = @"
{
    "subject": "$subject",
    "body": {
        "contentType": "HTML",
        "content": "$body"
    },
    "onlineMeetingUrl": "https://meet.lync.com/example/joyce/NLSD7Y62",
    "start": {
        "dateTime": "$utc_startDateTime",
        "timeZone": "$timeZone"
    },
    "end": {
        "dateTime": "$utc_endDateTime",
        "timeZone": "$timeZone"
    },
    "attendees": [
        {
            "emailAddress": {"address": "$userIDorPrincipalName"},
            "type": "required"
        }$attendees_json
    ],
    "isOnlineMeeting": true,
    "onlineMeetingProvider": "teamsForBusiness"
}
"@

        $newEvent = Invoke-RestMethod -Headers @{Authorization = "Bearer $($access_token)" } -Uri $newEventApiUrl -Body $Body -Method Post -ContentType 'application/json'
    } catch {
        Write-Error -Message "Create Event error! $PSItem"
        exit
    }
    return $newEvent
}

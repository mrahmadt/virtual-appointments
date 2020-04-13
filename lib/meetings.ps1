



function onlineMeetings ($access_token, $startDateTime, $endDateTime) {
    #startDateTime 	DateTime 	The meeting start time in UTC.
    #endDateTime 	DateTime 	The meeting end time in UTC.
    #subject 	String 	The subject of the online meeting.
    
    # Convert to UTC
    $utc_startDateTime = ($startDateTime.ToUniversalTime()).ToString('o')
    $utc_endDateTime = ($endDateTime.ToUniversalTime()).ToString('o')

    try {
        #Create Online meeting
        $onlineMeetingsApiUrl = ("https://graph.microsoft.com/v1.0/me/onlineMeetings")
$Body = @"
        {
            "startDateTime":"$utc_startDateTime",
            "endDateTime":"$utc_endDateTime",
            "subject":"My Meeting"
        }
"@
        $newMeeting = Invoke-RestMethod -Headers @{Authorization = "Bearer $($access_token)" } -Uri $onlineMeetingsApiUrl -Body $Body -Method Post -ContentType 'application/json'
    } catch {
        Write-Error -Message "onlineMeetings error! $PSItem"
        exit
    }
    return $newMeeting
}

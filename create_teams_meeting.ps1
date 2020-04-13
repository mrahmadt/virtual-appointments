<#
DISCLAIMER: 
----------------------------------------------------------------
This sample is provided as is and is not meant for use on a production environment.
It is provided only for illustrative purposes. The end user must test and modify the
sample to suit their target environment. 

We can make no representation concerning the content of this sample. We are
providing this information only as a convenience to you. This is to inform you that
We have not tested the sample and therefore cannot make any representations 
regarding the quality, safety, or suitability of any code or information found here.    
#>
#-------------------------Script Setup-------------------------#

try {
    . .\config.ps1
    . .\templates.ps1
    . .\lib\auth.ps1
    . .\lib\meetings.ps1
    . .\lib\events.ps1
    . .\lib\misc.ps1
} catch {
    Write-Error -Message "Error $PSItem"
    exit
}

try {
    $Tokens = authMe
    $joinUrl = ''
    $results = @()
    Import-Csv $locationsAppointmentsFile | Foreach-Object { 
        Write-Host "Processing $($_.clientMobile)... $input_datetime_format -> $($_.startDateTime) - $($_.endDateTime)"
        $startDateTime = [datetime]::ParseExact($_.startDateTime,$input_datetime_format,$null)
        $endDateTime = [datetime]::ParseExact($_.endDateTime,$input_datetime_format,$null)

        $custom_subject = strreplace $email_subject $_ $joinUrl
        #$custom_subject = $email_subject
        #$custom_subject = $custom_subject.replace('%clientMobile',$_.clientMobile)
        #$custom_subject = $custom_subject.replace('%startDateTime',$_.startDateTime)
        #$custom_subject = $custom_subject.replace('%endDateTime',$_.endDateTime)
        #$custom_subject = $custom_subject.replace('%data1',$_.data1)
        #$custom_subject = $custom_subject.replace('%data2',$_.data2)
        #$custom_subject = $custom_subject.replace('%data3',$_.data3)
        #$custom_subject = $custom_subject.replace('%data4',$_.data4)

        $custom_body = strreplace $email_body $_ $joinUrl
        #$custom_body = $email_body
        #$custom_body = $custom_body.replace('%clientMobile',$_.clientMobile)
        #$custom_body = $custom_body.replace('%startDateTime',$_.startDateTime)
        #$custom_body = $custom_body.replace('%endDateTime',$_.endDateTime)
        #$custom_body = $custom_body.replace('%data1',$_.data1)
        #$custom_body = $custom_body.replace('%data2',$_.data2)
        #$custom_body = $custom_body.replace('%data3',$_.data3)
        #$custom_body = $custom_body.replace('%data4',$_.data4)


        $attendees = ($_.attendees).trim();

        if($send_email -eq 0) {
            $useEventAPI = 0
        }else{
            $useEventAPI = 1
            if ($attendees -eq "" -and $useEventAPI_even_if_no_attendees -eq 0){
                $useEventAPI = 0
            }
        }

        if($useEventAPI) {
            Write-Output "Sending meeting request  $attendees..."
            $newEvent = createEvent $Tokens.UserName  $Tokens.AppToken.access_token $startDateTime $endDateTime  $custom_subject  $custom_body $attendees
            $joinUrl = $newEvent.onlineMeeting.joinUrl
        } else {
            Write-Output "Creating meeting request..."
            $newMeeting = onlineMeetings $Tokens.UserToken.access_token $startDateTime $endDateTime
            $joinUrl = $newMeeting.joinUrl
        }

        $custom_sms = strreplace $sms_body $_ $joinUrl
        #$custom_sms = $sms_body
        #$custom_sms = $custom_sms.replace('%clientMobile',$_.clientMobile)
        #$custom_sms = $custom_sms.replace('%startDateTime',$_.startDateTime)
        #$custom_sms = $custom_sms.replace('%endDateTime',$_.endDateTime)
        #$custom_sms = $custom_sms.replace('%data1',$_.data1)
        #$custom_sms = $custom_sms.replace('%data2',$_.data2)
        #$custom_sms = $custom_sms.replace('%data3',$_.data3)
        #$custom_sms = $custom_sms.replace('%data4',$_.data4)
        #$custom_sms = $custom_sms.replace('%teamsUrl',$joinUrl)

        $details = @{            
            mobile             = $_.clientMobile              
            startDateTime     = $_.startDateTime                 
            endDateTime      = $_.endDateTime
            sms      = $custom_sms
            teamsUrl      = $joinUrl
            subject     = $custom_subject
            body = $custom_body
            data1             = $_.data1              
            data2     = $_.data2                 
            data3      = $_.data3
            data4      = $_.data4
        }
        $results += New-Object PSObject -Property $details
    }
    Write-Output "Saving data to  $locationsSMSFile ..."
    $results | Select-Object "mobile",  "sms", "teamsUrl", "startDateTime", "endDateTime", "subject", "body", "data1", "data2", "data3", "data4" | export-csv -Path $locationsSMSFile -NoTypeInformation
} catch {
    Write-Error -Message "Error $PSItem"
    exit
}



#Path of the appointments CSV file. (Columns expected: clientMobile	startDateTime	endDateTime	attendees	data1	data2	data3	data4)
$locationsAppointmentsFile = ".\data\appointments.csv"


#Path of sms csv file to write the output (sms message and Teams URL)
$locationsSMSFile = ".\data\sms.csv"

#Azure AD App Registration Info:
$clientId = "1302d1e4-44e3-4cd9-a08b-1302d1e4" #from Azure AD App Registration (Application (client) ID)
$tenantName = "XXXXXX.onmicrosoft.com" # your onmicrosoft domain
$clientSecret = "asdsadklasjdlasj:fG_@iCba70enQy6oc" #from Azure AD App Registration
$tenantId = "4c6c4c6c-2a538d2d8741-355266bc-2a538d2d8741" #Directory (tenant) ID
$redirectUri = "https://login.microsoftonline.com/common/oauth2/nativeclient"
# Scope - Needs to include all permisions required separated with a space
$scope = "OnlineMeetings.ReadWrite"

#credentials name 
$credentialsTarget = "MyMicrosoft365"

#startDateTime and endDateTime format in $locationsAppointmentsFile file
$input_datetime_format = "dd/MM/yyyy HH:mm"

#email invitation timezone
$timeZone = "Asia/Riyadh" #https://docs.microsoft.com/en-us/graph/api/outlookuser-supportedtimezones?view=graph-rest-1.0

#Should we add event to the calendar if no attendees listed? (1=>Yes  0=>No)
$useEventAPI_even_if_no_attendees = 1

#Should we send email to attendees? (1=>Yes  0=>No)
$send_email = 1




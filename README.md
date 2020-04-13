# Virtual-Appointments 
With the current COVID-19 outbreak and the curfew across the world, many customers facing organizations (Hospitals, Courts, branches) are looking to continue their services with the fastest way possible to run virtual appointment/clinic/court services without introducing too much complexity into their environment and to utilize their current appointment system for scheduling the virtual appointment with their customers.

With "Virtual-Appointments" script, you can quickly provide it with a CSV file of all the appointments scheduled for your customers. It will generate for you a Microsoft Teams meeting link for each appointment that you can share it with your customer using any channel you are using to communicate with them (SMS, email, WhatsApp....).

# How does it works?
![vf-Capture](https://user-images.githubusercontent.com/957921/79162504-123a9280-7de6-11ea-87f1-3b71f29d68ef.PNG)


# What do I need to use Virtual-Appointments?
- Microsoft Teams (Admin access).
- To be able to export the list of the appointments in CSV file format from your appointment system.
- Communication system to send the meeting links to your customers.

# How to setup Virtual-Appointments?
## - Step 1: Application Registration

For various steps in this process we will need to call the Microsoft Graph. To do that, an app registration is required in Azure AD. This will require a Global Administrator account.

- Navigate to https://aad.portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps and sign in as a Global Administrator.
- Click New Registration.
- Provide an application name, select "Accounts in this organizational directory only", and leave Redirect URI blank. Click Register.
- Note down Application and Directory IDs to use later.
- From the left menu, click "API permissions" to grant some permissions to the application.
- Click "+ Add a permission".
- Select "Microsoft Graph".
- Select Delegated permissions.
- Add the following permissions: OnlineMeetings.ReadWrite, Calendars.ReadWrite
- Click "Add permissions"
- Click "+ Add a permission".
- Select "Microsoft Graph".
- Select Application permissions.
- Add the following permissions: Calendars.ReadWrite
- Click "Add permissions"
- Click "Grant admin consent for …"
- From the left menu, click "Certificates & secrets".
- Under "Client secrets", click "+ New client secret".
- Provide a description and select an expiry time for the secret and click "Add".
- Note down the secret Value.

## - Step 2: Application Configuration
- Open config.ps1 and change the configuration. 
- Open template.ps1 and change the SMS and email templates.

## - Step 3: Setup your desktop/server to run the virtual-appointments powershell script
- Open Windows PowerShell as administrator and run

```
Set-ExecutionPolicy RemoteSigned
Install-Module -Name "AzureAD"
Install-Module -Name "MicrosoftTeams"
Install-Module -Name CredentialManager
```

- Open Credential Manager and create "Windows Credential" with name "MyMicrosoft365" (add Global admin credential).


# How to run Virtual-Appointments?


# DISCLAIMER
This sample is provided as is and is not meant for use on a production environment.
It is provided only for illustrative purposes. The end user must test and modify the
sample to suit their target environment. 

We can make no representation concerning the content of this sample. We are
providing this information only as a convenience to you. This is to inform you that
We have not tested the sample and therefore cannot make any representations 
regarding the quality, safety, or suitability of any code or information found here.   

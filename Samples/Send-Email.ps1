<#
.SYNOPSIS
    Sends an email via SMTP.

.DESCRIPTION
    This function sends an email via an SMTP server. You can configure the SMTP server, authentication, 
    and email content through parameters.

.PARAMETER SmtpServer
    The SMTP server to use for sending the email.

.PARAMETER SmtpPort
    The port to use for the SMTP server. Default is 587.

.PARAMETER From
    The sender's email address.

.PARAMETER To
    The recipient's email address.

.PARAMETER Subject
    The subject of the email.

.PARAMETER Body
    The body of the email.

.PARAMETER Attachment
    The path to a file to attach to the email. This parameter is optional.

.PARAMETER Credential
    The credential to use for SMTP authentication. Use Get-Credential to create this.

.EXAMPLE
    Send-Email -SmtpServer "smtp.example.com" -SmtpPort 587 -From "sender@example.com" -To "recipient@example.com" -Subject "Test Email" -Body "This is a test email." -Credential (Get-Credential)
    Sends a test email through the specified SMTP server with the provided credentials.

.NOTES
    Author: anhquanpbc
    Date: 2024-05-30
    Version: 1.0.0    
#>
function Send-Email {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$SmtpServer,

        [Parameter(Mandatory=$false)]
        [int]$SmtpPort = 587,

        [Parameter(Mandatory=$true)]
        [string]$From,

        [Parameter(Mandatory=$true)]
        [string]$To,

        [Parameter(Mandatory=$true)]
        [string]$Subject,

        [Parameter(Mandatory=$true)]
        [string]$Body,

        [Parameter(Mandatory=$false)]
        [string]$Attachment,

        [Parameter(Mandatory=$true)]
        [pscredential]$Credential
    )

    try {
        # Create a new MailMessage object
        $mailMessage = New-Object system.net.mail.mailmessage
        $mailMessage.from = $From
        $mailMessage.to.add($To)
        $mailMessage.Subject = $Subject
        $mailMessage.Body = $Body

        # Add attachment if provided
        if ($Attachment) {
            $attachment = New-Object System.Net.Mail.Attachment($Attachment)
            $mailMessage.Attachments.Add($attachment)
        }

        # Create a new SmtpClient object
        $smtpClient = New-Object system.net.mail.smtpclient($SmtpServer, $SmtpPort)
        $smtpClient.EnableSsl = $true
        $smtpClient.Credentials = New-Object System.Net.NetworkCredential($Credential.UserName, $Credential.GetNetworkCredential().Password)

        # Send the email
        $smtpClient.Send($mailMessage)
        Write-Host "Email sent successfully to $To"
    } catch {
        Write-Host "Failed to send email. Error: $_"
    }
}

# Example usage:
<##> Send-Email -SmtpServer "smtp.example.com" -SmtpPort 587 -From "sender@example.com" -To "recipient@example.com" -Subject "Test Email" -Body "This is a test email." -Credential (Get-Credential)

Add-PSSnapin Microsoft.SharePoint.PowerShell
$siteUrl = "https://sp.com/sites/sitename"
$credentials = Get-Credential

$site = Get-SPSite -Identity $siteUrl



# Retrieve All Subsites
function Get-AllSubsites {
    param([Microsoft.SharePoint.SPWeb]$web)
    
    Write-Host "Processing Site:" $web.Url

    # Get document libraries in current site
    Get-AllDocumentLibraries -Web $web

    # Get subsites and call the function recursively
    foreach ($subsite in $web.Webs) {
        Get-AllSubsites -web $subsite
    }
}

# Retrieve Document Libraries
function Get-AllDocumentLibraries {
    param([Microsoft.SharePoint.SPWeb]$Web)

    foreach ($list in $Web.Lists) {
        if ($list.BaseType -eq "DocumentLibrary") {
            Download-FilesFromLibrary -Library $list
        }
    }
}


# Download Files from Document Libraries
function Download-FilesFromLibrary {
    param([Microsoft.SharePoint.SPList]$Library)

    Write-Host "Processing Library:" $Library.Title

    foreach ($item in $Library.Items) {
        foreach ($file in $item.File) {
            $fileUrl = $file.ServerRelativeUrl
            $targetPath = "C:\DF" + $fileUrl.Replace("/", "\").TrimStart("\")

            # Ensure the target directory exists
            $targetDirectory = [System.IO.Path]::GetDirectoryName($targetPath)
            if (-not (Test-Path -Path $targetDirectory)) {
                New-Item -Path $targetDirectory -ItemType Directory -Force
            }

            $fileBytes = $file.OpenBinary()
            [System.IO.File]::WriteAllBytes($targetPath, $fileBytes)
            Write-Host "File URL:" $fileUrl
Write-Host "Target Path:" $targetPath
            Write-Host "Downloaded file:" $targetPath
        }
    }
}


 

# Execute the Script
Get-AllSubsites -web $site.RootWeb

# Dispose the site object
$site.Dispose()

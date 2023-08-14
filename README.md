# PowerShell
My PowerShell Scripts
If you have a SharePoint 2016 On-premises server and you want to download all files from all document libraries in all subsites, you can use the attached download.ps1 PowerShell script to do so.

The download.ps1 script first connects to your SharePoint site using PowerShell. Then, it recursively loops through all document libraries in the site and its subsites, downloading all files in each library. The script also creates a timestamped folder for each library to store the downloaded files.

To use the download.ps1 script, you will need to have PowerShell installed on your computer. You will also need to edit the script to specify the URL of your SharePoint site and the name of the folder where you want to store the downloaded files.

Once you have edited the script, you can run it by typing the following command in PowerShell:

.\download.ps1
The script will then start downloading all files from your SharePoint site. This may take some time, depending on the size of your site. Once the download is complete, you will find the downloaded files in the specified folder.

I hope this is helpful! Let me know if you have any other questions.

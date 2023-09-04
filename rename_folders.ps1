# Define the folder where you want to update folder names
$targetFolder = ".\test"

# Define the path to the lookup CSV file
$csvFile = ".\lookup.csv"

# Check if the target folder and CSV file exist
if ((Test-Path -Path $targetFolder -PathType Container) -and (Test-Path -Path $csvFile -PathType Leaf)) {
    
	# Import the CSV file
    $lookupTable = Import-Csv -Path $csvFile

    # Loop through each row in the CSV
    foreach ($row in $lookupTable) {
        
		$oldName = $row.OldName
        $newName = $row.NewName

        # Check if the old folder exists
        $oldFolderPath = Join-Path -Path $targetFolder -ChildPath $oldName
        if (Test-Path -Path $oldFolderPath -PathType Container) {
            
			# Rename the folder to the new name
            Rename-Item -Path $oldFolderPath -NewName $newName -Force
            Write-Host "Renamed folder '$oldName' to '$newName'"
        
		} else {
            Write-Host "Folder '$oldName' does not exist in the target folder."
        }
    }
} else {
    Write-Host "Target folder or CSV file does not exist."
}
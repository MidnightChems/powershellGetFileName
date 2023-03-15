# Set the path to the folder containing the images
$folderPath = "C:\Users\gorazem\Desktop\CaseyImages\images"

# Add support for WebP files to the ImageCodecInfo class
Add-Type -AssemblyName System.Drawing
$imageCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatDescription -eq "WebP" }

# Get all the image files in the folder
$imageFiles = Get-ChildItem $folderPath -Filter *.* | Where-Object { $_.Extension -match '\.(jpg|jpeg|png|gif|bmp|webp)$' }

# Create an empty array to hold the data for each image
$imageData = @()

# Loop through each image file
foreach ($file in $imageFiles) {
    # Get the SKU from the filename
    $sku = $file.BaseName

    # Add the data for this image to the array
    $imageData += [pscustomobject] @{
        sku = $sku
        base_image = $file.Name
    }
}

# Export the image data to a CSV file
$imageData | Export-Csv -Path "C:\Users\gorazem\Desktop\CaseyImages\image_data.csv" -NoTypeInformation

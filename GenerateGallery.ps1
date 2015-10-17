#GalGen - Dropbox Gallery Generator V1.0 - By damsleth
#https://github.com/damsleth

#path to directory where ps1 is located
$path = $PSScriptRoot;
$thumbPath =$path+"\thumbs\";

#creates the thumbs-folder and index.html
New-Item -Path "$PSScriptRoot\index.html" -ItemType File -Force;
New-Item -Path "$PSScriptRoot\thumbs\" -ItemType Directory -Force;

#append and add image functions, for adding the image links
function Append($string){ $string | Out-File -Append -FilePath "index.html" -Encoding utf8 }
function AddImage($fileN, $thumbFN){Append("<a href='$fileN' class='thickbox' rel='gallery'><img src='$thumbFN' $dongs /></a>")}

$header = "<!DOCTYPE HTML>
<html>
    <head>
        <script type='text/javascript' src='files/jquery.js' ></script>
        <script type='text/javascript' src='files/thickbox.js' ></script>
        <link rel='stylesheet' href='files/thickbox.css' />
        <link rel='stylesheet' href='files/gallery.css' />
        <style type='text/css'>a.thickbox{display:inline-block; height:120px;width:120px;overflow:hidden;}</style>
    </head>
<body>
    <div>"

$footer = "
	</div>
</body>
</html>"

Append($header);

Write-Host

#for each image file in the current folder
Get-ChildItem $path"\*.*" -Include *.jpg,*.png,*.jpeg,*.gif | ForEach {
	$fullpathStr = $(Resolve-Path $_);
	$fileName = $_.BaseName+$_.Extension
	$thumbFileName = $_.BaseName+'_thumb'+$_.Extension
	$outputFileNameStr= "$($thumbPath+$thumbFileName)"

	#get the image and ratio
	$full = [System.Drawing.Image]::FromFile("$($fullpathStr)", ($true) );
	$ratio = $full.Height / $full.Width;
	Write-Host "$fileName ("$full.Height"x"$full.Width"px, ratio $ratio)" -ForegroundColor Cyan

	#create and save the thumbnail to the thumbs-folder
	$thumb = $full.GetThumbnailImage(120,120*$ratio, $null, [intptr]::Zero);
	$thumb.Save( "$($outputFileNameStr)");
	AddImage -fileN $fileName -thumbFN "thumbs/$thumbFileName";
	$full.Dispose(); 
	$thumb.Dispose();
	Write-Host 
}
Write-Host "All done, your gallery is ready at $path\index.html" -ForegroundColor Green;
Append($footer);
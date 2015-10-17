# GalGen - Simple Image Gallery Generator

## What?
GalGen is a simple way to generate an image gallery from a folder of images, which in turn can be used in for instance your Dropbox "public" folder.  
I wrote it because there's no out of the box way to anonymously view folders inside the public folder in Dropbox

## Usage
* Put the GenerateGallery ps1 script as well as the "files"-folder in the folder where your images are stored.
* Using Powershell, run GenerateGallery.ps1
* Provided nothing went wrong, you should now have an "index.html"-file with a gallery of the images, as well as a "thumbs" folder.
* If you're using Dropbox, copy the public link to the index.html-file and share it with your friends :)

## Notes

The generated gallery uses jQuery 1.1.3, as well as the ThickBox lightbox widget (http://codylindley.com/thickbox/)
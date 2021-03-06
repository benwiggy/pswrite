# pswrite
MacOS / CUPS Backends to Save PostScript and PDF to disk, using print queues

This repository currently holds the following files, which create print queues for CUPS-based systems, primarily macOS.

### 1. CUPS backends
Two backends for CUPS are included: pswrite and pdfwrite. These are the files that 'pipe' the print output to a file. Backends need to be put in _/usr/libexec/cups/backend_ and given attributes _root wheel 0700_

### 2. PPD files
Every print queue needs a PostScript Printer Description file. The one for the PostScript queue isn't that special: it simply provides standard attributes of a "Generic" device. The one for Direct_PDF includes a couple of parameters which ensure that PDF is the default format for this print queue. Some print-to-disk routines convert to PostScript first and then convert back to PDF: this instructs CUPS to 'Keep it PDF'.

### 3. Print queue creation script for macOS.
Because of sandboxing, the only location that CUPS can save files to on macOS is /Users/Shared. This script creates a subfolder, Print and creates two print queues: one for PostScript, one for PDF. 
If you have Adobe Distiller, the script will create subfolders called "In" and "Out". These can be used in conjunction with Distiller's Watched Folders. (.ps files go In, PDFs come Out.) PDFs from the Direct_PDF print queue also go to the Out folder. An Alias to the print destination folder is added to the Desktop.

### 4. Package installer for OS X of the current 'build'.
This is supplied simply to make the installation process easy. I can understand that people might be (rightly) worried about authorizing an installer from a strange man on the internet. You can use File > Show Files in Apple's Installer app to see what the package contains. Alternatively, I recommend the excellent Pacifist app from Charlesoft, which lets you inspect the contents of packages before installing. 

Improvements to any of the above are welcome.

# LICENSING
The CUPS backends use bits of code from other scripts that have been freely available online: I include the names of the authors. All works that use these files as their basis should include the names mentioned. Otherwise, any use is fine.

Ben Byram-Wigfield
September 2017

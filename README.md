# pswrite
MacOS / CUPS Backends to Save PostScript and PDF to disk, using print queues

This repository currently holds the following files, which create print queues for CUPS-based systems, primarily macOS.

1. CUPS backends
Two backends for CUPS are included: pswrite and pdfwrite. These are the files that 'pipe' the print output to a file.

2. PPD files
Every print queue needs a PostScript Printer Description file. The one for the PostScript queue isn't that special, but the one for Direct_PDF includes a couple of parameters that mean PDF is the default format for this print queue. Some print-to-disk routines convert to PostScript first and then convert back to PDF: this instructs CUPS to 'Keep it PDF'.

3. Print queue creation script for macOS.
Because of sandboxing, the only location that CUPS can save files to on macOS is /Users/Shared. This script creates a subfolder, Print and creates two print queues: one for PostScript, one for PDF. 
If you have Adobe Distiller, the script will create subfolders called "In" and "Out". These can be used in conjunction with Distiller's Watched Folders. (.ps files go In, PDFs come Out.) PDFs from the Direct_PDF print queue also go to the Out folder. An Alias to the file destination folder is added to the Desktop.

4. Package installer for OS X of the current 'build'.

Improvements to any of the above are welcome.

LICENSING
The CUPS backends use bits of code from other scripts that have been freely available online: I include the names of the authors. All works that use these files as their basis should include my name. Otherwise, any use is fine.

Ben Byram-Wigfield
July 2016

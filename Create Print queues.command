#!/bin/bash
#
# Script to create Print queues and folders for Save to Disk CUPS backends.
# © 2016 Ben Byram-Wigfield
# To be used in conjunction with my CUPS backends, which must be installed first.
#
# Modify any of these variables as required:

USER_FOLDERS=false; # Defines whether a subfolder for the current user is created. 
PS_FOLDER='/Users/Shared/Print'; # Destination for print folders
PPD_SOURCE='/Library/Printers/PPDs/Bens'; # Location of required PPD files
DESKTOP_ALIAS='~/Desktop/ Print files';

# Constants and variables for the script's own use. Do not modify.
BACKEND='/usr/libexec/cups/backend/pswrite';
BACKEND2='/usr/libexec/cups/backend/pdfwrite';
USER_PATH="";
DISTIL_PATH="";

# Check for Distiller
if open -Ra "Acrobat Distiller" ; then
  DISTILLER=true;
else
 DISTILLER=false;
 fi

# Check if the backends are there.
if [ ! -f ${BACKEND} ] || [ ! -f ${BACKEND2} ] ; then
echo "CUPS backends not installed. Run installer package first."; exit 1
fi

# Check if the PPDs exists. (This PPD has special code not found in most PPDs.)
if [ ! -f ${PPD_SOURCE}/PostScript.ppd ] ||  [ ! -f ${PPD_SOURCE}/Direct_PDF.ppd ]; then
echo "PPDs not installed. Run installer package first.";  exit 1
fi

# Create Destination folder, and User subfolder if required.
if $USER_FOLDERS; then
mkdir -p ${PS_FOLDER}/${USER};
cd ${PS_FOLDER}/${USER};
USER_PATH='/'$USER;
else
mkdir -p ${PS_FOLDER};
cd ${PS_FOLDER};
fi

# Create In and Out folders in current user's PostScript folder, if not there, if using DISTILLER

if $DISTILLER; then 
mkdir -m 0777 In; 
mkdir -m 0777 Out;
DISTIL_PATH="/In";
DISTIL_OUT="/Out";
fi

# Quit and restart CUPS if things don't seem to be working.
# sudo killall -HUP cupsd

# Create PostScript print queue (to In folder if using Distiller).
 lpadmin -p PostScript -v pswrite:/${PS_FOLDER}${USER_PATH}${DISTIL_PATH}/ -E -P ${PPD_SOURCE}/PostScript.ppd;
 # Create PDF print queue (to Out folder if using Distiller)
 lpadmin -p Direct_PDF -v pdfwrite:/${PS_FOLDER}${USER_PATH}${DISTIL_OUT}/ -E -P ${PPD_SOURCE}/Direct_PDF.ppd;
 #  Add alias to folder on Desktop.
 ln -s ${PS_FOLDER}${USER_PATH}${DISTIL_OUT} ${DESKTOP_ALIAS};

if $DISTILLER; then
echo "Don't forget to add "${PS_FOLDER}" to the Watched Folders in Distiller";
fi

exit 0
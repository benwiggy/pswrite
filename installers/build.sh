#!/bin/sh

# Build the staging area.
mkdir -p root/Library/Printers/PPDs/Bens
mkdir -p root/usr/libexec/cups/backend

cp ../PPDs/Direct_PDF.ppd root/Library/Printers/PPDs/Bens
cp ../PPDs/PostScript.ppd root/Library/Printers/PPDs/Bens

cp ../backend/pswrite root/usr/libexec/cups/backend
cp ../backend/pdfwrite root/usr/libexec/cups/backend

# Add the postflight script.
mkdir -p scripts

cp "../Create Print queues.command" scripts/postinstall

# Fixup permissions.
chmod ugo+x root/usr/libexec/cups/backend/pdfwrite
chmod ugo+x root/usr/libexec/cups/backend/pswrite

chmod ugo+x scripts/postinstall

# Build the package.
pkgbuild --identifier com.me.ben.printqueues --root root --scripts scripts BensPrintQueues.pkg

# Cleanup.
rm root/Library/Printers/PPDs/Bens/*
rm root/usr/libexec/cups/backend/*

rmdir root/Library/Printers/PPDs/Bens
rmdir root/Library/Printers/PPDs
rmdir root/Library/Printers
rmdir root/Library
rmdir root/usr/libexec/cups/backend
rmdir root/usr/libexec/cups
rmdir root/usr/libexec
rmdir root/usr
rmdir root

rm scripts/postinstall

rmdir scripts
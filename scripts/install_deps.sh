#!/bin/bash

# Update the package manager and install TeX Live
yum update -y
yum install texlive texlive-latex -y

TEXLIVE_PATH=$(dirname $(which pdflatex))

# Print TeX Live version
echo "pdflatex --version"
pdflatex --version
echo "tex --version"

# Define the full path to tlmgr
TLMPGR_PATH="$TEXLIVE_PATH/tlmgr"

# Use tlmgr with the full path
echo "Using tlmgr from its installation path:"
echo "Contents of TeX Live installation directory ($TEXLIVE_PATH):"
ls -l "$TEXLIVE_PATH"
#!/bin/bash

# Update the package manager and install TeX Live
yum update -y
yum install texlive texlive-latex -y

TEXLIVE_PATH=$(dirname $(which pdflatex))

# Print TeX Live version
echo "pdflatex --version"
pdflatex --version
echo "tex --version"


# Use tlmgr with the full path
echo "Using tlmgr from its installation path:"
TLMPGR_PATH="$TEXLIVE_PATH/bin/x86_64-linux/tlmgr"

# Use tlmgr with the full path
echo "Using tlmgr from its installation path:"
$TLMPGR_PATH --version
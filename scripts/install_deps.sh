#!/bin/bash

# Update the package manager and install TeX Live
yum update -y
yum install texlive texlive-latex -y

# Determine the TeX Live installation path
TEXLIVE_PATH=$(dirname $(which pdflatex))

# Print TeX Live version
echo "pdflatex --version"
pdflatex --version
echo "tex --version"

# Export the TeX Live path to the PATH environment variable
export PATH="$TEXLIVE_PATH:$PATH"
echo "tlmgr path"
tlmgr --version
# Optionally, install additional TeX Live packages as needed
# sudo yum install texlive-<package-name> -y
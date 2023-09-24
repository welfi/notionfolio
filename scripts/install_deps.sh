#!/bin/bash
yum update -y
yum install file
# Define the directory where TeX Live will be installed
TEXLIVE_INSTALL_DIR="/usr/local/texlive"

# Define the profile to use for installation (scheme-basic, scheme-medium, etc.)
INSTALL_PROFILE="scheme-medium"

# Download the TeX Live installer script
curl -sO https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

# Check if the file is in gzip format by verifying its magic number
if [[ "$(dd if=install-tl-unx.tar.gz bs=2 count=1 2>/dev/null)" == $'\x1f\x8b' ]]; then
    # The file appears to be in gzip format, so proceed with extraction
    tar -xzf install-tl-unx.tar.gz
    cd install-tl-*

    # Run the TeX Live installer with the specified profile and installation directory
    ./install-tl -profile=/dev/stdin <<EOF
selected_scheme $INSTALL_PROFILE
TEXDIR $TEXLIVE_INSTALL_DIR
EOF

    # Add TeX Live binaries to the system's PATH
    echo "export PATH=\"$TEXLIVE_INSTALL_DIR/bin/x86_64-linux:\$PATH\"" >> ~/.bashrc
    source ~/.bashrc  # Refresh the shell environment

    # Print TeX Live version
    pdflatex --version

    # Check the version of tlmgr
    tlmgr --version

    echo "TeX Live installation complete."
else
    echo "Error: The downloaded file is not in gzip format."
fi

# Clean up temporary files
cd ..
rm -rf install-tl-*
rm install-tl-unx.tar.gz

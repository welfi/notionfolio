#!/bin/bash
yum update -y
yum install wget
yum install perl-Digest-MD5 -y

# Define the version of TexLive you want to install (change YYYY to the desired year)
TEXLIVE_VERSION="2023"

# Define the architecture (PLATFORM) you want to install (e.g., x86_64-linux)
PLATFORM="x86_64-linux"

# Define the installation directory
INSTALL_DIR="/usr/local/texlive/$TEXLIVE_VERSION"

# Define the desired TexLive scheme (e.g., "small" for a smaller scheme)
TEXLIVE_SCHEME="small"

# Step 1: Change to the working directory (e.g., /tmp)
cd /tmp

# Step 2: Download TexLive installation files using wget (or curl)
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

# Step 3: Extract the downloaded files
tar -xf install-tl-unx.tar.gz

# Step 4: Change to the TexLive installation directory
cd install-tl-*

# Step 5: Install TexLive with specific options
perl ./install-tl --profile=/dev/stdin <<END
selected_scheme scheme-$TEXLIVE_SCHEME
TEXDIR $INSTALL_DIR
TEXMFLOCAL $INSTALL_DIR/texmf-local
TEXMFSYSVAR $INSTALL_DIR/texmf-var
TEXMFSYSCONFIG $INSTALL_DIR/texmf-config
TEXMFHOME ~/texmf
TEXMFVAR ~/.texlive$TEXLIVE_VERSION/texmf-var
TEXMFCONFIG ~/.texlive$TEXLIVE_VERSION/texmf-config
TEXMF_CACHE ~/.texlive$TEXLIVE_VERSION/texmf-var
TMPDIR /tmp
TEXGLOB $INSTALL_DIR/texmf-dist
TEXLIVE_INSTALL_PREFIX $INSTALL_DIR
option_doc 0
option_src 0
option_doc 0
option_src 0
option_autobackup 0
option_desktop_integration 0
option_menu_integration 0
option_file_assocs 0
option_post_code 1
END

# Step 6: Add TexLive binaries to the PATH
echo "export PATH=$INSTALL_DIR/bin/$PLATFORM:\$PATH" | tee -a /etc/profile.d/texlive.sh
source /etc/profile.d/texlive.sh

# Step 7: Clean up temporary files (optional)
cd /tmp
rm -rf install-tl-unx.tar.gz install-tl-*

# Step 8: Verify TexLive installation
tlmgr --version
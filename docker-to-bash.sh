#!/bin/bash

#
#
# Converts Dockerfile to a bash script that
# can be used on an raw Ubuntu server to
# install/configure/setup all of the Huntkit
# goodness.
# Useful when you're wanting the Huntkit
# experience on a cheaper machine (that isn't
# big enough for Docker)
#
#

FILENAME="install-in-ubuntu.sh"

# Create file and add a hashbang
echo "#!/bin/bash" > $FILENAME
cat Dockerfile >> $FILENAME

# Remove Docker keywords
sed -i'.bak' -e 's/RUN //g' $FILENAME
sed -i'.bak' -e 's/ENV /export /g' $FILENAME

# Remove whole lines
sed -i'.bak' -e '/^FROM/d' $FILENAME
sed -i'.bak' -e '/^LABEL/d' $FILENAME
sed -i'.bak' -e '/^WORKDIR/d' $FILENAME
sed -i'.bak' -e '/^COPY/d' $FILENAME
sed -i'.bak' -e '/^ENTRYPOINT/d' $FILENAME
sed -i'.bak' -e '/^CMD/d' $FILENAME

# Clean up empty lines
sed -i'.bak' -e '/^$/d' $FILENAME

# Delete the # ----... lines
sed -i'.bak' -e '/^# -*$/d' $FILENAME

# Add back, empty lines before each comment
sed -i'.bak' -e 's/^# /\n# /g' $FILENAME

# Remove the apt clean parts
sed -i'.bak' -e '/^  rm -rf \/var\/lib\/apt\/lists\/\*/d' $FILENAME
sed -i'.bak' -e 's/apt-get clean && .*/echo "Placeholder"/g' $FILENAME

# We don't want the script interupted to switch Shells
sed -i'.bak' -e 's/chsh -s $(which zsh)/\&\& echo "Placeholder"/g' $FILENAME

# Add PATH
echo "echo \"export PATH=\${PATH}\" >> ~/.zshrc" >> $FILENAME

# Change default shell right at the end
echo "chsh -s \$(which zsh)" >> $FILENAME

# Remove Backup file
rm "${FILENAME}.bak"

# Send output
echo '---------------------------'
echo '--- Done ---'
echo '---------------------------'

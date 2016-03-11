#/usr/bin/env bash

# @todo: load URL from here: https://data.services.jetbrains.com/products/releases?code=PS&latest=true&type=release

set -o errexit
set -o pipefail
shopt -s nullglob

DROPBOX_PATH="$HOME/Dropbox"
INSTALL_PATH="$HOME/PhpStorm"
TEMP_PATH="$HOME/.tmp"
EXECUTABLE_PATH="$INSTALL_PATH/bin/phpstorm.sh"

# Installing the application
rm -Rf $INSTALL_PATH
rm -Rf $TEMP_PATH
mkdir -p $TEMP_PATH
wget -O - "https://download.jetbrains.com/webide/PhpStorm-10.0.3.tar.gz" | tar xzf - -C $TEMP_PATH
mv $TEMP_PATH/PhpStorm-* $INSTALL_PATH
rm -Rf $TEMP_PATH

# Creating a symlink for user settings directory
# stored in DropBox
files=($DROPBOX_PATH/.WebIde*)
for file in "${files[@]}" ; do
    ln -s $file $HOME/ || true
done

# Starting the application
nohup $EXECUTABLE_PATH > /dev/null 2>&1 &

# Creating a desktop launcher
exo-desktop-item-edit --create-new \
--type Application \
--name PhpStorm \
--command $EXECUTABLE_PATH \
--icon "$INSTALL_PATH/bin/webide.png" \
$HOME/Desktop/

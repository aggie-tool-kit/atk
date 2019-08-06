# ask for password early on
sudo echo ""
# install homebrew if not installed
which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install python3 if not installed
which python3 || brew install python3 &> /dev/null
# install asciimatics
pip3 install asciimatics &> /dev/null
# create the temp dir
mkdir -p ~/atk/temp
# run installation in the background
which git || brew install git
# install the atk_toolbox gem
gem install atk_toolbox
# download the setup.rb
curl -fsSL https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/setup.rb > ~/atk/temp/setup.rb
# run it
ruby ~/atk/temp/setup.rb
rm ~/atk/temp/setup.rb
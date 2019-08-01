# install homebrew if not installed
which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install python3 if not installed
which python3 || brew install python3 &> /dev/null
# install asciimatics
pip3 install asciimatics &> /dev/null
# create the temp dir
mkdir -p ~/atk/temp
# download the animation to the temp dir
curl -fsSL https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/atk_animation.py > ~/atk/temp/atk_animation.py
# run installation in the background
cat <<HEREDOC | bash &>/dev/null & 
    # get git if not installed
    which git || brew install git
    # install the ruamel.yaml package
    pip3 install ruamel.yaml &>/dev/null
    # install the atk_toolbox gem
    gem install atk_toolbox
    # download the setup.rb
    curl -fsSL https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/setup.rb > ~/atk/temp/setup.rb
    # run it
    ruby ~/atk/temp/setup.rb
HEREDOC
# run the animation
python3 ~/atk/temp/atk_animation.py
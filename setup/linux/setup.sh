echo "starting bash script"
# get curl if on ubunutu
which apt-get && sudo apt-get install curl <<<"Y"
# go home
cd 
# download the files
curl -fsSL https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/linux/setup.rb > setup.rb
curl -fsSL https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/linux/setup.pl > setup.pl
# run the perl file
perl setup.pl
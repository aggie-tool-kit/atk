echo "starting bash script"
which apt-get && sudo apt-get install curl <<<"Y"
cd
curl -fsL https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/linux/setup.pl > setup.pl
perl setup.pl
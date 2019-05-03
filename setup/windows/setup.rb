# Continuation of the Windows installation of ATK
require_relative '../../toolbox/package_managers'

# Install sudo
Scoop.install('sudo')

# Install Git
Scoop.install('git')

# Copy all the ATK libs and add to PATH


# Install Docker
Scoop.install('docker')
Scoop.install('docker-compose')
Scoop.install('docker-machine')
`docker-machine create default`



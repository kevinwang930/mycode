# prepare

sudo dnf groupinstall "Development Tools"
sudo dnf groupinstall "C Development Tools and Libraries" 
sudo dnf install autoconf
sudo yum install cups-devel

# configure jdk

bash configure --with-debug-level=slowdebug  

# run make

make images

# verify your newly built JDK:
./build/*/images/jdk/bin/java -version

# Run basic tests:
make test-tier1
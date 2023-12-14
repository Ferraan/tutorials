# This script sets up a DUNE environment in the working directory to solve the two-scale-heat-conduction problem with DuMuX on one or both scales

# Get the DuMuX install script and install it
wget https://git.iws.uni-stuttgart.de/dumux-repositories/dumux/-/raw/master/bin/installdumux.py
python3 installdumux.py

# Take out all the module folders from the dumux/ folder and remove the dumux/ folder
mv dumux dumux-install
mv dumux-install/* ./
rm -r dumux-install

# Get additional required DUNE modules
# DuMux-preCICE adapter
git clone -b feature/export-module-library https://github.com/precice/dumux-adapter.git
# DuMux phasefield implementation
git clone -b cell_problems https://git.iws.uni-stuttgart.de/dumux-appl/dumux-phasefield.git
# DUNE SPGrid for periodic boundary conditions
python3 dumux/bin/installexternal.py spgrid

# Clear CMake caches and re-build environment
./dune-common/bin/dunecontrol bexec rm -r CMakeFiles CMakeCache.txt
./dune-common/bin/dunecontrol --opts=./dumux/cmake.opts all

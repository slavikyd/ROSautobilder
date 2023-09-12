# ROSautobuilder

## Following scripts were created for fully automatic installation of ROS with additional packages into Ubuntu 22.04 and earlier

### Installation and use

#### For installation use following commands:
```bash
git clone https://github.com/slavikyd/ROSautobilder
```
When downloaded you need to enter package directory and give files access for execution
```bash
cd ROSautobuilder
chmod +x ROSautobuilder.sh
chmod +x ROSautobuilder_with_Clover.sh
```
Once done you can proceed for installation, but before that make sure you have Ubuntu version not earlier than 18.04 and have preinstalled GIT and curl. If they aren't installed you can use following commands:
```bash
sudo apt install curl
sudo apt install git
```

#### For use
To use autobuilder you only need to execute one command and give version number in argument (18, 20 or 22 are available at the moment)

Installation of pure ROS
```bash
./ROSautobuilder.sh version_number
```
For installation with [Clover packages](https://github.com/CopterExpress/clover):
```bash
./ROSautobuilder_with_Clover.sh version-number
```
P.S.: Clover installation may be unstable on 22 Ubuntu version due to official incompatiability of ROS with it. Please look after the installation and if you have spotted some troubles open an issue to let me know about.
#### New version
Now you can use a bit optimized version of code, which is pretty similar to previous, but have some changes

To use just execute folowing steps:
```bash
chmod +x main.sh
./main.sh version_number
```
P.P.S.: In sooner updates it will be the main version of script

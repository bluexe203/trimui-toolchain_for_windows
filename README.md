# trimui-toolchain for windows
## Setup msys2

https://www.msys2.org/

1. Install msys2 (e.g. C:\msys64)

2. Configure msys2.ini(C:\msys64\msys2.ini)
   
   ```
   HOME=home/trimui
   PATH=/opt/trimui/bin
   ```

3. Install Package

   Run msys2.exe
   
   ```
   pacman -S make
   pacman -S libtool
   ```

4. [Download Toolchain for Windows](https://github.com/bluexe203/trimui-toolchain_for_windows/releases/download/v1.0/trimui-toolchain.tar.xz)

5. Extract Toolchain

   On msys2

   ```
   cd /opt
   # if download toolchain in C:\trimui-toolchain.tar.xz
   tar xvf /c/trimui-toolchain.tar.xz
   ```

   check this command
   
   ```
   arm-linux-gnueabi-gcc -v
   ```
## Install Library

   On msys2

```
pacman -S git
pacman -S pkg-config
git clone https://github.com/bluexe203/trimui-toolchain_for_windows.git
cd trimui-toolchain_for_windows
bash Msys2_LibrarySetup.sh
```



# Apendix Build Toolchain Yourself

**Required**

- Ubuntu20.04LTS
- Linaro Toolchain

## On Ubuntu 20.04LTS

## Install Package

```
sudo apt update
#Optional
sudo apt install open-vm-tools
sudo apt install open-vm-tools-desktop
sudo apt install cifs-utils

#Require for build
sudo apt install build-essential
sudo apt install mingw-w64
sudo apt install python
sudo apt install flex bison autogen automake autoconf libtool texinfo gawk libncurses5-dev libpython2.7-dev gcc-multilib g++-multilib dejagnu lsb zlib1g-dev
```

### Install git-new-workdir

Used by abe.sh(Build Script for Linaro Toolchain)

```
sudo apt install git

sudo chmod 777 /usr/local/share
mkdir -p /usr/local/share/git-core/contrib/workdir
cd /usr/local/share/git-core/contrib/workdir
wget https://raw.githubusercontent.com/git/git/master/contrib/workdir/git-new-workdir
chmod +x git-new-workdir
ln -s /usr/local/share/git-core/contrib/workdir/git-new-workdir /usr/local/bin/git-new-workdir
```

### Get Linaro Toolchain
[Original Toolchain is Here (only cortex-a9 CPU)](https://releases.linaro.org/components/toolchain/binaries/6.4-2017.11/arm-linux-gnueabi/)

```
git clone https://github.com/bluexe203/trimui-toolchain_for_windows.git
# Use This Manufest
# workspace/gcc-linaro-6.4.1-2017.11-linux-manifest.txt
# workspace/gcc-linaro-6.4.1-2017.11-win32-manifest.txt
cd trimui-toolchain_for_windows
cp -r workspace/ ../workspace
cd ../
```

### Get ABE.sh

```
git clone https://git.linaro.org/toolchain/abe.git
cd abe/
git checkout 333add3ae07b35815672a8a1d03eb443e5ea87fe
cd ../
```

### Check Directories
```
abe/
workspace/
```


### Canadian Crossbuild

1. Build Toolchain for Linux(build=x86_64-linux
   target=arm-linux-gnueabi)
   ```
   cd workspace
   #configure
   ../abe/configure --with-git-reference-dir=/home/tcwg-buildslave/snapshots-ref
   #build(need many time)
   ../abe/abe.sh --manifest gcc-linaro-6.4.1-2017.11-linux-manifest.txt --release 2017.11 --tarball --build all
   ```
   
2. Set Path to Linux Toolchain
   ```
   export PATH=$PATH:/home/workspace/builds/destdir/x86_64-unknown-linux-gnu/bin
   ```
   
3. Build Toolchain for Windows(build=x86_64-linux host=i686-w64-mingw32 target=arm-linux-gnueabi)
   
   add text in host.conf(workspace/host.conf)

   ```
   host=i686-w64-mingw32
   target=arm-linux-gnueabi
   ```

   fix mingw32 bug

   ```
   '::hypot' has not been declared
   fix cmath
   sudo gedit /usr/lib/gcc/i686-w64-mingw32/9.3-win32/include/cmath
   1121: using ::hypot; → using ::_hypot;
   ```
   build (No configure)
   ```
   #build（need many time）
   ../abe/abe.sh --manifest gcc-linaro-6.4.1-2017.11-win32-manifest.txt --release 2017.11 --tarball --build all
   ```

   Toolchain is created this directory
   workspace/snapshots

   ```
   gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi.tar.xz
   ```


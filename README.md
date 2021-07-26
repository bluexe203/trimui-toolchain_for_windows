# trimui-toolchain for windows
## Setup msys2

https://www.msys2.org/

1. Install msys2 (e.g. C:\msys64)

2. Configure msys2.ini(C:\msys64\msys2.ini)

   ```
HOME=home/trimui
PATH=$PATH:/opt/gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi
   ```

3. Install Package

   Run msys2.exe

   ```
pacman -S make
pacman -S libtool
   ```

4. Download Toolchain for Windows
[Toolchain for Windows](https://drive.google.com/file/d/1faaciy_PZXPGHM77n0C4jrhVAFW9FZM-/view?usp=sharing)

5. Extract Toolchain

   On msys2

   ```
   cd /opt
   # if download toolchain in C:\gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi.tar.xz
   tar xvf /c/gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi.tar.xz
   ```

   check this command
   
   ```
   arm-linux-gnueabi-gcc -v
   ```
## Install SDL

   On msys2

```
cd ~
wget http://www.libsdl.org/release/SDL-1.2.15.tar.gz
tar xvf SDL-1.2.15.tar.gz

#configure
cd SDL-1.2.15
./configure --disable-pulseaudio --build=arm-linux --host=arm-linux-gnueabi --prefix=/opt/gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi --disable-static --enable-video-fbcon=no

#make
make
make install
```

fix sdl-config(/opt/gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi/bin/sdl-config)

```
line:45(if argument is --cflags)
before      echo -I${prefix}/include/SDL -D_GNU_SOURCE=1      
after       echo -I${prefix}/include/ -D_GNU_SOURCE=1
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
```

### Get ABE.sh

```
git clone https://git.linaro.org/toolchain/abe.git
cd abe/
git checkout 333add3ae07b35815672a8a1d03eb443e5ea87fe
cd ../
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
   
   add host.conf(workspace/host.conf)

   ```
   host=i686-w64-mingw32
   target=arm-linux-gnueabi
   ```

   fix mingw32

   ```
   '::hypot' has not been declared
   fix cmath
   sudo gedit /usr/lib/gcc/i686-w64-mingw32/9.3-win32/include/cmath
   1121: using ::hypot; → using ::_hypot;
   ```
   build (not configure command)
   ```
   #build（need many time）
   ../abe/abe.sh --manifest gcc-linaro-6.4.1-2017.11-win32-manifest.txt --release 2017.11 --tarball --build all
   ```

   workspace/snapshots

   ```
   gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi.tar.xz
   ```




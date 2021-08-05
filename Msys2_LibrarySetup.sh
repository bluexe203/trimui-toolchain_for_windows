#! /bin/bash

export ARCH=arm
export TRIMUI_PREFIX=/opt/gcc-linaro-6.4.1-2017.11-i686-mingw32_arm-linux-gnueabi
export TRIMUI_LIB_PREFIX=$TRIMUI_PREFIX/arm-linux-gnueabi/libc/lib
export CROSS_PREFIX=arm-linux-gnueabi-
export LDFLAGS="-L$TRIMUI_PREFIX/lib"
export CPPFLAGS="-I$TRIMUI_PREFIX/include"
export PKG_CONFIG_PATH=$TRIMUI_PREFIX/lib/pkgconfig

init_flags(){
	export LDFLAGS="-L$TRIMUI_PREFIX/lib"
	export CPPFLAGS="-I$TRIMUI_PREFIX/include"
	export PKG_CONFIG_PATH=$TRIMUI_PREFIX/lib/pkgconfig
}

mkdir package
pushd package

#if [! -e ./zlib-1.2.8 ]; then
#zlib-1.2.8
wget -nc http://downloads.sourceforge.net/project/libpng/zlib/1.2.8/zlib-1.2.8.tar.xz
tar xvf zlib-1.2.8.tar.xz
if [ -e ./zlib-1.2.8 ]; then
pushd zlib-1.2.8
../../tool/ConfigConv configure
init_flags
./configure --shared --prefix=$TRIMUI_PREFIX
make
make install
popd
fi

#bzip2-1.0.6
wget -nc https://www.sourceware.org/pub/bzip2/bzip2-1.0.6.tar.gz
tar xvf bzip2-1.0.6.tar.gz
if [ -e ./bzip2-1.0.6 ]; then
pushd bzip2-1.0.6
cp -f ../../bzip2/Makefile ./
cp -f ../../bzip2/Makefile-libbz2_so ./
make install PREFIX=$TRIMUI_PREFIX
make -f Makefile-libbz2_so PREFIX=$TRIMUI_PREFIX
popd
fi

#libjpeg-9b
wget -nc http://www.ijg.org/files/jpegsrc.v9b.tar.gz
tar xvf jpegsrc.v9b.tar.gz
if [ -e ./jpeg-9b ]; then
pushd jpeg-9b
#../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared
make
make install
popd
fi

#libpng-1.2.56
wget -nc http://downloads.sourceforge.net/project/libpng/libpng12/older-releases/1.2.56/libpng-1.2.56.tar.xz
tar xvf libpng-1.2.56.tar.xz
if [ -e ./libpng-1.2.56 ]; then
pushd libpng-1.2.56
#../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --enable-arm-neon=no
make
make install
popd
fi

#alsa-lib-1.1.1
wget -nc ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.1.tar.bz2
tar xvf alsa-lib-1.1.1.tar.bz2
if [ -e ./alsa-lib-1.1.1 ]; then
pushd alsa-lib-1.1.1
#../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --program-prefix= --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --with-alsa-devdir=/dev/snd --with-pcm-plugins=all --with-ctl-plugins=all --without-versioned --enable-static=no --disable-python --with-softfloat
make
make install
popd
fi

#sdl-1.2.15
wget -nc http://www.libsdl.org/release/SDL-1.2.15.tar.gz
tar xvf SDL-1.2.15.tar.gz
if [ -e ./SDL-1.2.15 ]; then
pushd SDL-1.2.15
../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --enable-video-fbcon=no --enable-video-directfb=no --enable-video-qtopia=no --enable-video-x11=no --disable-pth --disable-rpath --enable-pulseaudio=no --disable-arts --disable-esd --disable-nasm --disable-video-ps3
make
make install
popd
fi

#sdl_gfx-2.0.23
wget -nc https://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-2.0.23.tar.gz
tar xvf SDL_gfx-2.0.23.tar.gz
if [ -e ./SDL_gfx-2.0.23 ]; then
pushd SDL_gfx-2.0.23
../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --with-sdl-prefix=$TRIMUI_PREFIX --disable-sdltest --enable-static --disable-mmx
make
make install
popd
fi

#sdl_image-1.2.12
wget -nc http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.12.tar.gz
tar xvf SDL_image-1.2.12.tar.gz
if [ -e ./SDL_image-1.2.12 ]; then
pushd SDL_image-1.2.12
../../tool/ConfigConv configure
init_flags
./configure  --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --with-sdl-prefix=$TRIMUI_PREFIX --disable-sdltest --disable-static --enable-bmp=yes --enable-gif=no --enable-jpg=yes --enable-lbm=no --enable-pcx=no --enable-png=yes --enable-pnm=no --enable-tga=no --enable-tif=no --enable-webp=no --enable-xcf=no --enable-xpm=no --enable-xv=no
make
make install
popd
fi

#sdl_mixer-1.2.12
wget -nc http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.12.tar.gz
tar xvf SDL_mixer-1.2.12.tar.gz
if [ -e ./SDL_mixer-1.2.12 ]; then
pushd SDL_mixer-1.2.12
../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --without-x --with-sdl-prefix=$TRIMUI_PREFIX --disable-music-midi --disable-music-mod --disable-music-mp3 --disable-music-flac --enable-music-mp3-mad-gpl --disable-music-mp3-mad-gpl-shared --enable-music-ogg --disable-music-ogg-shared
make
make install
popd
fi

#sdl_net-1.2.8
wget -nc http://www.libsdl.org/projects/SDL_net/release/SDL_net-1.2.8.tar.gz
tar xvf SDL_net-1.2.8.tar.gz
if [ -e ./SDL_net-1.2.8 ]; then
pushd SDL_net-1.2.8
../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --with-sdl-prefix=$TRIMUI_PREFIX --with-sdl-exec-prefix=/var/lib/trimui-toolchain//usr/arm-linux-gnueabi/sysroot/usr
make
make install
popd
fi

#sdl_sound-1.0.3
wget -nc http://icculus.org/SDL_sound/downloads/SDL_sound-1.0.3.tar.gz
tar xvf SDL_sound-1.0.3.tar.gz
if [ -e ./SDL_sound-1.0.3 ]; then
pushd SDL_sound-1.0.3
../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --with-sdl-prefix=$TRIMUI_PREFIX --disable-sdltest --enable-static --disable-mmx
make
make install
popd
fi

#freetype-2.6.3
wget -nc http://downloads.sourceforge.net/project/freetype/freetype2/2.6.3/freetype-2.6.3.tar.bz2
tar xvf freetype-2.6.3.tar.bz2
if [ -e ./freetype-2.6.3 ]; then
pushd freetype-2.6.3
#../../tool/ConfigConv configure
init_flags
CC=arm-linux-gnueabi-gcc CC_BUILD=arm-linux-gnueabi-gcc ./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --program-prefix= --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --with-zlib --with-bzip2
mkdir objs
cp -f ../../freetype/apinames.exe ./objs/apinames
make
make install
popd
fi

#sdl_ttf-2.0.11
wget -nc http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.11.tar.gz
tar xvf SDL_ttf-2.0.11.tar.gz
if [ -e ./SDL_ttf-2.0.11 ]; then
pushd SDL_ttf-2.0.11
../../tool/ConfigConv configure
init_flags
./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --build=arm-linux --prefix=$TRIMUI_PREFIX --disable-gtk-doc --disable-gtk-doc-html --disable-doc --disable-docs --disable-documentation --with-xmlto=no --with-fop=no --disable-dependency-tracking --enable-ipv6 --enable-static --enable-shared --without-x --with-freetype-prefix=-L$TRIMUI_PREFIX/lib --with-sdl-prefix=$TRIMUI_PREFIX
make
make install
popd
fi

#boost1.76.0
wget -nc https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.bz2
tar xvf boost_1_76_0.tar.bz2
if [ -e ./boost_1_76_0 ]; then
pushd boost_1_76_0
cp -f -r ./boost/ $TRIMUI_PREFIX/include/boost/
popd
fi

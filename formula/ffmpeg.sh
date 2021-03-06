package set summary "Play, record, convert, and stream audio and video"
package set webpage "https://ffmpeg.org"
package set src.url "https://ffmpeg.org/releases/ffmpeg-4.2.3.tar.xz"
package set src.sum "9df6c90aed1337634c1fb026fb01c154c29c82a64ea71291ff2da9aacb9aad31"
package set dep.pkg "sdl2 opus libwebp libvorbis libtheora speex x264 x265 lame"
package set bsystem "make"
package set binsrcd 'true'

prepare() {
    sed_in_place 's/Wl,-soname,/o /g' configure
}

build() {
    run ./configure \
        --prefix="$ABI_INSTALL_DIR" \
        --sysroot="$SYSROOT" \
        --ar="$AR" \
        --as="$AS" \
        --ld="$LD" \
        --cc="$CC" \
        --cxx="$CXX" \
        --nm="$NM" \
        --ranlib="$RANLIB" \
        --strip="$STRIP" \
        --arch="$TARGET_OS_ARCH" \
        --target-os=android \
        --enable-cross-compile \
        --enable-static \
        --enable-shared \
        --enable-pic \
        --disable-asm \
        --disable-doc \
        --disable-debug \
        --extra-cflags='-DANDROID' &&
    sed_in_place 's/LDEXEFLAGS= -fPIE -pie/LDEXEFLAGS= -shared/g' ffbuild/config.mak &&
    change_config_h &&
    makew clean &&
    makew install &&
    run cp ffbuild/config.log .
}

change_config_h() {
    #注释掉#define getenv(x) NULL，没有用，会报错
    sed_in_place "s/#define getenv(x) NULL/\\/\\/ #define getenv(x) NULL/" config.h
    sed_in_place "s/#define HAVE_TRUNC 0/#define HAVE_TRUNC 1/" config.h
    sed_in_place "s/#define HAVE_TRUNCF 0/#define HAVE_TRUNCF 1/" config.h
    sed_in_place "s/#define HAVE_RINT 0/#define HAVE_RINT 1/" config.h
    sed_in_place "s/#define HAVE_LRINT 0/#define HAVE_LRINT 1/" config.h
    sed_in_place "s/#define HAVE_LRINTF 0/#define HAVE_LRINTF 1/" config.h
    sed_in_place "s/#define HAVE_ROUND 0/#define HAVE_ROUND 1/" config.h
    sed_in_place "s/#define HAVE_ROUNDF 0/#define HAVE_ROUNDF 1/" config.h
    sed_in_place "s/#define HAVE_CBRT 0/#define HAVE_CBRT 1/" config.h
    sed_in_place "s/#define HAVE_CBRTF 0/#define HAVE_CBRTF 1/" config.h
    sed_in_place "s/#define HAVE_COPYSIGN 0/#define HAVE_COPYSIGN 1/" config.h
    sed_in_place "s/#define HAVE_ERF 0/#define HAVE_ERF 1/" config.h
    sed_in_place "s/#define HAVE_HYPOT 0/#define HAVE_HYPOT 1/" config.h
    sed_in_place "s/#define HAVE_ISNAN 0/#define HAVE_ISNAN 1/" config.h
    sed_in_place "s/#define HAVE_ISFINITE 0/#define HAVE_ISFINITE 1/" config.h
    sed_in_place "s/#define HAVE_INET_ATON 0/#define HAVE_INET_ATON 1/" config.h
}

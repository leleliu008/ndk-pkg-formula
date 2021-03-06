package set summary "GNU File, Shell, and Text utilities"
package set webpage "https://www.gnu.org/software/coreutils"
package set src.url "https://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz"
package set src.sum "4458d8de7849df44ccab15e16b1548b285224dbba5f08fac070c1c0e0bcc4cfa"
package set license "GPL-3.0"
package set bsystem "configure"

# no member named '_p' in 'struct __sFILE'  return fp->_p - fp->_bf._base;
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stdio.h.html
# https://github.com/android/ndk/issues/513
# https://github.com/innogames/android-ndk/blob/master/platforms/android-23/arch-arm/usr/include/stdio.h
package set sdk.api 23

build() {
    export CPPFLAGS="$CPPFLAGS -D__USE_FORTIFY_LEVEL=0"
    {
        if [ "$TARGET_OS_ARCH" = 'aarch64' ] ; then
            export CPPFLAGS="$CPPFLAGS -DSYS_getdents=61"
        fi
    } &&
    configure \
        --with-included-regex \
        --with-linux-crypto \
        --without-gmp \
        --without-openssl \
        --without-selinux \
        --disable-libcap \
        --disable-libsmack \
        --disable-assert \
        --disable-gcc-warnings \
        --disable-acl \
        --enable-xattr \
        --enable-threads=posix
}

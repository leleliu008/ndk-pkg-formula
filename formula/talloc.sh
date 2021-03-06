package set summary "Hierarchical, reference-counted memory pool with destructors"
package set webpage "https://talloc.samba.org/"
package set src.url "https://www.samba.org/ftp/talloc/talloc-2.3.2.tar.gz"
package set src.sum "27a03ef99e384d779124df755deb229cd1761f945eca6d200e8cfd9bf5297bd7"
package set license "GPL-3.0-or-later"
package set dep.cmd "python3"
package set binsrcd 'true'

# void seekdir(DIR* __dir, long __location) __INTRODUCED_IN(23);
# long telldir(DIR* __dir) __INTRODUCED_IN(23);
package set sdk.api 23

prepare() {
    sed_in_place 's|echo -n|printf|' buildtools/wafsamba/samba_cross.py &&
    cat <<EOF > cross-answers.txt
Checking uname sysname type: "Linux"
Checking uname machine type: "dontcare"
Checking uname release type: "dontcare"
Checking uname version type: "dontcare"
Checking simple C program: OK
building library support: OK
Checking for large file support: OK
Checking for -D_FILE_OFFSET_BITS=64: OK
Checking for WORDS_BIGENDIAN: OK
Checking for C99 vsnprintf: OK
Checking for HAVE_SECURE_MKSTEMP: OK
rpath library support: OK
-Wl,--version-script support: FAIL
Checking correct behavior of strtoll: OK
Checking correct behavior of strptime: OK
Checking for HAVE_IFACE_GETIFADDRS: OK
Checking for HAVE_IFACE_IFCONF: OK
Checking for HAVE_IFACE_IFREQ: OK
Checking getconf LFS_CFLAGS: OK
Checking for large file support without additional flags: OK
Checking for working strptime: OK
Checking for HAVE_SHARED_MMAP: OK
Checking for HAVE_MREMAP: OK
Checking for HAVE_INCOHERENT_MMAP: OK
Checking getconf large file support flags work: OK
EOF
}

build() {
    ./configure install \
        --prefix="$ABI_INSTALL_DIR" \
        --disable-rpath \
        --disable-python \
        --cross-compile \
        --cross-answers=cross-answers.txt &&
    $AR rcu libtalloc.a bin/default/talloc*.o &&
    install_libs libtalloc.a
}

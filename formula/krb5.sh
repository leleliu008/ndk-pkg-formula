package set summary "Network authentication protocol"
package set webpage "https://web.mit.edu/kerberos"
package set src.url "https://kerberos.org/dist/krb5/1.18/krb5-1.18.3.tar.gz"
package set src.sum "e61783c292b5efd9afb45c555a80dd267ac67eebabca42185362bee6c4fbd719"
package set sourced "src"
package set bsystem "configure"
package set dep.pkg "readline openssl berkeley-db libglob"
package set ldflags "-lglob -lncurses"

prepare() {
    sed_in_place '/search_paths_first"/d' configure && {
        for item in $(grep '<db.h>' -rl plugins/kdb/db2)
        do
            sed_in_place 's|<db.h>|<db_185.h>|g' "$item" || return 1
        done
    }
}

build() {
    # int getifaddrs(struct ifaddrs** __list_ptr) __INTRODUCED_IN(24);
    if [ "$TARGET_OS_VERS" -lt 24 ] ; then
        ac_cv_header_ifaddrs_h=no
    else
        ac_cv_header_ifaddrs_h=yes
    fi
    configure \
        --disable-static \
        --enable-dns-for-realm \
        --without-system-verto \
        --with-readline \
        --with-netlib=-lc \
        --with-size-optimizations \
        --with-system-db \
        krb5_cv_attr_constructor_destructor='yes,yes' \
        ac_cv_func_regcomp=yes \
        ac_cv_printf_positional=yes \
        ac_cv_lib_readline_main=yes \
        ac_cv_header_ifaddrs_h="$ac_cv_header_ifaddrs_h"
}

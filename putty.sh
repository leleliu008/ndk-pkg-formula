summary "Implementation of Telnet and SSH"
homepage "https://www.chiark.greenend.org.uk/~sgtatham/putty/"
url      "https://the.earth.li/~sgtatham/putty/0.74/putty-0.74.tar.gz"
sha256   "ddd5d388e51dd9e6e294005b30037f6ae802239a44c9dc9808c779e6d11b847d"

build() {
    # int glob(const char* __pattern, int __flags, int (*__error_callback)(const char* __failure_path, int __failure_errno), glob_t* __result_ptr) __INTRODUCED_IN(28);
    # void globfree(glob_t* __result_ptr) __INTRODUCED_IN(28);
    if [ "$MIN_SDK_API_LEVEL" -lt 28 ] ; then
        ac_cv_header_glob_h=no
    else
        ac_cv_header_glob_h=yes
    fi
    configure \
        --disable-gtktest \
        --without-gtk \
        ac_cv_header_glob_h="$ac_cv_header_glob_h"
}
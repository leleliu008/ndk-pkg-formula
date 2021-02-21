summary "Tool for generating GNU Standards-compliant Makefiles"
webpage "https://www.gnu.org/software/automake"
src_url "https://ftp.gnu.org/gnu/automake/automake-1.16.3.tar.xz"
src_sum "ff2bf7656c4d1c6fdda3b8bebb21f09153a736bcba169aaf65eab25fa113bf3a"
license "GPL-2.0-or-later"
require "m4 perl"

build() {
    configure
}

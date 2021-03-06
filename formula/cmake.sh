package set summary "Cross-platform make"
package set webpage "https://www.cmake.org"
package set src.url "https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4.tar.gz"
package set src.sum "597c61358e6a92ecbfad42a9b5321ddd801fc7e7eca08441307c9138382d4f77"
package set license "BSD-3-Clause"
package set bsystem "cmake"
package set dep.pkg "libuv ncurses"

prepare() {
    sed_in_place 's/defined(__linux__) || defined(_WIN32)/0/g' Source/cmake.cxx
}

build() {
    touch android_lf.h &&
    export CPPFLAGS="$CPPFLAGS -I$PWD" &&
    cmakew \
        -DBUILD_QtDialog=OFF \
        -DBUILD_CursesDialog=ON \
        -DCMake_BUILD_LTO=OFF \
        -DCMAKE_USE_SYSTEM_LIBUV=ON \
        -DCURSES_INCLUDE_PATH="$ncurses_INCLUDE_DIR" \
        -DCURSES_LIBRARY="$ncurses_LIBRARY_DIR/libncurses.so" \
        -DLibUV_INCLUDE_DIR="$libuv_INCLUDE_DIR" \
        -DLibUV_LIBRARY="$libuv_LIBRARY_DIR/libuv.so"
}

summary="Cross platform C99 library to get cpu features at runtime"
homepage="https://github.com/google/cpu_features"
version=0.5.0
url="https://github.com/google/cpu_features/archive/v$version.tar.gz"
sha256="b967811cecd68412e0dc65e4964756a6ae48755456fa2c2f42034f6271ac2c27"
license="Apache-2.0"

build() {
    cmake -DBUILD_PIC=ON
}

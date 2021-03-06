package set summary "Debug versions of system memory management routines"
package set webpage "https://dmalloc.com"
package set src.url "https://dmalloc.com/releases/dmalloc-5.5.2.tgz"
package set src.sum "d3be5c6eec24950cb3bd67dbfbcdf036f1278fae5fd78655ef8cdf9e911e428a"

prepare() {
    sed_in_place 's/ac_cv_page_size=0/ac_cv_page_size=1/' configure
}

build() {
    configure \
        --enable-cxx \
        --enable-shlib \
        --enable-threads
}

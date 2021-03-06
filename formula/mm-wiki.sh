package set summary "wiki manage service"
package set src.git "https://github.com/phachon/mm-wiki.git"
package set src.url "https://github.com/phachon/mm-wiki/archive/refs/tags/v0.2.1.tar.gz"
package set src.sum "56a1871d88ce8aca430a10108d6fd0213cf489fede9888148cd92d31e89b90db"
package set license "MIT"
package set bsystem 'go'

build() {
    run go build -v -trimpath -o mm-wiki &&
    run install_bins mm-wiki
}

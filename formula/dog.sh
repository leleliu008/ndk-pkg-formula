package set summary "Command-line DNS client"
package set webpage "https://dns.lookup.dog/"
package set src.git "https://github.com/ogham/dog.git"
package set src.url "https://github.com/ogham/dog/archive/v0.1.0.tar.gz"
package set src.sum "82387d38727bac7fcdb080970e84b36de80bfe7923ce83f993a77d9ac7847858"
package set license "EUPL-1.2"
package set dep.cmd "pkg-config"
package set dep.pkg "openssl"
package set bsystem "cargo"

build() {
    export OPENSSL_DIR="$openssl_INSTALL_DIR"
    run cargo clean &&
    run cargo install --target "$CARGO_TARGET" -vv --path "$SOURCE_DIR" --root="$ABI_INSTALL_DIR"
}
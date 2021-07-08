package set summary "Search tool like grep and The Silver Searcher"
package set src.git "https://github.com/BurntSushi/ripgrep.git"
package set src.url "https://github.com/BurntSushi/ripgrep/archive/13.0.0.tar.gz"
package set src.sum "0fb17aaf285b3eee8ddab17b833af1e190d73de317ff9648751ab0660d763ed2"
package set license "Unlicense"
package set bsystem "cargo"

build() {
    run cargo clean &&
    run cargo install --target "$CARGO_TARGET" -vv --path "$SOURCE_DIR" --root="$ABI_INSTALL_DIR"
}
# ParadiseSS13 RUST-G

This repository holds ParadiseSS13 modifications of [rust-g](https://github.com/tgstation/rust-g) libraries from /tg/station.

This works by keeping an up-to-date copy of /tg/station's code, and a folder of Paradise patches to be applied. This reduces our need for major reworks to code, as we can just use patches to achieve what we need without cluttering the main tree.

## License

The license for RUST-G itself can be found inside the `tg-rust-g` directory. Code for the Paradise modifications falls under the same license.

## How to (Compiling)

1. You **must** have a copy of `Git Bash` or some other bash emulator on windows, and a git identity setup. This will not work otherwise.
2. Run the `apply_patches.sh` file to autocreate a clone of `tg-rust-g`, and apply the patches to it.
3. Paradise RUST-G requires all features to be enabled.
    - To build on windows, run `cargo build --release --all-features --target=i686-pc-windows-msvc`. This will generate a 32-bit `.dll` file that is compatible with BYOND.
    - To build on linux, run `cargo build --release --all-features --target=i686-unknown-linux-gnu`. This will generate a 32-bit `.so` file that is compatible with BYOND.

If you are still stuck, check `tg-rust-g/README.md` for more detailed instructions.

## How to (Developing)

1. You **must** have a copy of `Git Bash` or some other bash emulator on windows, and a git identity setup. This will not work otherwise.
2. Run the `apply_patches.sh` file to autocreate a clone of `tg-rust-g`, and apply the patches to it.
3. Open the folder called `paradise-rust-g` inside an IDE of your choice. Make your edits in here.
4. Save your edits as a single commit inside `paradise-rust-g`. Do not push changes. Do not modify `tg-rust-g`.
5. Run the `rebuild_patches.sh` script to convert your commit into a patch that will be saved in the `paradise_patches` directory

## Credits

- /tg/station for the original RUST-G works.
- SpigotMC for the patching logic.

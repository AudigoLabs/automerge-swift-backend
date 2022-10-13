#! /bin/sh -e
# This script demonstrates archive and create action on frameworks and libraries
#

echo "▸ Update toolchain"
rustup update

echo "x86_64-apple-ios-macabi and aarch64-apple-ios-macabi require the nightly toolchain"
rustup toolchain install nightly
#rustup default nightly

# to allow for abi builds from the nightly toolchain for xargo...
rustup component add rust-src

echo "▸ Install xargo"
cargo install xargo

echo "▸ Install targets"
rustup target add x86_64-apple-ios
rustup target add aarch64-apple-ios
rustup target add aarch64-apple-ios-sim

echo "▸ Build x86_64-apple-ios"
cargo build --target x86_64-apple-ios --package automerge-c --release

echo "▸ Build aarch64-apple-ios-sim"
xargo build -Zbuild-std --target aarch64-apple-ios-sim --package automerge-c --release

echo "▸ Build aarch64-apple-ios"
cargo build --target aarch64-apple-ios --package automerge-c --release

echo "▸ Lipo simulator"
mkdir -p ./target/apple-ios-simulator/release
lipo -create  \
    ./target/x86_64-apple-ios/release/libautomerge.a \
    ./target/aarch64-apple-ios-sim/release/libautomerge.a \
    -output ./target/apple-ios-simulator/release/libautomerge.a

echo "#####################"
rm -rf ./xcframework/AutomergeBackend.xcframework

mkdir -p automerge-swift-backend/Headers
cp automerge-c/automerge.h automerge-swift-backend/Headers
printf "%s\n" "module AutomergeBackend {" "    header \"automerge.h\"" "    export *" "}" > automerge-swift-backend/Headers/module.modulemap

echo "▸ Create AutomergeRSBackend.xcframework"
  xcodebuild -create-xcframework \
            -library ./target/apple-ios-simulator/release/libautomerge.a \
            -headers ./automerge-swift-backend/Headers \
            -library ./target/aarch64-apple-ios/release/libautomerge.a \
            -headers ./automerge-swift-backend/Headers \
            -output ./xcframework/AutomergeBackend.xcframework

echo "▸ Compress AutomergeRSBackend.xcframework"
ditto -c -k --sequesterRsrc --keepParent ./xcframework/AutomergeBackend.xcframework ./automerge-swift-backend/AutomergeBackend.xcframework.zip

echo "▸ Compute AutomergeRSBackend.xcframework checksum"
cd automerge-swift-backend
swift package compute-checksum ./AutomergeBackend.xcframework.zip

echo "▸ Copy AutomergeRSBackend.xcframework"
cp -r ../xcframework/AutomergeBackend.xcframework ./

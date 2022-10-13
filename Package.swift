// swift-tools-version:5.3
//
//  Package.swift
//
//  Copyright © 2016  Lukas Schmidt. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//
//  Created by Lukas Schmidt on 21.07.16.
//

import PackageDescription

let package = Package(
    name: "AutomergeBackend",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "AutomergeBackend", targets: ["AutomergeBackend"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "AutomergeBackend",
            url: "https://github.com/AudigoLabs/automerge-swift-backend/releases/download/0.1.14/AutomergeBackend.xcframework.zip",
            checksum: "29a89c4aaaf6ef761626ce5451e6da58e46593e248ca6eb8a52b603845a1db9e"
        )
    ]
)

// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LaTeXSwiftUI",
  platforms: [
    .iOS(.v16),
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "LaTeXSwiftUI",
      targets: ["LaTeXSwiftUI"]),
  ],
  dependencies: [
    .package(path: "../HTMLEntities"),
    .package(path: "../MathJaxSwift"),
    .package(path: "../SVGView")
  ],
//  dependencies: [
//     .package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.4.0"),
//     .package(url: "https://github.com/exyte/SVGView", from: "1.0.4"),
//     .package(url: "https://github.com/Kitura/swift-html-entities", from: "4.0.1")
//  ],
  targets: [
    .target(
      name: "LaTeXSwiftUI",
      dependencies: [
          .product(name: "HTMLEntities", package: "htmlentities"),
          .product(name: "MathJaxSwift", package: "mathjaxswift"),
          .product(name: "SVGView", package: "svgview")
      ]),
    .testTarget(
      name: "LaTeXSwiftUITests",
      dependencies: ["LaTeXSwiftUI"]),
  ]
)

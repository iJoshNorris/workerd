# WARNING: THIS FILE IS AUTOGENERATED BY update-deps.py DO NOT EDIT

load("@//:build/http.bzl", "http_file")

TAG_NAME = "0.54.1"
URL = "https://github.com/bazelbuild/rules_rust/releases/download/0.54.1/cargo-bazel-x86_64-apple-darwin"
SHA256 = "2ee14b230d32c05415852b7a388b76e700c87c506459e5b31ced19d6c131b6d0"

def dep_cargo_bazel_macos_x64():
    http_file(
        name = "cargo_bazel_macos_x64",
        url = URL,
        executable = True,
        sha256 = SHA256,
    )
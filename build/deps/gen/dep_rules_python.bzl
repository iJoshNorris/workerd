# WARNING: THIS FILE IS AUTOGENERATED BY update-deps.py DO NOT EDIT

load("@//:build/http.bzl", "http_archive")

TAG_NAME = "0.37.0"
URL = "https://api.github.com/repos/bazelbuild/rules_python/tarball/0.37.0"
STRIP_PREFIX = "bazelbuild-rules_python-0c0492d"
SHA256 = "442740dfce802db482633d11302ef0894c2d8641c988aa1aa8f129acccdee2be"
TYPE = "tgz"

def dep_rules_python():
    http_archive(
        name = "rules_python",
        url = URL,
        strip_prefix = STRIP_PREFIX,
        type = TYPE,
        sha256 = SHA256,
    )
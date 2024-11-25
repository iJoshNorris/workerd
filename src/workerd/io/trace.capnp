# Copyright (c) 2017-2022 Cloudflare, Inc.
# Licensed under the Apache 2.0 license found in the LICENSE file or at:
#     https://opensource.org/licenses/Apache-2.0

@0xc40f73be329a38d9;

using Cxx = import "/capnp/c++.capnp";
$Cxx.namespace("workerd::rpc");

# This file only contains trace helper structures – due to C++ include size constraints we should
# avoid including capnp interfaces in frequently used files where possible.

struct TagValue {
  union {
    string @0 :Text;
    bool @1 :Bool;
    int64 @2 :Int64;
    float64 @3 :Float64;
  }
}

struct Tag {
  key @0 :Text;
  value @1 :TagValue;
}


// Copyright (c) 2024 Cloudflare, Inc.
// Licensed under the Apache 2.0 license found in the LICENSE file or at:
//     https://opensource.org/licenses/Apache-2.0

#pragma once

#include <array>
#include <kj/string.h>
#include <kj/map.h>

namespace kj {
enum class HttpMethod;
class EntropySource;
}  // namespace kj

namespace workerd::lime {
class LimeSpanParent;
class LimeSpanBuilder;
}  // namespace workerd::lime

namespace workerd {

using kj::byte;
using kj::uint;

// Supported types in OTel, also see Span::TagValue
enum class lime_tag_type { BOOL, INT64, DOUBLE, STRING };

struct LimeTagDefinition {
  kj::LiteralStringConst name;
  lime_tag_type type;
};

template <size_t num_tags>
struct LimeSpanDefinition {
  kj::LiteralStringConst name;
  kj::LiteralStringConst desc;
  // Could use FixedArray here, but that is not constexpr?
  std::array<LimeTagDefinition, num_tags> supported_tags;
};

namespace lime_spans {
constexpr LimeTagDefinition FAAS_INVOCATION_ID("faas.invocation_id"_kjc, lime_tag_type::STRING);
constexpr LimeTagDefinition FAAS_TRIGGER("faas.trigger"_kjc, lime_tag_type::STRING);
constexpr LimeTagDefinition FAAS_VERSION("faas.version"_kjc, lime_tag_type::STRING);
constexpr LimeTagDefinition FAAS_INV_NAME("faas.invoked_name"_kjc, lime_tag_type::STRING);

constexpr LimeTagDefinition TAG_COLO("colo_id"_kjc, lime_tag_type::STRING);
constexpr LimeTagDefinition FAAS_INV_REGION("faas.invoked_region"_kjc, lime_tag_type::STRING);

constexpr LimeTagDefinition TAG_OWNER_ID("ownerId"_kjc, lime_tag_type::INT64);
// TODO: We'd want to have script name and script version instead of deployment ID and script ID
// here. May need to be looked up externally.
constexpr LimeTagDefinition TAG_DEPLOYMENT_ID("deploymentId"_kjc, lime_tag_type::INT64);
constexpr LimeTagDefinition TAG_SCRIPT_ID("scriptId"_kjc, lime_tag_type::STRING);

constexpr LimeSpanDefinition<9> WORKER_SPAN{.name = "worker"_kjc,
  .desc = "The entire lifespan of a Workers request including sending the response."_kjc,
  .supported_tags = {FAAS_INVOCATION_ID, FAAS_TRIGGER, FAAS_VERSION, FAAS_INV_NAME, FAAS_INV_REGION,
    TAG_OWNER_ID, TAG_COLO, TAG_DEPLOYMENT_ID, TAG_SCRIPT_ID}};
}  // namespace lime_spans

};  // namespace workerd
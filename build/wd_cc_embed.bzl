load("@bazel_skylib//rules:write_file.bzl", "write_file")

# A high-performance embed mechanism built upon C23. Prefer this over capnp embeds unless the embed is needed within capnp definitions.
# name: A valid C variable name.
# embed_file: The name of the file to be embedded. It is unclear if this works for files outside of the current package.
# Generates a library target "name" and a header embed_file.h for accessing the variable name as a const char array.
def wd_cc_embed(name, embed_file):
    embed_file = native.package_relative_label(embed_file).name
    write_file(
        name = embed_file + "@c",
        out = embed_file + ".c",
        content = ["""const char {name}[] = {{
  #embed <{embed}>
}};""".format(name = name, embed = embed_file)],
    )
    write_file(
        name = embed_file + "@h",
        out = embed_file + ".h",
        content = ["""#ifdef __cplusplus
extern "C" {{
#endif
extern const char {name}[];
#ifdef __cplusplus
}}
#endif""".format(name = name)],
    )
    native.cc_library(
        name = name,
        srcs = [embed_file + ".c"],
        hdrs = [embed_file + ".h"],
        visibility = ["//visibility:public"],
        additional_compiler_inputs = [
            embed_file,
        ],
        copts = [
            # no need to have debug info for the embed
            "-g0",
            # C23 is needed for N3017 #embed. Clang also supports it in C++26 mode but it is not
            # officially part of that standard so far and there's no harm in using C on a per-file
            # basis.
            "-std=c23",
            # HACK: We need to provide the path to the embed file directory here. We gain access to
            # it by adding it to additional_compiler_inputs and can get the file path easily using
            # "$(location embed_file)", but there seems to be no elegant way to get its directory
            # (or to just cut off the filename) within the scope of a macro.
            "--embed-dir=" + "$(GENDIR)/" + native.package_relative_label(embed_file).workspace_root + "/" + native.package_relative_label(embed_file).package,
        ],
    )

def _impl(repository_ctx):
    repository_ctx.download_and_extract(repository_ctx.attr.url, stripPrefix = "wpt-merge_pr_48497")
    result = repository_ctx.execute(["bash", "-c", "ls"])
    dirs = result.stdout.split("\n")

    # print("===> ", result.return_code, result.stdout)
    repository_ctx.file("BUILD", content = "\n".join(["""
wpt_test(name = "{}")
    """.format(dir) for dir in dirs]))

wpt_tests = repository_rule(
    implementation = _impl,
    attrs = {
        "url": attr.string(mandatory = True),
        # "sha256": attr.string(mandatory = True),
    },
)

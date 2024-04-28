load("@rules_cc//cc:defs.bzl", "cc_binary")

# cc_library(
#     name = "hello-greet",
#     srcs = ["hello-greet.cc"],
#     hdrs = ["hello-greet.h"],
# )

cc_binary(
    name = "hello-world",
    srcs = ["hello-world.cc"],
    deps = [
        "//lib:hello",
    ],
    includes = [
        # "$(rootpath)/lib"
        "../lib"
        # "@/lib"
    ]
)

load("@rules_cc//cc:defs.bzl", "cc_toolchain_suite","cc_toolchain")
load(":cc_toolchain_config.bzl", "cc_toolchain_config")
package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "clang_suite",
    toolchains = {
        "X64": ":x64_toolchain",
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "x64_toolchain",
    toolchain_identifier = "x64-toolchain",
    toolchain_config = ":x64_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)



cc_toolchain_config(name = "x64_toolchain_config")





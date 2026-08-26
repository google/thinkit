# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Third party dependencies.

Please read carefully before adding new dependencies:
- Any dependency can break all of pins-infra. Please be mindful of that before
  adding new dependencies. Try to stick to stable versions of widely used libraries.
  Do not depend on private repositories and forks.
- Fix dependencies to a specific version or commit, so upstream changes cannot break
  pins-infra. Prefer releases over arbitrary commits when both are available.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def thinkit_deps():
    """Sets up 3rd party workspaces needed to build Thinkit."""

    # Bazel rules for building C++ targets (cc_library, cc_test, cc_binary).
    if not native.existing_rule("rules_cc"):
        http_archive(
            name = "rules_cc",
            sha256 = "b8b918a85f9144c01f6cfe0f45e4f2838c7413961a8ff23bc0c6cdf8bb07a3b6",
            strip_prefix = "rules_cc-0.1.5",
            url = "https://github.com/bazelbuild/rules_cc/releases/download/0.1.5/rules_cc-0.1.5.tar.gz",
        )

    # gRPC C++ library for RPC communication with switches, control devices, and testbed services.
    if not native.existing_rule("com_github_grpc_grpc"):
        http_archive(
            name = "com_github_grpc_grpc",
            url = "https://github.com/grpc/grpc/archive/refs/tags/v1.83.0.tar.gz",
            strip_prefix = "grpc-1.83.0",
            sha256 = "90d453393a9d41215df546103b10b33b9566df79cdf6f49dc67f6c4d044d090d",
            repo_mapping = {
                "@abseil-cpp": "@com_google_absl",
            },
        )

    # Abseil C++ common libraries (status, strings, containers, synchronization, time).
    if not native.existing_rule("com_google_absl"):
        http_archive(
            name = "com_google_absl",
            url = "https://github.com/abseil/abseil-cpp/archive/refs/tags/20250512.1.tar.gz",
            strip_prefix = "abseil-cpp-20250512.1",
            sha256 = "9b7a064305e9fd94d124ffa6cc358592eb42b5da588fb4e07d09254aa40086db",
        )

    # GoogleTest and GoogleMock for unit tests, testbed fixtures, and mock implementations.
    if not native.existing_rule("com_google_googletest"):
        http_archive(
            name = "com_google_googletest",
            urls = ["https://github.com/google/googletest/releases/download/v1.17.0/googletest-1.17.0.tar.gz"],
            strip_prefix = "googletest-1.17.0",
            sha256 = "65fab701d9829d38cb77c14acdc431d2108bfdbf8979e40eb8ae567edf10b27c",
        )

    # Google Benchmark library for performance and latency benchmarking in tests.
    if not native.existing_rule("com_google_benchmark"):
        http_archive(
            name = "com_google_benchmark",
            urls = ["https://github.com/google/benchmark/archive/refs/tags/v1.9.5.tar.gz"],
            strip_prefix = "benchmark-1.9.5",
            sha256 = "9631341c82bac4a288bef951f8b26b41f69021794184ece969f8473977eaa340",
        )

    # Protocol Buffers library and compiler for generating C++ message and service bindings.
    if not native.existing_rule("com_google_protobuf"):
        http_archive(
            name = "com_google_protobuf",
            url = "https://github.com/protocolbuffers/protobuf/archive/refs/tags/v33.5.tar.gz",
            strip_prefix = "protobuf-33.5",
            sha256 = "440848dffa209beb8a04e41cc352762e44f8e91342b2a43aab6af9b30713c2f6",
            repo_mapping = {
                "@abseil-cpp": "@com_google_absl",
            },
        )

    # RE2 regular expression library (pinned so grpc_deps() does not download an incompatible older release).
    if not native.existing_rule("com_googlesource_code_re2"):
        http_archive(
            name = "com_googlesource_code_re2",
            url = "https://github.com/google/re2/releases/download/2025-11-05/re2-2025-11-05.tar.gz",
            strip_prefix = "re2-2025-11-05",
            sha256 = "87f6029d2f6de8aa023654240a03ada90e876ce9a4676e258dd01ea4c26ffd67",
        )

    # Google APIs common proto definitions (e.g. google.rpc.Status), required by gRPC and P4Runtime.
    if not native.existing_rule("com_google_googleapis"):
        http_archive(
            name = "com_google_googleapis",
            url = "https://github.com/googleapis/googleapis/archive/f405c718d60484124808adb7fb5963974d654bb4.zip",
            strip_prefix = "googleapis-f405c718d60484124808adb7fb5963974d654bb4",
            sha256 = "406b64643eede84ce3e0821a1d01f66eaf6254e79cb9c4f53be9054551935e79",
        )

    # Google C++ utility library providing status matchers, test artifact writer, and test helpers.
    if not native.existing_rule("com_google_gutil"):
        http_archive(
            name = "com_google_gutil",
            # Newest commit on main as of 2025-05-14.
            url = "https://github.com/google/gutil/archive/d2f1bdd819287c3951adaba5ea6e5426d2eefff1.zip",
            strip_prefix = "gutil-d2f1bdd819287c3951adaba5ea6e5426d2eefff1",
            sha256 = "033bcab2835a0aea0427d38503f5ae2bd478af134ab8f3e75b65d2cd444ac8ca",
        )

    # Open Traffic Generator (OTG) proto models and gRPC services for traffic generator integration.
    if not native.existing_rule("com_github_otg_models"):
        http_archive(
            name = "com_github_otg_models",
            url = "https://github.com/open-traffic-generator/models/archive/refs/tags/v0.12.5.zip",
            strip_prefix = "models-0.12.5",
            build_file = "@com_github_google_thinkit//:bazel/BUILD.otg-models.bazel",
            sha256 = "1a63e769f1d7f42c79bc1115babf54acbc44761849a77ac28f47a74567f10090",
        )

    # gNMI (gRPC Network Management Interface) proto definitions and service stubs for switch telemetry.
    if not native.existing_rule("com_github_gnmi"):
        http_archive(
            name = "com_github_gnmi",
            # v0.10.0 release; commit-hash:5473f2ef722ee45c3f26eee3f4a44a7d827e3575.
            url = "https://github.com/openconfig/gnmi/archive/refs/tags/v0.10.0.zip",
            strip_prefix = "gnmi-0.10.0",
            patch_args = ["-p1"],
            patches = [
                "@com_github_google_thinkit//:bazel/patches/gnmi-001-fix_virtual_proto_import.patch",
            ],
            sha256 = "2231e1cc398a523fa840810fa6fdb8960639f7b91b57bb8f12ed8681e0142a67",
        )

    # gNOI (gRPC Network Operations Interface) proto definitions and service stubs for switch operations.
    if not native.existing_rule("com_github_gnoi"):
        http_archive(
            name = "com_github_gnoi",
            # Newest commit on main on 2021-11-08.
            url = "https://github.com/openconfig/gnoi/archive/1ece8ed91a0d5d283219a99eb4dc6c7eadb8f287.zip",
            strip_prefix = "gnoi-1ece8ed91a0d5d283219a99eb4dc6c7eadb8f287",
            sha256 = "991ff13a0b28f2cdc2ccb123261e7554d9bcd95c00a127411939a3a8c8a9cc62",
            patch_args = ["-p1"],
            patches = [
                "@com_github_google_thinkit//:bazel/patches/gnoi-001-generate-mocks.patch",
            ],
        )

    # Rules Go, required because P4Runtime defines multi-language proto targets in the same BUILD files.
    if not native.existing_rule("io_bazel_rules_go"):
        http_archive(
            name = "io_bazel_rules_go",
            sha256 = "91585017debb61982f7054c9688857a2ad1fd823fc3f9cb05048b0025c47d023",
            urls = [
                "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
                "https://github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
            ],
        )

    # P4Runtime proto definitions and gRPC service stubs for controlling P4-programmable switches.
    if not native.existing_rule("com_github_p4lang_p4runtime"):
        # We frequently need bleeding-edge, unreleased version of P4Runtime, so we use a commit
        # rather than a release.
        http_archive(
            name = "com_github_p4lang_p4runtime",
            # Newest (and only) commit on `bazel-workspace-support-no-strip` branch as of 2026-04-02.
            urls = [
                "https://github.com/matthewtlam/p4runtime/archive/b9375ada8acffc3f1fbdb71c20b33bc58ed5b75f.zip",
            ],
            strip_prefix = "p4runtime-b9375ada8acffc3f1fbdb71c20b33bc58ed5b75f/proto",
            sha256 = "e2f401c01c708b6f7c6a8f67fd2cf2982e8e7daa525de3ddd18446eb3a807299",
        )

    # Bazel rules and toolchains for compiling Protocol Buffers.
    if not native.existing_rule("rules_proto"):
        http_archive(
            name = "rules_proto",
            urls = [
                "https://github.com/bazelbuild/rules_proto/archive/5.3.0-21.7.tar.gz",
            ],
            strip_prefix = "rules_proto-5.3.0-21.7",
            sha256 = "dc3fb206a2cb3441b485eb1e423165b231235a1ea9b031b4433cf7bc1fa460dd",
        )

    # Pre-built Buildifier binary for formatting and linting Bazel files (used in format.sh).
    if not native.existing_rule("buildifier_prebuilt"):
        http_archive(
            name = "buildifier_prebuilt",
            sha256 = "f635ebab2b5ea65dd4fdc16f77565aea920e8231e37aef9441fd346254c16f46",
            urls = [
                "https://mirror.bazel.build/github.com/keith/buildifier-prebuilt/releases/download/8.5.1.3/buildifier-prebuilt.8.5.1.3.tar.gz",
                "https://github.com/keith/buildifier-prebuilt/releases/download/8.5.1.3/buildifier-prebuilt.8.5.1.3.tar.gz",
            ],
        )

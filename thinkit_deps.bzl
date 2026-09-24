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

"""Non-module dependencies for ThinKit (Bzlmod module extension)."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _non_module_deps_impl(_ctx):
    http_archive(
        name = "com_github_otg_models",
        build_file = "//:bazel/BUILD.otg-models.bazel",
        sha256 = "1a63e769f1d7f42c79bc1115babf54acbc44761849a77ac28f47a74567f10090",
        strip_prefix = "models-0.12.5",
        url = "https://github.com/open-traffic-generator/models/archive/refs/tags/v0.12.5.zip",
    )

non_module_deps = module_extension(
    implementation = _non_module_deps_impl,
)

// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef THINKIT_THINKIT_BAZEL_TEST_ENVIRONMENT_H_
#define THINKIT_THINKIT_BAZEL_TEST_ENVIRONMENT_H_

#include <functional>
#include <string>
#include <utility>
#include <vector>

#include "absl/status/status.h"
#include "absl/strings/string_view.h"
#include "google/protobuf/message.h"
#include "gutil/test_artifact_writer.h"
#include "thinkit/proto/metrics.pb.h"
#include "thinkit/test_environment.h"

namespace thinkit {

// Simple `thinkit::TestEnvironment` that works well with the Bazel build
// system.
// Calls to {Store,AppendTo}TestArtifact within a BazelTestEnvironment
// object are guaranteed to be thread-safe due to writes being sequential.
class BazelTestEnvironment : public TestEnvironment {
 public:
  BazelTestEnvironment() = delete;
  explicit BazelTestEnvironment(
      bool mask_known_failures,
      std::function<void(const std::vector<std::string>&)> set_test_case_ids =
          [](auto) {},
      std::function<void(absl::string_view)> save_switch_logs = [](auto) {},
      std::function<void(const thinkit::MetricGroup&)> record_metrics =
          [](const thinkit::MetricGroup&) {})
      : mask_known_failures_{mask_known_failures},
        set_test_case_ids_(std::move(set_test_case_ids)),
        save_switch_logs_(std::move(save_switch_logs)),
        record_metrics_(std::move(record_metrics)) {}

  absl::Status StoreTestArtifact(absl::string_view filename,
                                 absl::string_view contents) override;
  absl::Status StoreTestArtifact(absl::string_view filename,
                                 const google::protobuf::Message& proto);

  absl::Status AppendToTestArtifact(absl::string_view filename,
                                    absl::string_view contents) override;
  absl::Status AppendToTestArtifact(absl::string_view filename,
                                    const google::protobuf::Message& proto);

  bool MaskKnownFailures() override { return mask_known_failures_; };

  void SetTestCaseIDs(const std::vector<std::string>& test_case_ids) override {
    set_test_case_ids_(test_case_ids);
  }

  void SaveSwitchLogs(absl::string_view prefix) override {
    save_switch_logs_(prefix);
  }

  void RecordMetrics(const thinkit::MetricGroup& metric_group) override {
    record_metrics_(metric_group);
  }

 private:
  bool mask_known_failures_;
  std::function<void(const std::vector<std::string>&)> set_test_case_ids_;
  std::function<void(absl::string_view)> save_switch_logs_;
  std::function<void(const thinkit::MetricGroup&)> record_metrics_;
  gutil::BazelTestArtifactWriter artifact_writer_;
};

}  // namespace thinkit

#endif  // THINKIT_THINKIT_BAZEL_TEST_ENVIRONMENT_H_

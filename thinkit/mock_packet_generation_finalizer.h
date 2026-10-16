// Copyright (c) 2024, Google Inc.
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

#ifndef THINKIT_THINKIT_MOCK_PACKET_GENERATION_FINALIZER_H_
#define THINKIT_THINKIT_MOCK_PACKET_GENERATION_FINALIZER_H_

#include "absl/status/status.h"
#include "absl/time/time.h"
#include "gmock/gmock.h"
#include "thinkit/packet_generation_finalizer.h"

namespace thinkit {

// Mock implementation of `PacketGenerationFinalizer` for use in unit tests.
//
// Example usage with `MockControlDevice::CollectPackets`:
//
//   MockControlDevice device;
//   auto finalizer = std::make_unique<MockPacketGenerationFinalizer>();
//   MockPacketGenerationFinalizer& finalizer_ref = *finalizer;
//
//   EXPECT_CALL(device, CollectPackets())
//       .WillOnce(Return(ByMove(std::move(finalizer))));
//
//   EXPECT_CALL(finalizer_ref, HandlePacketsFor(absl::Seconds(1), _))
//       .WillOnce(Return(absl::OkStatus()));
//
class MockPacketGenerationFinalizer : public PacketGenerationFinalizer {
 public:
  MOCK_METHOD(absl::Status, HandlePacketsFor,
              (absl::Duration duration, PacketCallback handler), (override));
};

}  // namespace thinkit

#endif  // THINKIT_THINKIT_MOCK_PACKET_GENERATION_FINALIZER_H_

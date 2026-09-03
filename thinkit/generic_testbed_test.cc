// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "thinkit/generic_testbed.h"

#include <sstream>

#include "gtest/gtest.h"

namespace thinkit {
namespace {

TEST(HttpResponse, DefaultResponseCodeIsZero) {
  HttpResponse response;
  EXPECT_EQ(response.response_code, 0);
  EXPECT_TRUE(response.response.empty());
}

TEST(HttpResponse, StreamInsertionOperatorWorks) {
  std::stringstream ss;
  ss << HttpResponse{.response_code = 400, .response = "Bad Request"};
  EXPECT_EQ(ss.str(), "400: Bad Request");
}

TEST(InterfaceInfo, DefaultPeerDeviceIndexIsZero) {
  InterfaceInfo info;
  EXPECT_EQ(info.peer_device_index, 0);
  EXPECT_TRUE(info.peer_interface_name.empty());
  EXPECT_TRUE(info.peer_mac_address.empty());
  EXPECT_TRUE(info.peer_ipv4_address.empty());
  EXPECT_TRUE(info.peer_ipv6_address.empty());
  EXPECT_TRUE(info.peer_traffic_location.empty());
}

}  // namespace
}  // namespace thinkit

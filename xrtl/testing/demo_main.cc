// Copyright 2017 Google Inc.
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

#include "xrtl/testing/demo_main.h"

#include <string>

#include "xrtl/base/debugging.h"
#include "xrtl/base/flags.h"
#include "xrtl/base/logging.h"

namespace xrtl {
namespace testing {

int DemoMain(int argc, char** argv) {
  // Attach a console so we can write output to stdout. If the user hasn't
  // redirected output themselves it'll pop up a window.
  xrtl::debugging::AttachConsole();

  // Setup flags.
  xrtl::flags::SetUsageMessage(std::string("\n$ ") + argv[0]);
  xrtl::flags::ParseCommandLineFlags(&argc, &argv, true);

  int exit_code = GetEntryPoint()(argc, argv);

  xrtl::flags::ShutDownCommandLineFlags();

  return exit_code;
}

}  // namespace testing
}  // namespace xrtl
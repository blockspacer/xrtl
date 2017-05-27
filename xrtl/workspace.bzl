# Description:
#  XRTL common workspace that can be merged into subproject workspaces.
#
#  Usage:
#    my/WORKSPACE:
#      load("//xrtl:workspace.bzl", "xrtl_workspace")
#      xrtl_workspace()


# Parses the bazel version string from `native.bazel_version`.
def _parse_bazel_version(bazel_version):
  # Remove commit from version.
  version = bazel_version.split(" ", 1)[0]

  # Split into (release, date) parts and only return the release
  # as a tuple of integers.
  parts = version.split('-', 1)

  # Turn "release" into a tuple of strings
  version_tuple = ()
  for number in parts[0].split('.'):
    version_tuple += (str(number),)
  return version_tuple


# Checks that a specific bazel version is being used.
def check_version(bazel_version):
  if "bazel_version" not in dir(native):
    fail("\nCurrent Bazel version is lower than 0.2.1, expected at least %s\n" % bazel_version)
  elif not native.bazel_version:
    print("\nCurrent Bazel is not a release version, cannot check for compatibility.")
    print("Make sure that you are running at least Bazel %s.\n" % bazel_version)
  else:
    current_bazel_version = _parse_bazel_version(native.bazel_version)
    minimum_bazel_version = _parse_bazel_version(bazel_version)
    if minimum_bazel_version > current_bazel_version:
      fail("\nCurrent Bazel version is {}, expected at least {}\n".format(
          native.bazel_version, bazel_version))
  pass


def xrtl_workspace():
  # Verify supported bazel version.
  check_version("0.4.5")

  # //third_party/gflags/
  native.new_local_repository(
      name = "com_github_gflags_gflags",
      path = "third_party/gflags/",
      build_file = "third_party/gflags.BUILD",
  )

  # //third_party/glslang/
  native.new_local_repository(
      name = "com_github_KhronosGroup_glslang",
      path = "third_party/glslang/",
      build_file = "third_party/glslang.BUILD",
  )

  # //third_party/spirv_cross/
  native.new_local_repository(
      name = "com_github_KhronosGroup_SPIRV_Cross",
      path = "third_party/spirv_cross/",
      build_file = "third_party/spirv_cross.BUILD",
  )

  # //third_party/spirv_headers/
  native.new_local_repository(
      name = "com_github_KhronosGroup_SPIRV_Headers",
      path = "third_party/spirv_headers/",
      build_file = "third_party/spirv_headers.BUILD",
  )

  # //third_party/spirv_tools/
  # NOTE: this would be com_github_KhronosGroup_SPIRV_Tools, but that causes
  #       path limit issues on Windows.
  native.new_local_repository(
      name = "spirv_tools",
      path = "third_party/spirv_tools/",
      build_file = "third_party/spirv_tools.BUILD",
  )

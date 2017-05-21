pkg_origin=nerd
pkg_name=myapp
pkg_version=0.1.0
pkg_maintainer="The Habitat Maintainers <jeegiks@gmail.com>"
pkg_upstream_url="https://github.com/gitgik/habitat-plan"
pkg_source=nosuchfile.tar.gz
pkg_deps=(core/node)
pkg_exports=(
  [port]=listening_port
)
pkg_exposes=(port)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dist_dirs=(dist)


do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  # copy the contents of the source directory to the habitat cache path
  cp -vr $PLAN_CONTEXT/../source/*  $HAB_CACHE_SRC_PATH/$pkg_dirname

  # install the npm dev dependencies listed in package.json
  npm install
}

do_install() {
  # copy the node scripts into the root directory of our package using the pkg_prefix variable
  cp package.json ${pkg_prefix}
  cp -r /.[^.]* ${pkg_prefix}
  cp -r lib/* ${pkg_prefix}/lib

  # copy the node modules into the package using the pkg_prefix variable
  mkdir -p ${pkg_prefix}/node_modules/
  cp -vr node_modules/* ${pkg_prefix}/node_modules

  # copy the lib containing the app entry point: server.js
  mkdir -p ${pkg_prefix}/lib/
  cp -vr lib/* ${pkg_prefix}/lib
}

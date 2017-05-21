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

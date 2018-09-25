name "xtrabackup"
default_version "2.4.12"

skip_transitive_dependency_licensing true
dependency 'libffi'

source url: "https://s3.amazonaws.com/twindb-release/percona-xtrabackup-2.4.12.tar.gz",
       md5: "c086206421a77f7c1ad28771a75cf396"

relative_path "percona-xtrabackup-2.4.12"
whitelist_file /.*/

workers = 2

build do
    env = with_standard_compiler_flags(with_embedded_path)
    command "cmake -DBUILD_CONFIG=xtrabackup_release " \
          "-DWITH_MAN_PAGES=OFF -DDOWNLOAD_BOOST=1 " \
          "-DWITH_BOOST=#{install_dir}/libboost " \
          "-DWITH_SSL=system " \
          "-DINSTALL_BINDIR=#{install_dir}/embedded/bin", env: env

    make "-j #{workers}", env: env
    make "install", env: env
end

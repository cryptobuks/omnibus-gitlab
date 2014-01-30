name "git"
version "1.0.0"

dependency "zlib"
dependency "openssl"
dependency "curl"

source :url => "https://git-core.googlecode.com/files/git-1.8.5.3.tar.gz",
       :md5 => "57b966065882f83ef5879620a1e329ca"

relative_path 'git-1.8.5.3'

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "NO_PERL" => "1",
  "NO_EXPAT" => "1",
  "NO_TCLTK" => "1",
  "NO_GETTEXT" => "1",
  "NO_PYTHON" => "1"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-curl=#{install_dir}/embedded",
           "--with-ssl=#{install_dir}/embedded",
           "--with-zlib=#{install_dir}/embedded"].join(" "), :env => env

  command "make -j #{max_build_jobs}", :env => env
  command "make install"
end

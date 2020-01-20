require 'formula'

class Bfgminer < Formula
  homepage 'https://github.com/luke-jr/bfgminer'
  head 'https://github.com/luke-jr/bfgminer.git', :branch => 'bfgminer'
  url 'https://github.com/broberson/bfgminer/releases/download/bfgminer-5.5.0/bfgminer-bfgminer-5.5.0.zip'
  sha256 '92a60ce3be79a0988f078d268fa13ee425920b0b99f8fd87ffeed36e1ff8a099'
  version '5.5.0'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'uthash' => :build
  depends_on 'curl'
  depends_on 'jansson'
  depends_on 'libmicrohttpd'
  depends_on 'libevent'
  depends_on 'libusb'
  depends_on 'hidapi'
  depends_on 'gnu-sed'

  def install
    inreplace "gen-version.sh", "sed", "gsed"
    system "chmod +x *.sh"
    system "NOSUBMODULES=1 ./autogen.sh"
    system "chmod +x configure"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "PKG_CONFIG_PATH=#{HOMEBREW_PREFIX}/opt/curl/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/jansson/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/libmicrohttpd/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/libusb/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/hidapi/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/libevent/lib/pkgconfig",
                          "--enable-scrypt",
                          "--enable-keccak",
                          "--enable-opencl"
    system "make", "install"
  end

  test do
    system "bfgminer"
  end
end

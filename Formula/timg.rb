class Timg < Formula
  desc "Terminal image and video viewer"
  homepage "https://timg.sh/"
  url "https://github.com/hzeller/timg/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "99ea217643c506afce2cb5c9aa8cbc0848669677b3236815acb823fd7fcce3fa"
  license "GPL-2.0-only"
  head "https://github.com/hzeller/timg.git", branch: "main"

  bottle do
    root_url "https://github.com/speedy-beaver/homebrew-brew-tap/releases/download/timg-1.4.0"
    sha256 cellar: :any,                 catalina:     "69e4735ae47906d1a1853697ddcb80fa41cf82ce101e506a9ed89e927b567814"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10192ee8c6f5c891577b3e95301d4795fac79d14b683089c7cde90d935278b60"
  end

  depends_on "cmake" => :build
  depends_on "ffmpeg"
  depends_on "graphicsmagick"
  depends_on "jpeg-turbo"
  depends_on "libexif"
  depends_on "libpng"
  depends_on "openslide"
  depends_on "webp"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/timg", "--version"
    system "#{bin}/timg", "-g10x10", test_fixtures("test.gif")
    system "#{bin}/timg", "-g10x10", test_fixtures("test.png")
    system "#{bin}/timg", "-pq", "-g10x10", "-o", testpath/"test-output.txt", test_fixtures("test.jpg")
    assert_match "38;2;255;38;0;49m", (testpath/"test-output.txt").read
  end
end

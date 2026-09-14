class Posteci < Formula
  desc "Run HTTP requests, test plans and load tests written in .stamp files"
  homepage "https://post.samalstudios.com"
  version "1.0.0"
  license :cannot_represent

  on_macos do
    url "https://github.com/samalstudios/posteci/releases/download/cli-1.0.0/posteci-macos-universal.tar.gz"
    sha256 "6f255a23a0f6ac912a303434c83bf40b24a6531429f84d96b27fc89002369286"
  end

  on_linux do
    on_intel do
      url "https://github.com/samalstudios/posteci/releases/download/cli-1.0.0/posteci-linux-x86_64.tar.gz"
      sha256 "a793223b26d0d4f4663e4c33cea92567cf122ccfd5b93f1c237528994795f304"
    end
    on_arm do
      url "https://github.com/samalstudios/posteci/releases/download/cli-1.0.0/posteci-linux-arm64.tar.gz"
      sha256 "785932a450714455e77a34c215e8d9e70fa20ce0e5fe0d13e53cf1f67521acdc"
    end
  end

  def install
    bin.install "posteci"
    doc.install "TERMS.md"
  end

  test do
    (testpath/"hello.stamp").write <<~STAMP
      ### Hello
      GET https://example.com
    STAMP
    assert_match "posteci #{version}", shell_output("#{bin}/posteci --version")
    assert_match "1 request", shell_output("#{bin}/posteci check #{testpath} --no-color")
  end
end

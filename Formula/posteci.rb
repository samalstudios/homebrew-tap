class Posteci < Formula
  desc "Run HTTP requests, test plans and load tests written in .stamp files"
  homepage "https://post.samalstudios.com"
  version "1.2.0"
  license :cannot_represent

  on_macos do
    url "https://github.com/samalstudios/posteci/releases/download/cli-1.2.0/posteci-macos-universal.tar.gz"
    sha256 "916aef0bd87d2d2914a299180fd551773262d2bbb5b57ec66cfda9f8f991a081"
  end

  on_linux do
    on_intel do
      url "https://github.com/samalstudios/posteci/releases/download/cli-1.2.0/posteci-linux-x86_64.tar.gz"
      sha256 "ccea9104b4abb904fac63732ccf257a0bc2c555864e8e28f64a719179cf27117"
    end
    on_arm do
      url "https://github.com/samalstudios/posteci/releases/download/cli-1.2.0/posteci-linux-arm64.tar.gz"
      sha256 "8ee67296a4d4bc079e977a1f6ba9176f1838ee124fdb8c69c96c66b182986c73"
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

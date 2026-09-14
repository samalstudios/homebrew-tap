class Posteci < Formula
  desc "Run HTTP requests, test plans and load tests written in .stamp files"
  homepage "https://post.samalstudios.com"
  version "1.1.0"
  license :cannot_represent

  on_macos do
    url "https://github.com/samalstudios/posteci/releases/download/cli-1.1.0/posteci-macos-universal.tar.gz"
    sha256 "953ee6036b403bf45d1bb48a261128d36f85f44762984e7b9204ce5a0f20453b"
  end

  on_linux do
    on_intel do
      url "https://github.com/samalstudios/posteci/releases/download/cli-1.1.0/posteci-linux-x86_64.tar.gz"
      sha256 "e47869bbe59edf753d55f640b5700c378ffbbe2722d8c5eac90619c33cbe4632"
    end
    on_arm do
      url "https://github.com/samalstudios/posteci/releases/download/cli-1.1.0/posteci-linux-arm64.tar.gz"
      sha256 "d5b5ccb60e620f48ab0d64b3b8a5846b7d6ac72de9c748d8c6bda8be1b9220a0"
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

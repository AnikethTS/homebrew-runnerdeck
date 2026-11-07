class Runnerdeck < Formula
  desc "Dashboard for managing a pool of self-hosted GitHub Actions runners"
  homepage "https://github.com/AnikethTS/RunnerDeck"
  url "https://github.com/AnikethTS/RunnerDeck/releases/download/v1.14.1/runnerdeck-v1.14.1.zip"
  sha256 "e8efa46177bf932459fb2f5d119bf8ba6ccd4a03528b96de82c98c8e21da1b35"
  license "MIT"

  depends_on "gh"
  depends_on "php"

  def install
    libexec.install "app", "run.sh", "VERSION", "LICENSE"
    bin.install "packaging/common/runnerdeck"
    inreplace bin/"runnerdeck", "@APP_ROOT@", libexec
  end

  service do
    run [opt_bin/"runnerdeck"]
    keep_alive true
    log_path var/"log/runnerdeck.log"
    error_log_path var/"log/runnerdeck.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/runnerdeck --version")
  end
end

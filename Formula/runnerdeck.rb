class Runnerdeck < Formula
  desc "Dashboard for managing a pool of self-hosted GitHub Actions runners"
  homepage "https://github.com/AnikethTS/RunnerDeck"
  url "https://github.com/AnikethTS/RunnerDeck/releases/download/v1.12.1/runnerdeck-v1.12.1.zip"
  version "1.12.1"
  sha256 "7cca06c69d46b4e4c428c8462d2b72139fcb27f7f7449605c88b89762901b3ee"
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

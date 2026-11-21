class Runnerdeck < Formula
  desc "Dashboard for managing a pool of self-hosted GitHub Actions runners"
  homepage "https://github.com/AnikethTS/RunnerDeck"
  url "https://github.com/AnikethTS/RunnerDeck/releases/download/v2.2.0/runnerdeck-v2.2.0.zip"
  sha256 "4c56019ec07a22115d193e0067a5a99d66670fdf148413f2840828d331e80f87"
  license "MIT"

  depends_on "gh"
  depends_on "php"

  def install
    libexec.install "app", "run.sh", "VERSION", "LICENSE"
    bin.install "packaging/common/runnerdeck"
    man1.install "packaging/common/runnerdeck.1"
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

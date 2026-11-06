class Runnerdeck < Formula
  desc "Dashboard for managing a pool of self-hosted GitHub Actions runners"
  homepage "https://github.com/AnikethTS/RunnerDeck"
  url "https://github.com/AnikethTS/RunnerDeck/releases/download/v1.13.0/runnerdeck-v1.13.0.zip"
  sha256 "83f3c7738f153d56aaa29eaadb587fc3d97b5d888c8adf729e0a324bdaa28926"
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

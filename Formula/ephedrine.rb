class Ephedrine < Formula
  desc "Keep your Mac awake while Claude Code works, then let it sleep"
  homepage "https://github.com/3xyy/ephedrine"
  url "https://github.com/3xyy/ephedrine/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "81af1ea545d38321581945e720074a9b26fddaea783fbbfa636537def742a1c0"
  license "MIT"
  head "https://github.com/3xyy/ephedrine.git", branch: "main"

  depends_on macos: :sonoma

  def install
    # Ad-hoc signed: built on your Mac, so Gatekeeper never quarantines it.
    ENV["CODESIGN_IDENTITY"] = "-"
    system "scripts/bundle.sh", prefix
    libexec.install "scripts/hook.sh"
    bin.install "scripts/ephedrine"
  end

  def caveats
    <<~EOS
      To finish, run:
        ephedrine setup
      It puts Ephedrine in ~/Applications, adds the Claude Code hooks to
      ~/.claude/settings.json and starts it. Run it again after upgrading.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/ephedrine version").strip
    assert_path_exists prefix/"Ephedrine.app/Contents/MacOS/Ephedrine"
  end
end

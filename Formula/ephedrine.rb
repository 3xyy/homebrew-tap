class Ephedrine < Formula
  desc "Keep your Mac awake while Claude Code works, then let it sleep"
  homepage "https://github.com/3xyy/ephedrine"
  url "https://github.com/3xyy/ephedrine/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "a7014dd56f1daa52cfe99b853327e5977ae032b4eb75414c00f53bcd699feb42"
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

class LocalVoiceInput < Formula
  desc "Offline voice-to-prompt input for macOS (Whisper.cpp + Ollama + Raycast)"
  homepage "https://github.com/aimer1124/local-voice-input"
  url "https://github.com/aimer1124/local-voice-input/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "6870a6cc12ed7e12d63f48eabbe7e18a17485a52ebaafb651fe3e58a7fd30a8f"
  license "MIT"

  depends_on arch: :arm64
  depends_on "jq"
  depends_on :macos
  depends_on "ollama"
  depends_on "sox"
  depends_on "whisper-cpp"

  # Pre-built HUD binary (arm64 only for now; CI runner is macos-14 / Apple Silicon)
  resource "hud" do
    url "https://github.com/aimer1124/local-voice-input/releases/download/v1.4.0/hud"
    sha256 "23df9baac441226c6ad6beab6f2679097a64f9338cd4b507a83bf0760e441835"
  end

  def install
    # Runtime scripts under libexec/bin so `bin/vinput` symlink keeps the
    # ../config, ../raycast, ../src relative paths intact.
    (libexec/"bin").install "bin/vinput", "bin/vinput.sh", "bin/vinput_bg.sh"
    (libexec/"raycast").install Dir["raycast/*"]
    (libexec/"config").install Dir["config/*"]
    (libexec/"src").install Dir["src/*"]

    # Pre-built HUD binary — the CI workflow ships an arm64 build.
    resource("hud").stage do
      hud_file = Dir["*"].first
      (libexec/"bin").install hud_file => "hud"
      chmod 0755, libexec/"bin/hud"
    end

    bin.install_symlink libexec/"bin/vinput"
  end

  def caveats
    <<~EOS
      Finish setup with one command (downloads the 547MB Whisper model,
      pulls the Ollama model, symlinks runtime scripts into ~/.whisper_models/,
      and installs the Raycast command):

          vinput setup

      Then grant macOS permissions (one-time, manual):
        1. System Settings → Privacy → Microphone:    ✅ Raycast
        2. System Settings → Privacy → Accessibility: ✅ Raycast (for ⌘V auto-paste)
        3. Raycast → Extensions → Script Commands:
             add directory ~/.config/raycast-scripts
             bind hotkeys:
               🎙️ 语音输入         (recommended ⌘⇧Space)  full pipeline (Whisper + LLM)
               📝 语音输入 (Raw)   (recommended ⌥Space)   Whisper only, no LLM cleanup

      Verify everything is green:

          vinput --doctor

      Note: the bundled `hud` binary is downloaded from a GitHub Release; if
      Gatekeeper blocks it, Homebrew will surface the offending path.
    EOS
  end

  test do
    assert_match "local-voice-input #{version}", shell_output("#{bin}/vinput --version")
    assert_match "vinput setup", shell_output("#{bin}/vinput --help")
  end
end

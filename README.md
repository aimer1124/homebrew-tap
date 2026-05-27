# aimer1124/homebrew-tap

[![brew test-bot](https://github.com/aimer1124/homebrew-tap/actions/workflows/test.yml/badge.svg)](https://github.com/aimer1124/homebrew-tap/actions/workflows/test.yml)

Homebrew tap for [aimer1124](https://github.com/aimer1124)'s tools.

## Usage

```bash
brew tap aimer1124/tap
brew install local-voice-input
vinput setup            # one-shot bootstrap
```

## Formulae

| Formula | Description | Upstream |
|---|---|---|
| [`local-voice-input`](Formula/local-voice-input.rb) | Offline voice-to-prompt input for macOS — Whisper.cpp ASR → Ollama LLM polish → ⌘V paste, triggered by a Raycast hotkey. | [aimer1124/local-voice-input](https://github.com/aimer1124/local-voice-input) |

## Updating

```bash
brew update
brew upgrade local-voice-input
```

## Untap

```bash
brew uninstall local-voice-input
brew untap aimer1124/tap
```

## Reporting issues

For formula packaging issues open an issue here. For bugs in the tool itself go to [aimer1124/local-voice-input](https://github.com/aimer1124/local-voice-input/issues).

## License

Each formula's license matches its upstream project's. The tap metadata (this repo) is MIT.

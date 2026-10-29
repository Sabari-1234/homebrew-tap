class Deskwright < Formula
  desc "Playwright for desktop apps: automate native apps through the accessibility API"
  homepage "https://github.com/Sabari-1234/deskwright"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Sabari-1234/deskwright/releases/download/v0.1.0/deskwright-aarch64-apple-darwin.tar.xz"
      sha256 "bf71a3ad0cca5d273261dd4ac34a68ea7f0fe4b08928953d89a7105ffa8ecf00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Sabari-1234/deskwright/releases/download/v0.1.0/deskwright-x86_64-apple-darwin.tar.xz"
      sha256 "0dcf62371a1d203843227f29f4af1d8a90133a9c76d6b333950867175c5d2733"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "deskwright"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "deskwright"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

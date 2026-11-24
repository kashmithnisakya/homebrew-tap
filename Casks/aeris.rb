cask "aeris" do
  version "1.4.2"
  sha256 "a85ccb9cef15011f96e3452e5078e2189826ef71b3ae18963ada7faf77c6647f"

  url "https://github.com/kashmithnisakya/aeris/releases/download/v#{version}/Aeris-#{version}.zip"
  name "Aeris"
  desc "Control a SmartThings air conditioner from the menu bar"
  homepage "https://github.com/kashmithnisakya/aeris"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Aeris.app"

  # Aeris isn't notarized; clear quarantine so it opens without the Gatekeeper prompt.
  postflight_steps base: :appdir do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Aeris.app"],
                          chdir: ".", writable_paths: ["Aeris.app"]
  end

  uninstall quit: "com.kashmithnisakya.aeris"

  zap trash: "~/Library/Preferences/com.kashmithnisakya.aeris.plist"

  caveats <<~EOS
    Aeris signs in through the official SmartThings CLI. Install it once:
      brew install smartthingscommunity/smartthings/smartthings
    Then click the Aeris icon in the menu bar and choose "Sign in with SmartThings".
  EOS
end

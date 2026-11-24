cask "aeris" do
  version "1.1.1"
  sha256 "08f217af1bedcb0d4a4155845fc4d9d6bf4bb42c979a9efcb9765d50e0d79a0c"

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
end

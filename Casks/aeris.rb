cask "aeris" do
  version :latest
  sha256 :no_check

  url "https://github.com/kashmithnisakya/aeris/releases/latest/download/Aeris.zip"
  name "Aeris"
  desc "Control a SmartThings air conditioner from the menu bar"
  homepage "https://github.com/kashmithnisakya/aeris"

  depends_on macos: ">= :ventura"

  app "Aeris.app"

  # Aeris isn't notarized; clear quarantine so it opens without the Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Aeris.app"]
  end

  uninstall quit: "com.kashmithnisakya.aeris"

  zap trash: "~/Library/Preferences/com.kashmithnisakya.aeris.plist"
end

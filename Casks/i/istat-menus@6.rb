cask "istat-menus@6" do
  version "6.73.1"
  sha256 :no_check # required as upstream package is updated in-place

  url "https://cdn.istatmenus.app/files/istatmenus#{version.major}/istatmenus#{version}.zip",
      verified: "cdn.istatmenus.app/"
  name "iStats Menus"
  desc "System monitoring app"
  homepage "https://bjango.com/mac/istatmenus/"

  livecheck do
    url "https://download.bjango.com/istatmenus/"
    strategy :header_match
  end

  no_autobump! because: :requires_manual_review

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "iStat Menus.app"

  uninstall launchctl: [
              "com.bjango.istatmenus.agent",
              "com.bjango.istatmenus.daemon",
              "com.bjango.istatmenus.installerhelper",
              "com.bjango.istatmenus.status",
              "com.bjango.istatmenusnotifications",
            ],
            signal:    [
              ["TERM", "com.bjango.iStat-Menus-Notifications"],
              ["TERM", "com.bjango.iStatMenusAgent"],
              ["TERM", "com.bjango.istatmenusstatus"],
              ["TERM", "com.bjango.istatmenus"],
              ["HUP", "com.bjango.istatmenus"],
            ],
            delete:    [
              "/Library/Application Support/iStat Menus #{version.major}",
              "/Library/LaunchDaemons/com.bjango.istatmenus.fans.plist",
              "/Library/Logs/iStat Menus",
              "/Library/PrivilegedHelperTools/com.bjango.istatmenus.installerhelper",
            ]

  zap trash: [
    "/Users/Shared/.iStatMenus",
    "~/Library/Application Scripts/com.bjango.istatmenus.iStat-Menus-Widget",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/y93tk974at.com.bjango.istatmenus.agent.mas.sfl*",
    "~/Library/Application Support/iStat Menus",
    "~/Library/Caches/com.bjango.iStat-Menus-Updater",
    "~/Library/Caches/com.bjango.istatmenus",
    "~/Library/Caches/com.bjango.istatmenus.agent",
    "~/Library/Caches/com.bjango.istatmenus.status",
    "~/Library/Caches/com.bjango.iStatMenusAgent",
    "~/Library/Caches/iStat Menus",
    "~/Library/Containers/com.bjango.istatmenus.iStat-Menus-Widget",
    "~/Library/Cookies/com.bjango.istatmenus.binarycookies",
    "~/Library/Logs/iStat Menus",
    "~/Library/Preferences/com.bjango.istatmenus#{version.major}.extras.plist",
    "~/Library/Preferences/com.bjango.istatmenus.plist",
    "~/Library/Preferences/com.bjango.istatmenus.status.plist",
  ]
end

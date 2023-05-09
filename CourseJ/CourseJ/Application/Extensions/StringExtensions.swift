import SwiftUI

extension String {
    var isNotEmpty: Bool { isEmpty == false }

    var localized: String { .init(localized: LocalizedStringResource(stringLiteral: self)) }

    static func userAgentHeader() -> String {
        let userAgent: String = {
            if let info = Bundle.main.infoDictionary {
                let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
                let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
                let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
                let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
                let model = UIDevice.current.model
                let scale = UIScreen.main.scale

                let osNameVersion: String = {
                    let version = ProcessInfo.processInfo.operatingSystemVersion
                    let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"

                    let osName: String = {
                        #if os(iOS)
                            return "iOS"
                        #elseif os(watchOS)
                            return "watchOS"
                        #elseif os(tvOS)
                            return "tvOS"
                        #elseif os(macOS)
                            return "OS X"
                        #elseif os(Linux)
                            return "Linux"
                        #else
                            return "Unknown"
                        #endif
                    }()
                    return "\(osName) \(versionString)"
                }()
                return "\(executable)/\(appVersion) (\(bundle); "
                    + "build:\(appBuild); \(model); "
                    + "\(osNameVersion); Scale/\(scale))"
            }
            return "CourseJ"
        }()
        return userAgent
    }
}

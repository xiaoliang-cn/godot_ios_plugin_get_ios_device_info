// The Swift Programming Language
// https://docs.swift.org/swift-book



import SwiftGodot
import Darwin
import UIKit

#initSwiftExtension(cdecl: "swift_entry_point",types: [IOSDeviceInfoLibrary.self])

@Godot()
class IOSDeviceInfoLibrary : RefCounted {
    
    private func hardwareIdentifier() -> String {
        var sys = utsname()
        uname(&sys)
        let mirror = Mirror(reflecting: sys.machine)
        return mirror.children.reduce(into: "") { s, c in
            guard let v = c.value as? Int8, v != 0 else { return }
            s.append(String(UnicodeScalar(UInt8(v))))
        }
    }

    @Callable
    func get_app_device_info() -> Dictionary<String, String> {
        let bundle = Bundle.main
        let info = bundle.infoDictionary ?? [:]
        let appName = (info["CFBundleDisplayName"] as? String)
            ?? (info["CFBundleName"] as? String) ?? ""
        let version = (info["CFBundleShortVersionString"] as? String) ?? ""
        let build = (info["CFBundleVersion"] as? String) ?? ""
        let exec = (info["CFBundleExecutable"] as? String) ?? ""

        let dev = UIDevice.current
        let screen = UIScreen.main
        let size = screen.bounds.size
        let native = screen.nativeBounds.size

        return [
            // package info
            "bundle_id": bundle.bundleIdentifier ?? "",
            "app_name": appName,
            "app_version": version,
            "build_number": build,
            "executable": exec,
            // device info
            "device_name": dev.name,
            "device_model": dev.model,
            "device_machine": hardwareIdentifier(), // iPhone.x
            "system_name": dev.systemName,
            "system_version": dev.systemVersion,
            "idfv": dev.identifierForVendor?.uuidString ?? "",
            // screen
            "language": Locale.preferredLanguages.first ?? "",
            "locale": Locale.current.identifier,
            "timezone": TimeZone.current.identifier,
            "screen_size": "\(Int(size.width))x\(Int(size.height))",
            "screen_scale": String(format: "%.2f", screen.scale),
            "native_size": "\(Int(native.width))x\(Int(native.height))",
            "native_scale": String(format: "%.2f", screen.nativeScale)
        ]
    }
}

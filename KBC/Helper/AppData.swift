
//
//  AppData.swift
//  Form App
//
//  Created by Hany Alkahlout on 27/08/2022.
//

import UIKit
import CoreLocation

@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    
}


struct AppData {
    
    @Storage(key: "vipUrl", defaultValue: "")
    static var vipUrl: String
    
    @Storage(key: "lat", defaultValue: "")
    static var lat: String
    
    @Storage(key: "long", defaultValue: "")
    static var long: String
    
    
    
    @Storage(key: "currentVersion", defaultValue: "")
    static var currentVersion: String
    
    @Storage(key: "isRememberMePwa", defaultValue: false)
    static var isRememberMePwa: Bool
    
    @Storage(key: "userHash", defaultValue: "")
    static var userHash: String
    
    @Storage(key: "isBiometricSet", defaultValue: false)
    static var isBiometricSet: Bool
    
    @Storage(key: "isDeviceLoginBio", defaultValue: "")
    static var isDeviceLoginBio: String
    
    @Storage(key: "isLoginRememberMe", defaultValue: "")
    static var isLoginRememberMe: String
    
    @Storage(key: "isLoginBiometric", defaultValue: "")
    static var isLoginBiometric: String
    
    @Storage(key: "methodName", defaultValue: "")
    static var methodName: String
    
    @Storage(key: "userHash2", defaultValue: "")
    static var userHash2: String
    
    @Storage(key: "isFirstInstall", defaultValue: false)
    static var isFirstInstall: Bool
    
    
    
    
    @Storage(key: "token", defaultValue: "")
    static var token: String
    
    @Storage(key: "userID", defaultValue: "")
    static var userID: String
    
    @Storage(key: "password", defaultValue: "")
    static var password: String
    
    @Storage(key: "urlDomain", defaultValue: "")
    static var urlDomain: String
    
    @Storage(key: "urlHomeDomain", defaultValue: "")
    static var urlHomeDomain: String
    
    @Storage(key: "downloadPathDirectory", defaultValue: "")
    static var downloadPathDirectory: String
    
    @Storage(key: "notificationUrl", defaultValue: "")
    static var notificationUrl: String
    
    
    @Storage(key: "recentVersion", defaultValue: "")
    static var recentVersion: String
    
    @Storage(key: "fcmToken", defaultValue: "")
    static var fcmToken: String

    
    @Storage(key: "isBioLogin", defaultValue: false)
    static var isBioLogin: Bool
    
    @Storage(key: "isRememberMeLogin", defaultValue: false)
    static var isRememberMeLogin: Bool
    
    @Storage(key: "isNotificationsEnabled", defaultValue: false)
    static var isNotificationsEnabled: Bool
    
    
    static var OSType: String {
        return UIDevice.current.systemName
    }
    
    static var OSVersion: String {
        return UIDevice.current.systemVersion
    }
    
    static var screenSize: String {
        let screenSize = UIScreen.main.bounds.size
        return "\(screenSize.width)x\(screenSize.height)"
    }
    
    static var currentDateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    static var versionRelease: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return ""
    }
    
    static var uuid: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    
    static  func saveCurrentLocation(location: CLLocationCoordinate2D) {
        
        let latitude = location.latitude
        let longitude = location.longitude
        let locationString = "\(latitude),\(longitude)"
        if let locationData = locationString.data(using: .utf8) {
            _ = try? KeychainOperations.add(value: locationData, key: "currentLocation")
        }
        
    }
    
    static  func loadCurrentLocation() -> CLLocationCoordinate2D? {
        if let locationData = KeychainOperations.load(key: "currentLocation"),
           let locationString = String(data: locationData, encoding: .utf8) {
            let components = locationString.split(separator: ",")
            if components.count == 2,
               let latitude = Double(components[0]),
               let longitude = Double(components[1]) {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        return nil
    }
    
    
    
    static func getDeviceInfoJSON() -> String {
        
        let currentLocation = loadCurrentLocation()
        let info: [String: Any] = [
            "os_type": OSType,
            "os_version": OSVersion,
            "screen": screenSize,
            "req_dtm": currentDateTime,
            "app_version": versionRelease,
            "uuid": uuid,
            "lat": currentLocation?.latitude ?? "",
            "lng": currentLocation?.longitude ?? "",
            "token": fcmToken
        ]
        
        return String(data: try! JSONSerialization.data(withJSONObject: info), encoding: .utf8)!
        
    }
    
    
    
}

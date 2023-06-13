//
//  TFAppConfig.swift
//  tf_ios_main_app
//
//  Created by AL-TVO163 on 13/06/2023.
//

import Foundation


import Foundation

class TFAppCofig {

    static private let keyAMPConfig = "App_Configuration"
    enum ConfigKey: String {
        case apiUrl = "API_URL"
        case apiKey = "API_KEY"
    }



    /// Get Config Value from Info.plist file
    /// - Parameter key: Key name
    /// - Returns: String value
    static func getConfigValue(key: ConfigKey, targetBundle : Bundle = Bundle.main) -> String {
        guard let ampConfig = targetBundle.object(forInfoDictionaryKey: keyAMPConfig) as? [String: String] else { return "" }
        guard ampConfig.keys.contains(key.rawValue) else { return "" }
        let value = ampConfig[key.rawValue]
        return value ?? ""
    }
    

}

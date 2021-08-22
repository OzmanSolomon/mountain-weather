//
//  Environment.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation


public enum PlistKey {
    case apiKey
    
    func value() -> String {
        switch self {
        case .apiKey:
            return "apiKey"
        }
    }
}
public struct EnvironmentManager {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .apiKey:
            return infoDict[PlistKey.apiKey.value()] as! String
        }
    }
}

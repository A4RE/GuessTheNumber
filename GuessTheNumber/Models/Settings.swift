//
//  Settings.swift
//  GuessTheNumber
//
//  Created by Андрей Коваленко on 03.10.2023.
//

import Foundation
// MARK: - ENUM
enum KeysUserDefaults {
    static let gameSettings = "gameSettings"
    static let gameRecord = "gameRecord"
}
// MARK: - STRUCT
struct GameSettings: Codable {
    var timerState: Bool
    var timeForGame: Int
}
// MARK: - CLASS
class Settings {
    // MARK: - SINGLETON
    static var shared = Settings()
    // MARK: - PROPERTIES
    private let defaultSettings: GameSettings = GameSettings(timerState: true, timeForGame: 30)
    
    var currentSetting: GameSettings {
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.gameSettings) as? Data {
                return try! PropertyListDecoder().decode(GameSettings.self, from: data)
            } else {
                do {
                    let data = try PropertyListEncoder().encode(defaultSettings)
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.gameSettings)
                } catch {
                    print("Error: \(error)")
                }
                return defaultSettings
            }
        }
        set {
            do {
                let data = try PropertyListEncoder().encode(newValue)
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.gameSettings)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    // MARK: - FUNCTIONS
    func resetSettings() {
        currentSetting = defaultSettings
    }
}

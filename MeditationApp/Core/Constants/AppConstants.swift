import Foundation
import SwiftUI

/// Константы приложения
enum AppConstants {
  // MARK: - User Defaults Keys
  
  enum UserDefaultsKeys {
    static let hasLaunchedBefore = "hasLaunchedBefore"
    static let lastPlayedTrack = "lastPlayedTrack"
  }
  
  // MARK: - Data Files
  
  enum DataFiles {
    static let tracks = "tracks"
    static let meditation = "meditation"
    static let focus = "focus"
    static let happiness = "happiness"
    static let programs = "programs"
  }
  
  // MARK: - Audio
  
  enum Audio {
    static let supportedExtensions = ["mp3", "wav", "m4a", "aac", "caf"]
    static let skipInterval: TimeInterval = 15.0 // секунды
    static let progressUpdateInterval: TimeInterval = 0.5 // секунды
  }
  
  // MARK: - UI Constants
  
  enum UI {
    static let cornerRadius: CGFloat = 38.0
    static let buttonPadding: CGFloat = 24.5
  }
}



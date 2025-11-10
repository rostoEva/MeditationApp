import Foundation
import SwiftUI

enum MeditationCollection: String, CaseIterable {
  case all
  case my
  case anxious
  case sleep
  case kids
}

extension MeditationCollection {
  var displayName: String {
    switch self {
    case .all: return "All"
    case .my: return "My"
    case .anxious: return "Anxious"
    case .sleep: return "Sleep"
    case .kids: return "Kids"
    }
  }
  
  var coverImageResource: ImageResource {
    switch self {
    case .all: return .allMeditate
    case .my: return .myMeditate
    case .anxious: return .anxiousMeditate
    case .sleep: return .sleepMeditate
    case .kids: return .kidsMeditate
    }
  }
}

import Foundation
import SwiftUI

struct Program: Identifiable, Codable, Hashable {
  var id: Int
  var title: String
  var description: String
  var coverImage: String
  var tracks: [Track]
  var category: String
}

extension Program {
  var coverImageResource: ImageResource {
    switch coverImage {
    case "daysOfCalm": return .daysOfCalm
    case "anxietRelease": return .anxietRelease
    case "kidsMeditation": return .kidsMeditation
    case "sleepMeditattion": return .sleepMeditattion
    default: return .daysOfCalm
    }
  }
}

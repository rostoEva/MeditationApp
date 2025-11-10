import Foundation

struct Track: Identifiable, Codable, Hashable {
  var id: Int
  var title: String
  var collection: String
  var duration: Int
  var audioURL: String
}

import SwiftUI

struct TrackListView: View {
  let tracks: [Track]
  let onTrackSelected: (Track) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(tracks) { track in
        Button {
          onTrackSelected(track)
        } label: {
          TrackListItemView(title: track.title, duration: track.duration)
            .padding(.vertical, 20)
        }
        Divider().background(Color.gray.opacity(0.3))
      }
    }
    .padding(.leading, 20)
  }
}

struct TrackListItemView: View {
  @State private var pressed = false
  let title: String
  let duration: Int
  
  var body: some View {
    HStack(spacing: 16) {
      CircularButtonMediaList(image: .buttonPlay, isPressed: false)
      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .fontBuilder(.h9)
          .foregroundColor(.mainText)
        Text("\(duration/60) MIN")
          .fontBuilder(.h8)
          .foregroundColor(.grayText)
      }
    }
  }
}

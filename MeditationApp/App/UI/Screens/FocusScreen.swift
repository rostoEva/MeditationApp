import SwiftUI

struct FocusScreen: View {
  @EnvironmentObject var dataService: DataService
  let onTrackSelected: (Track) -> Void
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        HeaderViewTrackList(
          image: .happyMorning,
          title: "Focus",
          subtitle: "Improve your concentration and focus with these guided sessions.",
          typeScreen: "FOCUS"
        )
        TrackListView(
          tracks: dataService.focusTracks,
          onTrackSelected: onTrackSelected
        )
      }
    }
    .ignoresSafeArea()
  }
}

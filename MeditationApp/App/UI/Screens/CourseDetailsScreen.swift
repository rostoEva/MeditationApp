import SwiftUI

struct CourseDetailsScreen: View {
  @EnvironmentObject var dataService: DataService
  let onMeditationSelected: (Track) -> Void
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        HeaderViewTrackList(
          image: .happyMorning,
          title: "Happy Morning",
          subtitle: "Ease the mind into a restful night's sleep with these deep, amblent tones.",
          typeScreen: "COURSE"
        )
        TrackListView(
          tracks: dataService.meditationTracks,
          onTrackSelected: onMeditationSelected)
      }
    }.ignoresSafeArea()
  }
}

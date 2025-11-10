import SwiftUI

struct HappinessScreen: View {
  @EnvironmentObject var dataService: DataService
  let onTrackSelected: (Track) -> Void
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        HeaderViewTrackList(
          image: .happyMorning,
          title: "Happiness",
          subtitle: "Boost your mood and find inner joy with these uplifting sessions.",
          typeScreen: "HAPPINESS"
        )
        TrackListView(
          tracks: dataService.happinessTracks,
          onTrackSelected: onTrackSelected
        )
      }
    }
    .ignoresSafeArea()
  }
}

// Screens/MusicScreen.swift
import SwiftUI

struct MusicScreen: View {
  @EnvironmentObject var dataService: DataService
  let onTrackSelected: (Track) -> Void
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        HeaderViewTrackList(
          image: .happyMorning,
          title: "Relax Music",
          subtitle: "Ease the mind into a restful night's sleep with these deep, ambient tones.",
          typeScreen: "MUSIC"
        )
        TrackListView(
          tracks: dataService.musicTracks,
          onTrackSelected: onTrackSelected
        )
      }
    }
    .ignoresSafeArea()
  }
}

import SwiftUI

struct MeditateFlow: View {
  @EnvironmentObject var dataService: DataService
  @State private var selectedProgram: Program?
  @State private var selectedTrack: Track?
  
  // Получаем "трек дня" для Daily Calm
  private func getDailyTrack() -> Track? {
    return dataService.meditationTracks.first ?? dataService.musicTracks.first
  }
  
  var body: some View {
    NavigationStack {
      MeditateScreen(
        onDailyCalmTap: {
          if let dailyTrack = getDailyTrack() {
            selectedTrack = dailyTrack
          }
        },
        onProgramSelected: { program in
          selectedProgram = program
        }
      )
      .navigationDestination(item: $selectedProgram) { program in
        ProgramDetailScreen(
          program: program,
          onTrackSelected: { track in
            selectedTrack = track
          }
        )
      }
      .navigationDestination(item: $selectedTrack) { track in
        PlayerScreen(track: track)
      }
    }
  }
}

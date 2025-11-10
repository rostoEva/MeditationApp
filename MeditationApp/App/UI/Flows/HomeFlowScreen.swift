import SwiftUI

enum HomeFlowRoute: Hashable {
  case music
  case course
  case daily
  case focus
  case happiness
  case player(track: Track)
}

struct HomeFlowScreen: View {
  @EnvironmentObject var dataService: DataService // Используем единый сервис из environment
  @State private var path: [HomeFlowRoute] = []
  @State private var selectedTrack: Track?
  
  // Получаем "трек дня" (например, первый трек из музыки)
  private func getDailyTrack() -> Track? {
    return dataService.musicTracks.first ?? dataService.meditationTracks.first
  }
  
  var body: some View {
    NavigationStack(path: $path) {
      HomeScreen(
        onCourseTap: { path.append(.course) },
        onMusicTap: { path.append(.music) },
        onDailyTap: {
          if let dailyTrack = getDailyTrack() {
            path.append(.player(track: dailyTrack))
          }
        },
        onFocusTap: { path.append(.focus) },
        onHappinessTap: { path.append(.happiness) }
      )
      .navigationDestination(for: HomeFlowRoute.self) { route in
        switch route {
        case .music:
          MusicScreen { track in
            path.append(.player(track: track))
          }
          
        case .course:
          CourseDetailsScreen { track in
            path.append(.player(track: track))
          }
          
        case .daily:
          EmptyView()
          
        case .focus:
          FocusScreen { track in
            path.append(.player(track: track))
          }
          
        case .happiness:
          HappinessScreen { track in
            path.append(.player(track: track))
          }
          
        case .player(track: let track):
          PlayerScreen(track: track)
        }
      }
      
    }
  }
}

import SwiftUI

enum AppFlowState {
  case onboarding
  case auth
  case main
}

struct AppFlowScreen: View {
  @StateObject private var dataService = DataService() // Единый сервис для всех данных
  @StateObject private var favoritesService = FavoritesService() // Сервис избранного
  @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false
  @State private var appFlowState: AppFlowState = .onboarding
  
  var body: some View {
    ZStack {
      switch appFlowState {
      case .onboarding:
        AuthScreen(signIn: {
          withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
            appFlowState = .auth
          }
        }, onSignUpTap: {
          withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
            appFlowState = .auth
          }
        })
        .transition(.slideAndFade)
        .zIndex(1)
        
      case .auth:
        AuthFlowScreen {
          withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
            appFlowState = .main
          }
        }
        .transition(.slideAndFade)
        .zIndex(2)
        
      case .main:
        MainFlowScreen()
          .transition(.fadeAndScale)
          .zIndex(3)
      }
    }
    .animation(.spring(response: 0.5, dampingFraction: 0.75), value: appFlowState)
    .environmentObject(dataService) // Передаем единый сервис во все экраны
    .environmentObject(favoritesService) // Передаем сервис избранного во все экраны
    .onAppear {
      if hasLaunchedBefore {
        // Пропускаем анимацию при первом запуске
        appFlowState = .main
      } else {
        appFlowState = .onboarding
      }
    }
  }
}

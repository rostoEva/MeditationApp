import SwiftUI

struct MainFlowScreen: View {
  @EnvironmentObject var dataService: DataService // Используем единый сервис из environment
  @State private var selectedTab: Tab = .home
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeFlowScreen()
        .tabItem {
          Label("Home", image: .homeTabBar)
        }
        .tag(Tab.home)
      
      MeditateFlow()
        .tabItem {
          Label("Meditate", image: .maditateTabBar)
        }
        .tag(Tab.meditate)
    }
    .tint(.button)
  }
}


enum Tab {
  case home
  case meditate
}


#Preview {
  MainFlowScreen()
}

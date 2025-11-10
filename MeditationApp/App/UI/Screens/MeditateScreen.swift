import SwiftUI
import WaterfallGrid

// MARK: - Main Screen

struct MeditateScreen: View {
  @State private var selectedCollection: MeditationCollection = .all
  @EnvironmentObject var dataService: DataService
  @EnvironmentObject var favoritesService: FavoritesService
  let onDailyCalmTap: () -> Void
  let onProgramSelected: (Program) -> Void
  
  var filteredPrograms: [Program] {
    switch selectedCollection {
    case .all:
      return dataService.programs
    case .my:
      // Фильтруем по избранному для категории "my"
      return favoritesService.filterFavorites(from: dataService.programs)
    default:
      return dataService.programs.filter {
        $0.category == selectedCollection.rawValue
      }
    }
  }
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        MeditateHeader()
        CollectionSection(selectedCollection: $selectedCollection)
        DailyCalmSection(onDailyCalmTap: onDailyCalmTap)
        
        // Проверяем, есть ли избранные программы для категории "my"
        if selectedCollection == .my && filteredPrograms.isEmpty {
          EmptyFavoritesView()
            .padding(.top, 50)
        } else {
          MeditationGrid(
            programs: filteredPrograms,
            selectedCollection: selectedCollection,
            onProgramSelected: onProgramSelected,
            onFavoriteToggle: { program in
              favoritesService.toggleFavorite(programId: program.id)
            }
          )
        }
      }
    }
  }
}

// MARK: - Empty State

struct EmptyFavoritesView: View {
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "heart")
        .font(.system(size: 60))
        .foregroundColor(.grayText)
      
      Text("No Favorites Yet")
        .fontBuilder(.h4)
        .foregroundColor(.mainText)
      
      Text("Add programs to your favorites by tapping the heart icon")
        .fontBuilder(.h3)
        .foregroundColor(.grayText)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 40)
    }
    .padding(.vertical, 60)
  }
}

// MARK: - Collection

struct CollectionSection: View {
  @Binding var selectedCollection: MeditationCollection
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 20) {
        ForEach(MeditationCollection.allCases, id: \.self) { collection in
          Button {
            selectedCollection = collection
          } label: {
            CategoryButton(
              icon: collection.coverImageResource,  // ← из extension
              title: collection.displayName,        // ← из extension
              isSelected: selectedCollection == collection
            )
            .opacity(selectedCollection == collection ? 1 : 0.6)
            .animation(.easeInOut(duration: 0.2), value: selectedCollection)
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 25)
    }
  }
}


// MARK: - Daily Calm

struct DailyCalmSection: View {
  let onDailyCalmTap: () -> Void
  
  var body: some View {
    Button (action: onDailyCalmTap) {
      Image(ImageResource.dailyCalm)
        .resizable()
        .scaledToFit()
        .cornerRadius(15)
        .shadow(radius: 3)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
  }
}


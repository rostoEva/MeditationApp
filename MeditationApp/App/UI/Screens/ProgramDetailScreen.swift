import SwiftUI

struct ProgramDetailScreen: View {
  let program: Program
  let onTrackSelected: (Track) -> Void
  @EnvironmentObject var favoritesService: FavoritesService
  
  var isFavorite: Bool {
    favoritesService.isFavorite(programId: program.id)
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        // Хедер с картинкой программы
        ZStack(alignment: .topTrailing) {
          HeaderViewTrackList(
            image: program.coverImageResource,
            title: program.title,
            subtitle: program.description,
            typeScreen: "PROGRAM"
          )
          
          // Кнопка избранного в хедере (маленькая)
          Button(action: {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.6)) {
              favoritesService.toggleFavorite(programId: program.id)
            }
          }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
              .foregroundColor(isFavorite ? .red : .white)
              .font(.system(size: 24))
              .padding(12)
              .background(
                Circle()
                  .fill(Color.black.opacity(0.4))
                  .background(.ultraThinMaterial)
              )
          }
          .buttonStyle(PlainButtonStyle())
          .padding(.top, 60)
          .padding(.trailing, 20)
        }
        
        // Кнопка избранного под описанием
        FavoriteButtonView(
          isFavorite: isFavorite,
          onToggle: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
              favoritesService.toggleFavorite(programId: program.id)
            }
          }
        )
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 30)
        
        // Список треков программы
        TrackListView(
          tracks: program.tracks,
          onTrackSelected: onTrackSelected
        )
      }
    }
    .ignoresSafeArea()
  }
}

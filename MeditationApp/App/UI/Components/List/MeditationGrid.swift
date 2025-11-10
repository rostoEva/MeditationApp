import SwiftUI
import WaterfallGrid

struct MeditationGrid: View {
  let programs: [Program]
  let selectedCollection: MeditationCollection
  let onProgramSelected: (Program) -> Void
  let onFavoriteToggle: (Program) -> Void
  
  var body: some View {
    WaterfallGrid(programs) { program in
      MeditationCartView(
        program: program,
        onTap: { onProgramSelected(program) },
        onFavoriteToggle: { onFavoriteToggle(program) }
      )
    }
    .gridStyle(columnsInPortrait: 2, spacing: 20)
    .padding(.horizontal, 18)
  }
}

struct MeditationCartView: View {
  var program: Program
  let onTap: () -> Void
  let onFavoriteToggle: () -> Void
  @EnvironmentObject var favoritesService: FavoritesService
  
  var isFavorite: Bool {
    favoritesService.isFavorite(programId: program.id)
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      // Основное изображение программы
      Button(action: onTap) {
        Image(program.coverImageResource)
          .resizable()
          .scaledToFill()
          .frame(width: 177.15, height: 220)
          .clipped()
          .cornerRadius(10)
      }
      .buttonStyle(PlainButtonStyle())
      
      // Кнопка избранного поверх изображения
      VStack {
        HStack {
          Spacer()
          Button(action: {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.6)) {
              onFavoriteToggle()
            }
          }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
              .foregroundColor(isFavorite ? .red : .white)
              .font(.system(size: 20))
              .padding(8)
              .background(
                Circle()
                  .fill(Color.black.opacity(0.3))
              )
          }
          .buttonStyle(PlainButtonStyle())
          .padding(8)
        }
        Spacer()
      }
      
      // Заголовок программы внизу
      Rectangle()
        .fill(Color.white.opacity(0.11))
        .background(.ultraThinMaterial)
        .frame(width: 177.15, height: 51.81)
        .cornerRadius(10)
        .overlay(
          Text(program.title)
            .fontBuilder(.h5)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .lineLimit(2)
            .multilineTextAlignment(.center)
        )
    }
    .frame(width: 177.15, height: 220)
  }
}


import SwiftUI

struct FavoriteButtonView: View {
  let isFavorite: Bool
  let onToggle: () -> Void
  
  var body: some View {
    Button(action: onToggle) {
      HStack(spacing: 12) {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
          .font(.system(size: 20))
          .foregroundColor(isFavorite ? .red : .mainText)
        
        Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
          .fontBuilder(.h3)
          .foregroundColor(.mainText)
        
        Spacer()
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
      .background(
        RoundedRectangle(cornerRadius: 15)
          .fill(Color.textFieldBackground)
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(isFavorite ? Color.red.opacity(0.3) : Color.strokeGray, lineWidth: 1)
          )
      )
    }
    .buttonStyle(PlainButtonStyle())
  }
}


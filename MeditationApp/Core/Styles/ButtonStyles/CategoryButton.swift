import SwiftUI

struct CategoryButton: View {
  var icon: ImageResource
  var title: String
  var isSelected: Bool = false
  
  var body: some View {
    VStack(spacing: 10) {
      Image(icon)
        .frame(width: 65, height: 65)
        .background(isSelected ? Color.button : Color.iconBackround)
        .cornerRadius(25)
        .scaleEffect(isSelected ? 1.05 : 1)
        .animation(.spring(), value: isSelected)
      
      Text(title)
        .fontBuilder(.h9)
        .foregroundColor(.iconBackround)
    }
  }
}

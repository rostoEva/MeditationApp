import SwiftUI

struct HeaderViewTrackList: View {
  let image: ImageResource
  let title: String
  let subtitle: String
  let typeScreen: String
  var body: some View {
    VStack(spacing: 0) {
      Image(image)
        .scaledToFit()
        .padding(.bottom, 31)
      
      VStack(alignment: .leading, spacing: 0) {
        TitleStyle(title: title, padding: 15)
        Text(typeScreen)
          .foregroundColor(.grayText)
          .fontBuilder(.h3)
          .padding(.bottom, 8)
        SubtitleStyle(title: subtitle)
      }
      .padding(.horizontal, 20)
    }
  }
}

#Preview {
  HeaderViewTrackList(image: .happyMorning, title: "vkdjvjksdv", subtitle: "jskfnvkjf", typeScreen: "ndvjkfnv")
}

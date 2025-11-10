import SwiftUI

struct MeditateHeader: View {
  var body: some View {
    VStack(spacing: 4) {
      TitleStyle(title: "Meditate", padding: 15)
      SubtitleStyle(
        title: "We can learn how to recognize when our minds are doing their normal everyday acrobatics." )
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 34)
  }
}

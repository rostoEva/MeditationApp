import SwiftUI

struct SubtitleStyle: View {
  var title: String = ""
  var paddingHorizontal: CGFloat = 0
  var body: some View {
    Text(title)
      .fontBuilder(.h2)
      .foregroundColor(.grayText)
      .padding(.horizontal, paddingHorizontal)
      .lineLimit(2)
      .frame(maxWidth: .infinity, alignment: .leading) 
      .fixedSize(horizontal: false, vertical: true)
  }
}

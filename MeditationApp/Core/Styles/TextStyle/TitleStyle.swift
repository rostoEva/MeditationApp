import SwiftUI

struct TitleStyle: View {
  var title: String = ""
  var padding: CGFloat = 0
  var body: some View {
    Text(title)
      .fontBuilder(.h1)
      .foregroundColor(.mainText)
      .padding(.bottom, padding)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

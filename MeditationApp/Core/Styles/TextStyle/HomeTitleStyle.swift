import SwiftUI

struct HomeTitleStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .fontBuilder(.h1)
      .foregroundColor(.mainText)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct HomeSubtitleStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .fontBuilder(.h4)
      .foregroundColor(.grayText)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

extension View {
  func homeTitleStyle() -> some View {
    self.modifier(HomeTitleStyle()
    )}
  func homeSubtitleStyle() -> some View { self.modifier(HomeSubtitleStyle()
  )}
}

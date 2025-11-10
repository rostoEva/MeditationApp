import SwiftUI

struct AccentButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .fontBuilder(.h3)
      .foregroundStyle(Color(.white))
      .padding([.top, .bottom], 24.5)
      .frame(maxWidth: .infinity)
      .background(Color(.button))
      .cornerRadius(38.0)
      .opacity(configuration.isPressed ? 0.6 : 1)
  }
  
}


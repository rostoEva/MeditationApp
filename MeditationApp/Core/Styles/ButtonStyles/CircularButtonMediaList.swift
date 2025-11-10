import SwiftUI

struct CircularButtonMediaList: View {
  let image: ImageResource
  var isPressed: Bool = false
  
  var body: some View {
    ZStack {
      Circle()
        .fill(isPressed ? Color.button : Color.clear)
        .frame(width: 40, height: 40)
        .overlay(
          Circle()
            .stroke(isPressed ? Color.button : Color.grayText, lineWidth: 1)
        )
      Image(image)
        .renderingMode(.template)
        .foregroundColor(isPressed ? .white : .grayText)
        .frame(width: 16, height: 16)
    }
  }
}

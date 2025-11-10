import SwiftUI

struct NavigationBar: View {
  
  var body: some View {
    HStack(spacing: 0) {
      Text("Silent")
        .foregroundColor(.mainText)
        .fontBuilder(.h5)
        .padding(.trailing, 4)
      Image(.logo)
      Text("Moon")
        .foregroundColor(.mainText)
        .fontBuilder(.h5)
        .padding(.leading, 4)
    }
  }
}

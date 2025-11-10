import SwiftUI

// MARK: - AuthScreen

struct AuthScreen: View {
  let signIn: () -> Void
  let onSignUpTap: () -> Void
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar()
      ImageScreen()
      TextState()
      SignInButton(signIn: signIn, onSignUpTap: onSignUpTap)
    }
  }
}

// MARK: - AuthConstants


struct AuthConstants {
  static let horizontalPadding: CGFloat = 44
  static let imageTopPadding: CGFloat = 80
  static let imageBottomPadding: CGFloat = 131
  static let textSpacing: CGFloat = 15
  static let textBottomPadding: CGFloat = 62
  static let buttonHorizontalPadding: CGFloat = 20
}

struct ImageScreen: View {
  
  var body: some View {
    Image(.imageGirl)
      .padding(EdgeInsets(top: 80, leading: 44, bottom: 131, trailing: 44))
  }
}
  
struct TextState: View {
  
  var body: some View {
    VStack(spacing: 0) {
      Text("We are what we do")
        .foregroundColor(.mainText)
        .fontBuilder(.h1)
        .padding(.bottom, 15)
      Text("Thousand of people are using Silent Moon for small meditations")
        .fontBuilder(.h2)
        .multilineTextAlignment(.center)
        .foregroundColor(.grayText)
        .frame(maxWidth: .infinity, alignment: .center)
        .fixedSize(horizontal: false, vertical: true)
        
    }
    .frame(maxWidth: 298)
    .padding(.bottom, 62)
  }
}

struct SignInButton: View {
  let signIn: () -> Void
  let onSignUpTap: () -> Void
  
  var body: some View {
    VStack(spacing: 0) {
      Button("SIGN IN", action: signIn)
        .buttonStyle(AccentButtonStyle())
        .padding([.leading,.trailing, .bottom], 20)
      
      Button(action: onSignUpTap) {
        Text("ALREADY HAVE AN ACCOUNT? LOG IN")
          .fontBuilder(.h3)
          .foregroundColor(.grayText)
          .multilineTextAlignment(.center)
          .lineLimit(2)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 16)
          .padding(.horizontal, 20)
          .contentShape(Rectangle())
      }
      .buttonStyle(PlainButtonStyle())
    }
  }
}

#Preview {
  AuthScreen(signIn: {}, onSignUpTap: {})
}


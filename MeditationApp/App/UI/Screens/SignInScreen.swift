import SwiftUI

struct SignInScreen: View {
  let onLogin: () -> Void
  let onSignUpTap: () -> Void
  
  var body: some View {
    VStack(spacing: 0) {
      TitleStyle(title: "Welcome Back!").padding(.leading, 20)
      SocialButtonSignUp()
      SignInForm(onLogin: onLogin, onSignUpTap: onSignUpTap)
    }
  }
}


struct SignInForm: View {
  @State var emailAddress: String = ""
  @State var password: String = ""
  let onLogin: () -> Void
  let onSignUpTap: () -> Void
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        CustomInputField(text: $emailAddress, placeholder: "Email address")
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        SecretInputField(password: $password)
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
      }
      Button("LOG IN", action: onLogin)
        .buttonStyle(AccentButtonStyle())
        .padding([.leading,.trailing], 20)
        .padding(.bottom, 138.53)
      Button("DON'T HAVE AN ACCOUNT? SIGN UP", action: onSignUpTap)
        .fontBuilder(.h3)
        .foregroundColor(.grayText)
        .lineLimit(2)
    }
  }
}

#Preview {
  SignInScreen(onLogin: {}, onSignUpTap: {})
}

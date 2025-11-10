import SwiftUI

struct SignUpScreen: View {
  let onRegist: () -> Void
  let onLoginTap: () -> Void
  
  var body: some View {
    VStack {
      TitleStyle(title: "Create your account").padding(.horizontal, 20)
      SocialButtonSignUp()
      SignUpForm(onRegist: onRegist)
    }
    .padding()
  }
}

struct SignUpForm: View {
  @State var username: String = ""
  @State var emailAddress: String = ""
  @State var password: String = ""
  let onRegist: () -> Void
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        CustomInputField(text: $username, keyboardType: .default, placeholder: "Username")
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        CustomInputField(text: $emailAddress, keyboardType: .emailAddress, placeholder: "Email address")
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        SecretInputField(password: $password)
          .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
      }
      
      Button("GET STARTED", action: onRegist)
        .buttonStyle(AccentButtonStyle())
        .padding([.leading,.trailing], 20)
    }
  }
}

#Preview {
  SignUpScreen(onRegist: {}, onLoginTap: {} )
}

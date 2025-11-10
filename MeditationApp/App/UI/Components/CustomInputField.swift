import SwiftUI

struct CustomInputField: View {
  @Binding var text: String
  var keyboardType: UIKeyboardType = .default
  var placeholder: String
  
  var body: some View {
    HStack {
      TextField(placeholder, text: $text)
        .autocapitalization(.none)
        .keyboardType(keyboardType)
    }
    .padding(22)
    .background(.textFieldBackground)
    .cornerRadius(15)
  }
}

struct SecretInputField: View {
  @Binding var password: String
  
  var body: some View {
    HStack {
      SecureField("Password", text: $password)
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
    }
    .padding(22)
    .background(.textFieldBackground)
    .cornerRadius(15)
  }
}

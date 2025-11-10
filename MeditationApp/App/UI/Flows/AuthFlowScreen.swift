import SwiftUI

enum AuthFlowRoute: Hashable {
  case auth
  case register
}

struct AuthFlowScreen: View {
  let onComplete: () -> Void
  @State private var path: [AuthFlowRoute] = []
  
  var body: some View {
    NavigationStack(path: $path) {
      SignInScreen(
        onLogin: onComplete,
        onSignUpTap: { path.append(.register) } // переход на регистрацию
      )
      .navigationDestination(for: AuthFlowRoute.self) { route in
        switch route {
        case .register:
          SignUpScreen(
            onRegist: onComplete,
            onLoginTap: { path.removeAll() } // возврат на SignIn
          )
        case .auth:
          SignInScreen(
            onLogin: onComplete,
            onSignUpTap: { path.append(.register) }
          )
        }
      }
    }
  }
}

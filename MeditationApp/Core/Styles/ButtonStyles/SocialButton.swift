import SwiftUI

struct SocialButtonSignUp: View {
  
  var body: some View {
    VStack(spacing: 0) {
      SocialButton(title: "CONTINUE WITH FACEBOOK", icon: .facebook, color: .white)
        .frame(width: 374, height: 63)
        .background(.facebookButton)
        .cornerRadius(38)
        .padding(EdgeInsets(top: 33, leading: 20, bottom: 20, trailing: 20))
      
      ZStack {
        RoundedRectangle(cornerRadius: 38).stroke(.strokeGray, lineWidth: 1)
          .frame(width: 374, height: 63)
          .background(.white)
        SocialButton(title: "CONTINUE WITH GOOGLE", icon: .google, color: .mainText)
      } .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
      
      Text("OR LOG IN WITH EMAIL")
        .fontBuilder(.h3)
        .foregroundColor(.grayText)
        .padding(.bottom, 40 )
    }
  }
}

private struct SocialButton: View {
  var title: String = ""
  var icon: ImageResource
  var color: Color
  var body: some View {
    HStack(spacing: 0) {
      Image(icon)
        .padding(.leading, 34.84)
      Text(title)
        .fontBuilder(.h3)
        .foregroundColor(color)
        .padding(EdgeInsets(top: 24.5, leading: 45.78, bottom: 24.5, trailing: 73.58))
    }
  }
}

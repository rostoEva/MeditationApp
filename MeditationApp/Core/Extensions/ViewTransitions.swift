import SwiftUI

// Кастомный модификатор для масштабирования
struct ScaleModifier: ViewModifier {
  let scale: CGFloat
  
  func body(content: Content) -> some View {
    content.scaleEffect(scale)
  }
}

// Кастомные transitions для плавных анимаций
extension AnyTransition {
  // Плавный переход с движением справа налево и затуханием
  static var slideAndFade: AnyTransition {
    .asymmetric(
      insertion: .move(edge: .trailing).combined(with: .opacity),
      removal: .move(edge: .leading).combined(with: .opacity)
    )
  }
  
  // Плавный переход с масштабированием и затуханием для главного экрана
  static var fadeAndScale: AnyTransition {
    .asymmetric(
      insertion: .modifier(
        active: ScaleModifier(scale: 0.96),
        identity: ScaleModifier(scale: 1.0)
      ).combined(with: .opacity),
      removal: .modifier(
        active: ScaleModifier(scale: 1.04),
        identity: ScaleModifier(scale: 1.0)
      ).combined(with: .opacity)
    )
  }
}


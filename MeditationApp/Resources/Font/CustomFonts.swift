import SwiftUI

enum CustomFonts: String {
  case inter = "Inter"
}

struct FontBuilder {
  let font: Font
  let kerning: CGFloat
  let lineHeight: CGFloat
  let verticalPadding: CGFloat
  
  init(
    customFont: CustomFonts,
    fontSize: CGFloat,
    weight: Font.Weight = .regular,
    letterSpacing: CGFloat = 0,
    lineHeight: CGFloat? = nil
  ) {
    // Создаём кастомный шрифт
    self.font = Font.custom(customFont.rawValue, size: fontSize).weight(weight)
    
    self.kerning = letterSpacing
    
    // Если lineHeight не задан, используем стандартное значение шрифта
    let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    self.lineHeight = lineHeight ?? uiFont.lineHeight
    
    // Вычисляем вертикальный padding, чтобы текст вертикально центрировался
    self.verticalPadding = max((self.lineHeight - uiFont.lineHeight) / 2, 0)
  }
}

extension FontBuilder {
  static let h1 = FontBuilder(customFont: .inter, fontSize: 28, weight: .bold, letterSpacing: 0, lineHeight: 34)
  static let h2 = FontBuilder(customFont: .inter, fontSize: 16, weight: .light, letterSpacing: 0, lineHeight: 35)
  static let h3 = FontBuilder(customFont: .inter, fontSize: 14, weight: .medium, letterSpacing: 0, lineHeight: 18)
  static let h4 = FontBuilder(customFont: .inter, fontSize: 20, weight: .light, letterSpacing: 0, lineHeight: 24)
  static let h5 = FontBuilder(customFont: .inter, fontSize: 16, weight: .bold, letterSpacing: 0, lineHeight: 20)
  static let h6 = FontBuilder(customFont: .inter, fontSize: 24, weight: .medium, letterSpacing: 0, lineHeight: 28)
  static let h7 = FontBuilder(customFont: .inter, fontSize: 18, weight: .bold, letterSpacing: 0, lineHeight: 1.08)
  static let h8 = FontBuilder(customFont: .inter, fontSize: 11, weight: .medium, letterSpacing: 0.5, lineHeight: 14)
  static let h9 = FontBuilder(customFont: .inter, fontSize: 16, weight: .medium, letterSpacing: 0, lineHeight: 8)
}

struct FontBuilderModifier: ViewModifier {
  let style: FontBuilder
  
  func body(content: Content) -> some View {
    content
      .font(style.font)
      .kerning(style.kerning)
      .padding(.vertical, style.verticalPadding)
  }
}

extension View {
  func fontBuilder(_ style: FontBuilder) -> some View {
    self.modifier(FontBuilderModifier(style: style))
  }
}

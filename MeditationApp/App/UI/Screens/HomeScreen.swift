import SwiftUI

struct HomeScreen: View {
  let onCourseTap: () -> Void
  let onMusicTap: () -> Void
  let onDailyTap: () -> Void
  let onFocusTap: () -> Void
  let onHappinessTap: () -> Void
  
  var body: some View {
    ScrollView {
      HomeContentView(
        onCourseTap: onCourseTap,
        onMusicTap: onMusicTap,
        onDailyTap: onDailyTap,
        onFocusTap: onFocusTap,
        onHappinessTap: onHappinessTap
      )
    }
  }
}

struct HomeContentView: View {
  let onCourseTap: () -> Void
  let onMusicTap: () -> Void
  let onDailyTap: () -> Void
  let onFocusTap: () -> Void
  let onHappinessTap: () -> Void
  
  var body: some View {
    VStack(spacing: HomeConstants.sectionSpacing) {
      NavigationBar()
      WelcomePart()
      MeditationCategoryPicker(onCourseTap: onCourseTap, onMusicTap: onMusicTap)
      DailyThought(onDailyTap: onDailyTap)
      RecommendedPicker(onFocusTap: onFocusTap, onHappinessTap: onHappinessTap)
    }
  }
}


struct WelcomePart: View {
  var body: some View {
    VStack(spacing: 4) {
      Text("Good Morning, Alex").homeTitleStyle()
      Text("We Wish you have a good day").homeSubtitleStyle()
    }
    .padding(.top, 40)
    .padding(.horizontal, HomeConstants.horizontalPadding)
  }
}

struct MeditationCategoryPicker: View {
  let onCourseTap: () -> Void
  let onMusicTap: () -> Void
  
  var body: some View {
    HStack(spacing: HomeConstants.cardSpacing) {
      MeditationCategoryPickerView(coverImage: .basicsHome, action: onCourseTap)
      MeditationCategoryPickerView(coverImage: .relaxationHome, action: onMusicTap)
    }
    .padding(.horizontal, HomeConstants.horizontalPadding)
  }
}

struct MeditationCategoryPickerView: View {
  var coverImage: ImageResource
  let action: () -> Void
  @State private var isPressed = false
  
  var body: some View {
    Button(action: action) {
      Image(coverImage)
        .resizable()
        .scaledToFit()
        .cornerRadius(15)
        .shadow(radius: isPressed ? 1 : 3, y: isPressed ? 1 : 3)
        .scaleEffect(isPressed ? 0.95 : 1)
    }
    .buttonStyle(PlainButtonStyle())
    .simultaneousGesture(
      DragGesture(minimumDistance: 0)
        .onChanged { _ in
          withAnimation(.easeInOut(duration: 0.1)) {
            isPressed = true
          }
        }
        .onEnded { _ in
          withAnimation(.easeInOut(duration: 0.2)) {
            isPressed = false
          }
        }
    )
  }
}


struct DailyThought: View {
  let onDailyTap: () -> Void
  
  var body: some View {
    Button(action: onDailyTap) {
      Image(ImageResource.dailyThought)
        .resizable()
        .scaledToFit()
        .cornerRadius(15)
        .shadow(radius: 3)
    }
    .padding(.horizontal, HomeConstants.horizontalPadding)
  }
}

struct RecommendedPicker: View {
  let onFocusTap: () -> Void
  let onHappinessTap: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Recommended for you")
        .fontBuilder(.h6)
        .foregroundColor(.mainText)
        .padding(.leading, HomeConstants.horizontalPadding)
        .padding(.bottom, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: HomeConstants.cardSpacing) {
          ForEach(recommendedItems) { item in
            RecommendedPickerView(
              imageCover: item.image,
              title: item.title,
              description: item.description,
              onTap: {
                switch item.title {
                case "Focus":
                  onFocusTap()
                case "Happiness":
                  onHappinessTap()
                default:
                  break
                }
              }
            )
          }
        }.padding(.horizontal, HomeConstants.horizontalPadding)
      }
    }
  }
}

struct RecommendedItem: Identifiable {
  let id = UUID()
  let image: ImageResource
  let title: String
  let description: String
}

let recommendedItems = [
  RecommendedItem(image: .focusHome, title: "Focus", description: "MEDITATION 3 - 10 MIN"),
  RecommendedItem(image: .happinessHome, title: "Happiness", description: "MEDITATION 3 - 15 MIN"),
  RecommendedItem(image: .focusHome, title: "Focus", description: "MEDITATION 3 - 10 MIN")
]


struct RecommendedPickerView: View {
  var imageCover: ImageResource
  var title: String
  var description: String
  var onTap: () -> Void
  
  var body: some View {
    Button(action: onTap) {
      VStack(alignment: .leading, spacing: 6) {
        Image(imageCover)
          .resizable()
          .scaledToFit()
          .cornerRadius(10)
        Text(title)
          .fontBuilder(.h7)
          .foregroundColor(.mainText)
        Text(description)
          .fontBuilder(.h8)
          .foregroundColor(.grayText)
      }
      .frame(width: 150)
    }
    .buttonStyle(PlainButtonStyle())
  }
}
struct HomeConstants {
  static let horizontalPadding: CGFloat = 20
  static let verticalPadding: CGFloat = 20
  static let sectionSpacing: CGFloat = 30
  static let cardSpacing: CGFloat = 20
}

#Preview {
  HomeScreen(
    onCourseTap: {},
    onMusicTap: {},
    onDailyTap: {},
    onFocusTap: {},
    onHappinessTap: {})
}

import SwiftUI
import AVFoundation

struct PlayerScreen: View {
  let track: Track
  @StateObject private var viewModel = PlayerViewModel()
  
  var body: some View {
    ZStack {
      Image(.backgroundPlayer)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      
      VStack(spacing: 40) {
        Spacer()
        
        // Название трека и коллекции
        VStack(spacing: 8) {
          Text(track.title)
            .fontBuilder(.h1)
            .padding(.bottom, 15)
            .foregroundColor(.mainText)
          Text(track.collection)
            .fontBuilder(.h8)
            .foregroundColor(.grayText)
        }
        
        // Элементы управления
        HStack(spacing: 50) {
          Button(action: { viewModel.skipBackward() }) {
            Image(.goBackIcon)
          }
          
          Button(action: { viewModel.playPause() }) {
            Image(viewModel.isPlaying ? .pauseButton : .playButton)
              .padding()
          }
          
          Button(action: { viewModel.skipForward() }) {
            Image(.goForward)
          }
        }
        
        // Прогресс-бар с бегунком
        Slider(value: $viewModel.progress, in: 0...1)
          .accentColor(.mainText)
          .padding(.horizontal, 40)
        
        Spacer()
      }
      .padding(.bottom, 80)
    }
    .onAppear {
      viewModel.load(track: track)
    }
  }
}

// Preview с тестовым треком
struct PlayerScreen_Previews: PreviewProvider {
  static var previews: some View {
    PlayerScreen(
      track: Track(
        id: 1,
        title: "Soft Wind",
        collection: "Evening Relax",
        duration: 358,
        audioURL: "https://freesound.org/data/previews/81910/81910-lq.mp3"
      )
    )
  }
}

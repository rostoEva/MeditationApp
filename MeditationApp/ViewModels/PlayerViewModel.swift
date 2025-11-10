import Foundation
import SwiftUI
import AVFoundation
import Combine

class PlayerViewModel: NSObject, ObservableObject {
  @Published var isPlaying = false
  @Published var progress: Double = 0.0
  @AppStorage("lastPlayedTrack") private var lastTrackID: Int?
  @Published var currentTrack: Track?
  @Published var errorMessage: String?
  @Published var isLoading = false
  @Published var isSeekable = false
  
  private var player: AVPlayer?
  private var timeObserver: Any?
  private var playerItem: AVPlayerItem?
  
  func load(track: Track) {
    stop()
    currentTrack = track
    errorMessage = nil
    isLoading = true
    
    print("🎵 Загружаем трек: \(track.title)")
    print("🔗 AudioURL: \(track.audioURL)")
    
    // Пробуем найти локальный файл
    let url = findLocalAudioURL(track.audioURL)
    
    guard let finalURL = url else {
      print("❌ Не удалось найти аудиофайл: \(track.audioURL)")
      errorMessage = "Аудиофайл не найден"
      isLoading = false
      return
    }
    
    print("✅ Найден файл: \(finalURL.lastPathComponent)")
    
    // Создаем AVPlayerItem для отслеживания статуса
    playerItem = AVPlayerItem(url: finalURL)
    player = AVPlayer(playerItem: playerItem)
    
    // Отслеживаем статус загрузки
    playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new, .initial], context: nil)
    
    // Следим за прогрессом воспроизведения
    let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
      guard
        let self = self,
        let duration = self.player?.currentItem?.duration.seconds,
        duration > 0
      else { return }
      
      self.progress = time.seconds / duration
      print("⏱️ Прогресс: \(Int(self.progress * 100))%")
    }
    
    // Отслеживаем окончание воспроизведения
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(playerDidFinishPlaying),
      name: .AVPlayerItemDidPlayToEndTime,
      object: playerItem
    )
  }
  
  // Добавьте этот метод для поиска локальных файлов
  private func findLocalAudioURL(_ fileName: String) -> URL? {
    let extensions = ["mp3", "wav", "m4a", "aac", "caf"]
    
    for ext in extensions {
      if let url = Bundle.main.url(forResource: fileName, withExtension: ext) {
        print("📁 Найден файл: \(fileName).\(ext)")
        return url
      }
    }
    
    // Если файл не найден, попробуем без расширения (на случай если в audioURL уже есть расширение)
    if let url = Bundle.main.url(forResource: fileName, withExtension: nil) {
      print("📁 Найден файл: \(fileName)")
      return url
    }
    
    print("❌ Файл не найден: \(fileName)")
    return nil
  }
  
  // Обработка статуса загрузки аудио
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == #keyPath(AVPlayerItem.status) {
      isLoading = false
      
      if let playerItem = object as? AVPlayerItem {
        print("🎛️ Статус плеера: \(playerItem.status.rawValue)")
        
        switch playerItem.status {
        case .readyToPlay:
          let duration = playerItem.duration.seconds
          print("✅ Аудио готово к воспроизведению")
          print("⏱️ Длительность: \(duration) сек")
          isSeekable = duration.isFinite && !duration.isNaN && duration > 0
          print("🎛️ Перемотка доступна: \(isSeekable)")
          isPlaying = true
          player?.play()
          
        case .failed:
          let error = playerItem.error?.localizedDescription ?? "Unknown error"
          print("❌ Ошибка загрузки аудио: \(error)")
          if let underlyingError = playerItem.error as NSError? {
            print("🔧 Код ошибки: \(underlyingError.code)")
            print("📋 Домен: \(underlyingError.domain)")
          }
          errorMessage = "Ошибка загрузки: \(error)"
          
        case .unknown:
          print("❓ Статус аудио неизвестен")
          print("📦 Формат: \(playerItem.asset)")
          errorMessage = "Неизвестная ошибка загрузки"
          
        @unknown default:
          break
        }
      }
    }
  }
  
  @objc private func playerDidFinishPlaying() {
    print("🎵 Воспроизведение завершено")
    isPlaying = false
    progress = 1.0
  }
  
  func playPause() {
    guard let player = player else {
      errorMessage = "Аудио не загружено"
      return
    }
    
    if isPlaying {
      player.pause()
      print("⏸️ Пауза")
    } else {
      player.play()
      print("▶️ Воспроизведение")
    }
    
    isPlaying.toggle()
  }
  
  func stop() {
    print("⏹️ Остановка")
    player?.pause()
    isPlaying = false
    progress = 0.0
    isLoading = false
    isSeekable = false
    
    // Убираем наблюдатели
    if let observer = timeObserver {
      player?.removeTimeObserver(observer)
      timeObserver = nil
    }
    
    if let item = playerItem {
      item.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
      playerItem = nil
    }
    
    NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
  }
  
  func skipForward() {
    guard let player = player,
          let currentItem = player.currentItem,
          currentItem.status == .readyToPlay else { return }
    
    let currentTime = player.currentTime().seconds
    let duration = currentItem.duration.seconds
    
    // Проверяем что длительность известна и валидна
    guard duration.isFinite && !duration.isNaN && duration > 0 else {
      print("❌ Длительность трека неизвестна")
      return
    }
    
    let newTime = min(currentTime + 15, duration - 1) // -1 чтобы не перескакивать конец
    let targetTime = CMTime(seconds: newTime, preferredTimescale: 1)
    
    player.seek(to: targetTime) { [weak self] completed in
      if completed {
        print("⏩ Перемотано вперед на 15 сек: \(Int(newTime))сек")
      } else {
        print("❌ Перемотка не удалась")
      }
    }
  }
  
  func skipBackward() {
    guard let player = player,
          let currentItem = player.currentItem,
          currentItem.status == .readyToPlay else { return }
    
    let currentTime = player.currentTime().seconds
    let newTime = max(currentTime - 15, 0)
    let targetTime = CMTime(seconds: newTime, preferredTimescale: 1)
    
    player.seek(to: targetTime) { [weak self] completed in
      if completed {
        print("⏪ Перемотано назад на 15 сек: \(Int(newTime))сек")
      } else {
        print("❌ Перемотка не удалась")
      }
    }
  }
  
  func seekToProgress() {
    guard let player = player,
          let currentItem = player.currentItem,
          currentItem.status == .readyToPlay else { return }
    
    let duration = currentItem.duration.seconds
    guard duration.isFinite && !duration.isNaN && duration > 0 else {
      print("❌ Длительность трека неизвестна для перемотки")
      return
    }
    
    let newTime = progress * duration
    let targetTime = CMTime(seconds: newTime, preferredTimescale: 1)
    
    player.seek(to: targetTime) { [weak self] completed in
      if completed {
        print("🎯 Перемотано к \(Int(self?.progress ?? 0 * 100))%")
      }
    }
  }
  
  deinit {
    stop()
    print("🧹 PlayerViewModel деинициализирован")
  }
}



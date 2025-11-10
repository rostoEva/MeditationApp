import Foundation
import Combine

/// Единый сервис для управления всеми данными приложения
/// Объединяет функциональность DataManager и DataManagerPrograms
class DataService: ObservableObject {
  // MARK: - Published Properties
  
  // MARK: - Published Properties
  
  // Треки по категориям
  @Published var musicTracks: [Track] = []
  @Published var meditationTracks: [Track] = []
  @Published var focusTracks: [Track] = []
  @Published var happinessTracks: [Track] = []
  
  // MARK: - Programs
  
  // Программы
  @Published var programs: [Program] = []
  
  // MARK: - Loading State
  
  // Состояние загрузки
  @Published var isLoading = false
  @Published var error: DataManagerError?
  
  // MARK: - Private Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Initialization
  
  init() {
    loadAllData()
  }
  
  // MARK: - Public Methods
  
  /// Загружает все данные приложения
  func loadAllData() {
    isLoading = true
    error = nil
    
    Task {
      do {
        async let musicTracks: [Track] = fetchData(from: "tracks", type: [Track].self)
        async let meditationTracks: [Track] = fetchData(from: "meditation", type: [Track].self)
        async let focusTracks: [Track] = fetchData(from: "focus", type: [Track].self)
        async let happinessTracks: [Track] = fetchData(from: "happiness", type: [Track].self)
        async let programs: [Program] = fetchData(from: "programs", type: [Program].self)
        
        // Дожидаемся завершения всех асинхронных операций
        let (music, meditation, focus, happiness, programData) = try await (musicTracks, meditationTracks, focusTracks, happinessTracks, programs)
        
        // Обновляем данные в главном потоке
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.musicTracks = music
          self.meditationTracks = meditation
          self.focusTracks = focus
          self.happinessTracks = happiness
          self.programs = programData
          self.error = nil
          self.isLoading = false
          
          print("✅ Загружено:")
          print("   - Музыка: \(music.count) треков")
          print("   - Медитации: \(meditation.count) треков")
          print("   - Фокус: \(focus.count) треков")
          print("   - Счастье: \(happiness.count) треков")
          print("   - Программы: \(programData.count)")
        }
      } catch {
        // Обрабатываем ошибки
        DispatchQueue.main.async { [weak self] in
          self?.isLoading = false
          if let dataManagerError = error as? DataManagerError {
            self?.error = dataManagerError
          } else {
            self?.error = .dataNotFound
          }
          print("❌ Ошибка загрузки данных: \(error.localizedDescription)")
        }
      }
    }
  }
  
  /// Обновляет все данные
  func refreshData() {
    loadAllData()
  }
  
  // MARK: - Track Methods
  
  /// Находит трек по ID во всех категориях
  func track(withId id: Int) -> Track? {
    return musicTracks.first { $0.id == id }
    ?? meditationTracks.first { $0.id == id }
    ?? focusTracks.first { $0.id == id }
    ?? happinessTracks.first { $0.id == id }
  }
  
  /// Получает все треки определенной категории
  func tracks(for category: TrackCategory) -> [Track] {
    switch category {
    case .music:
      return musicTracks
    case .meditation:
      return meditationTracks
    case .focus:
      return focusTracks
    case .happiness:
      return happinessTracks
    }
  }
  
  // MARK: - Program Methods
  
  /// Находит программу по ID
  func program(withId id: Int) -> Program? {
    return programs.first { $0.id == id }
  }
  
  /// Получает программы определенной категории
  func programsInCategory(_ category: String) -> [Program] {
    return programs.filter { $0.category == category }
  }
  
  // MARK: - Private Methods
  
  /// Загружает данные из JSON файла
  private func fetchData<T: Decodable>(from fileName: String, type: T.Type) async throws -> T {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
      print("❌ Файл \(fileName).json не найден")
      throw DataManagerError.dataNotFound
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      print("❌ Ошибка декодирования \(fileName): \(error)")
      if error is DecodingError {
        throw DataManagerError.decodingError
      } else {
        throw DataManagerError.dataNotFound
      }
    }
  }
}

// MARK: - TrackCategory

/// Категории треков
enum TrackCategory: String, CaseIterable {
  case music
  case meditation
  case focus
  case happiness
}


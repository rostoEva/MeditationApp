import Foundation
import Combine

/// Сервис для управления избранными программами медитации
class FavoritesService: ObservableObject {
  // MARK: - Published Properties
  
  @Published var favoriteProgramIds: Set<Int> = []
  
  // MARK: - Private Properties
  
  private let favoritesKey = "favoriteProgramIds"
  
  // MARK: - Initialization
  
  init() {
    loadFavorites()
  }
  
  // MARK: - Public Methods
  
  /// Загружает избранные программы из UserDefaults
  func loadFavorites() {
    // Set<Int> не Codable напрямую, используем Array
    if let data = UserDefaults.standard.data(forKey: favoritesKey),
       let idsArray = try? JSONDecoder().decode([Int].self, from: data) {
      favoriteProgramIds = Set(idsArray)
    }
  }
  
  /// Сохраняет избранные программы в UserDefaults
  private func saveFavorites() {
    // Конвертируем Set в Array для сохранения
    let idsArray = Array(favoriteProgramIds)
    if let data = try? JSONEncoder().encode(idsArray) {
      UserDefaults.standard.set(data, forKey: favoritesKey)
    }
  }
  
  /// Добавляет программу в избранное
  func addToFavorites(programId: Int) {
    favoriteProgramIds.insert(programId)
    saveFavorites()
  }
  
  /// Удаляет программу из избранного
  func removeFromFavorites(programId: Int) {
    favoriteProgramIds.remove(programId)
    saveFavorites()
  }
  
  /// Проверяет, является ли программа избранной
  func isFavorite(programId: Int) -> Bool {
    return favoriteProgramIds.contains(programId)
  }
  
  /// Переключает статус избранного для программы
  func toggleFavorite(programId: Int) {
    if isFavorite(programId: programId) {
      removeFromFavorites(programId: programId)
    } else {
      addToFavorites(programId: programId)
    }
  }
  
  /// Фильтрует программы по избранному
  func filterFavorites(from programs: [Program]) -> [Program] {
    return programs.filter { favoriteProgramIds.contains($0.id) }
  }
}


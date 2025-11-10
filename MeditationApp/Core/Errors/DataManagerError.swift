import Foundation

enum DataManagerError: Error, LocalizedError {
  case dataNotFound
  case decodingError
  case networkError
  case unknownError
  
  var errorDescription: String? {
    switch self {
    case .dataNotFound:
      return "Данные не найдены"
    case .decodingError:
      return "Ошибка при обработке данных"
    case .networkError:
      return "Ошибка сети"
    case .unknownError:
      return "Неизвестная ошибка"
    }
  }
}



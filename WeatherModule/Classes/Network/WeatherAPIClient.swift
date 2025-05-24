import Foundation

internal final class WeatherAPIClient {
    private let apiKey: String
    private let baseURL = "https://api.weatherapi.com/v1/current.json"

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func fetchWeather(for location: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(WeatherAPIError.invalidURL))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: location)
        ]

        guard let url = urlComponents.url else {
            completion(.failure(WeatherAPIError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(WeatherAPIError.network(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(WeatherAPIError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(WeatherAPIError.noData))
                return
            }

            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(WeatherAPIError.decoding(error)))
            }
        }

        task.resume()
    }
}

enum WeatherAPIError: Error, LocalizedError {
    case invalidURL
    case network(Error)
    case invalidResponse
    case noData
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .network(let error): return "Network error: \(error.localizedDescription)"
        case .invalidResponse: return "Invalid server response"
        case .noData: return "No data received"
        case .decoding(let error): return "Decoding error: \(error.localizedDescription)"
        }
    }
}

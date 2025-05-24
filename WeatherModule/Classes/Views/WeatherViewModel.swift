import Foundation

@MainActor
internal final class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var isLoading = true
    @Published var error: String?

    private let client: WeatherAPIClient

    init(apiKey: String, location: String) {
        self.client = WeatherAPIClient(apiKey: apiKey)
        self.fetchWeather(for: location)
    }

    func fetchWeather(for location: String) {
        isLoading = true
        error = nil

        client.fetchWeather(for: location) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let weather):
                    self.weather = weather
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    func currentTemperature() -> String {
        guard let weather = weather else { return "N/A" }
        return String(format: "%.1f°C", weather.current.temp_c)
    }
    
    func currentCondition() -> String {
        guard let weather = weather else { return "N/A" }
        return weather.current.condition.text
    }
    
    func currentTitle() -> String {
        guard let weather = weather else { return "N/A" }
        return weather.location.name
    }
    
    func currentConditionIconUrl () -> URL? {
        guard let weather = weather else { return nil}
        return URL(string: "https:\(weather.current.condition.icon)")
    }
}

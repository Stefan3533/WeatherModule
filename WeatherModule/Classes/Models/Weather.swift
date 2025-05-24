import Foundation

internal struct Weather: Codable {
    let location: Location
    let current: CurrentWeather
}

internal struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime: String
}

internal struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: Condition
    let wind_kph: Double
    let humidity: Int
    let feelslike_c: Double
    let uv: Double
}

internal struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

import SwiftUI

public struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    
   public init(apiKey: String, location: String) {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(apiKey: apiKey, location: location))
    }

    public var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading weather...")
            } else if viewModel.weather != nil {
                HStack {
                    if let iconURL = viewModel.currentConditionIconUrl() {
                        AsyncImage(url: iconURL) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack {
                        Text(viewModel.currentTitle())
                            .font(.largeTitle)
                        Text(viewModel.currentTemperature())
                            .font(.title)
                        Text(viewModel.currentCondition())
                            .font(.subheadline)
                        
                    }
                    .padding()
                }
                
            } else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
    }
}
#Preview {
    //My demo API key
    WeatherView(apiKey: "d2922eed8e7140889d571325252405", location: "Pretoria")
}

import SwiftUI

struct ContentView: View {

    @StateObject var locationManager = LocationManager()
    @State var weather: ResponseBody?
    var weatherManager = WeatherManager()

    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(
                                    lattitude: location.latitude,
                                    lontitude: location.longitude
                                )
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else if locationManager.isLoading {
                LoadingView()
            } else {
                WelcomeView().environmentObject(locationManager)
            }

        }
        .background(Color("DarkBlue"))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

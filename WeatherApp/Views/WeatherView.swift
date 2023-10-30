import SwiftUI

struct WeatherView: View {

    var weather: ResponseBody
    var CityImg = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Town_Cityscape.svg/320px-Town_Cityscape.svg.png"

    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                header
                Spacer()
                VStack {
                    info
                    Spacer().frame(height:  80)
                    image
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            infoRows
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

extension WeatherView {
    var header: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(weather.name)
                .bold()
                .font(.title)
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    var info: some View {
        HStack {
            VStack(spacing: 20) {
                Image(systemName: "cloud")
                    .font(.system(size: 40))

                Text("\(weather.weather[0].main)")
            }
            .frame(width: 150, alignment: .leading)

            Spacer()

            Text(weather.main.feelsLike.roundDouble() + "°")
                .font(.system(size: 100))
                .fontWeight(.bold)
                .padding()
        }
    }
    var image: some View {
        AsyncImage(url: URL(string: CityImg)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
        } placeholder: {
            ProgressView()
        }
    }
    var infoRows: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Weather now")
                    .bold()
                    .padding(.bottom)
                HStack {
                    WeatherRowView(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                    Spacer()
                    WeatherRowView(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                }
                HStack {
                    WeatherRowView(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                    Spacer()
                    WeatherRowView(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .background(.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}

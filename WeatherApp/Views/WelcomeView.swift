import SwiftUI
import CoreLocationUI

struct WelcomeView: View {

    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the Weather")
                    .bold()
                    .font(.title)
                Text("Please share your current location to get weathet in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}

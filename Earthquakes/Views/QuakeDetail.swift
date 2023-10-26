//
//  QuakeDetail.swift
//  Earthquakes-iOS
//
//  Created by Данил Шипицын on 26.10.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct QuakeDetail: View {
    var quake: Quake
    @State private var showFullLatitude: Bool = false
    @State private var showFullLongitude: Bool = false
    @EnvironmentObject private var provider: QuakesProvider
    @State private var quakeLocation: QuakeLocation? = nil
    
    var body: some View {
        VStack {
            if let location = quakeLocation {
                QuakeDetailMap(location: location, tintColor: quake.color)
                    .ignoresSafeArea(.container)
            }
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(.secondary)
            if let location = quakeLocation {
                var latitudeString: String {
                    get {
                        if showFullLatitude {
                            location.latitude.formatted()
                        } else {
                            location.latitude.formatted(.number.precision(.fractionLength(3)))
                        }
                    }
                }
                var longitudeString: String {
                    get {
                        if showFullLongitude {
                            location.longitude.formatted()
                        } else {
                            location.longitude.formatted(.number.precision(.fractionLength(3)))
                        }
                    }
                }
                
                Text(
                    "Latitude: \(latitudeString)")
                .onTapGesture {
                    showFullLatitude = !showFullLatitude
                }
                Text(
                    "Longitude: \(longitudeString)")
                .onTapGesture {
                    showFullLongitude = !showFullLongitude
                }
            }
        }
        .task {
            if quakeLocation == nil {
                if let location = quake.location {
                    quakeLocation = location
                } else {
                    do {
                        quakeLocation = try await provider.client.quakeLocation(from: quake.detail)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}

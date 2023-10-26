//
//  QuakeDetailMap.swift
//  Earthquakes-iOS
//
//  Created by Данил Шипицын on 26.10.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColor: Color
    private var place: QuakePlace
    @State private var region = MKCoordinateRegion()
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = QuakePlace(latitude: location.latitude, longitude: location.longitude)
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [place]) { item in
            MapMarker(coordinate: item.location, tint: tintColor)
        }
        .onAppear {
            withAnimation {
                region.center = place.location
                region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            }
        }
    }
}

struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), latitude: Double, longitude: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

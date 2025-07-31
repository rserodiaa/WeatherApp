//
//  ValueDescriptionView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 24/07/25.
//

import SwiftUI

struct ValueDescriptionView: View {
    let imageName: String
    let value: String
    let weatherAttr: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 30)
            Text(value).font(.subheadline).fontWeight(.bold).padding(.vertical, 2)
            Text(weatherAttr).font(.caption).foregroundColor(.gray)
        }
    }
}

#Preview {
    ValueDescriptionView(imageName: ImageConstants.wind, value: "4 km/h", weatherAttr: "Wind Speed")
}

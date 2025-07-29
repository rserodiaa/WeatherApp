//
//  DailyRow.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 29/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct DailyRow: View {
    var imageName: URL?
    var temp: Int
    var day: String
    var date: String
    
    var body: some View {
        HStack(spacing: 25) {
            WebImage(url: imageName)
                .resizable()
                .frame(width: 60, height: 60)
            Spacer()
            Text("\(temp)° C").font(.system(size: 27))
            
            VStack(spacing: 8) {
                Text(day)
                Text(date)
            }
        }
        .foregroundColor(.white)
        .fontWeight(.semibold)
        
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(imageName: URL(string:
                                    AppConstants.getIconURL()),
                 temp: 30,
                 day: "Monday",
                 date: "17 Oct")
    }
}

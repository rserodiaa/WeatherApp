//
//  HourlyBox.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 25/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

//Do let
struct HourlyBox: View {
    var time: String
    var iconURL: String
    var temp: Int
    var body: some View {
        VStack {
            Text(time)
                .font(.caption)
                .fontWeight(.semibold)
            WebImage(url: URL(string: iconURL))
                .resizable()
                .frame(width: 50, height: 50)
            Text("\(temp)° C")
                .fontWeight(.bold)
                .font(.system(size: 17))
        }
        .foregroundColor(.white)
        .frame(width: 80, height: 130)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.purple)
            )
    }
}

struct HourlyBox_Previews: PreviewProvider {
    static var previews: some View {
        HourlyBox(time: "11:00 AM", iconURL: "", temp: 23)
    }
}

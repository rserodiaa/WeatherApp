//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 30/07/25.
//

import SwiftUI

private struct Constants {
    static let enterCity = "Enter city name"
    static let add = "Add"
    static let yourCities = "Your Cities"
    static let manageCities = "Manage Cities"
    static let error = "Error"
    static let ok = "OK"
    static let duplicateCity = "This city is already in your list"
}

struct AddCityView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var cityName = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @ObservedObject var viewModel: WeatherLandingViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 12) {
                    HStack {
                        Image(systemName: ImageConstants.search)
                            .foregroundColor(.gray)
                        
                        TextField(Constants.enterCity, text: $cityName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.primaryColor.opacity(0.2))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .cornerRadius(15)
                        
                        Button(Constants.add) {
                            addCity()
                        }
                        .disabled(cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.5) : Color.primaryColor
                        )
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .cornerRadius(15)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 20)
                
                if !viewModel.cities.isEmpty {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(Constants.yourCities)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                            Spacer()
                        }
                        
                        List {
                            ForEach(viewModel.cities) { city in
                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(.white.opacity(0.2))
                                            .frame(width: 40, height: 40)
                                        
                                        Image(systemName: ImageConstants.location)
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                    
                                    Text(city.cityName)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.primaryColor.opacity(0.9))
                                .cornerRadius(15)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        viewModel.deleteCity(city)
                                    } label: {
                                        Image(systemName: ImageConstants.cross)
                                            .resizable()
                                            .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .addLinearGradientBackground()
            .navigationTitle(Constants.manageCities)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.primaryColor)
                            .padding(8)
                    }
                }
            }
            .alert(Constants.error, isPresented: $showingAlert) {
                Button(Constants.ok, role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .onChange(of: viewModel.status) { _, newValue in
                if case let .error(message) = newValue {
                    alertMessage = message
                    showingAlert = true
                }
            }
        }
        
    }
    
    private func addCity() {
        let trimmedCityName = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedCityName.isEmpty else { return }
        
        if viewModel.cities.contains(where: { $0.cityName.lowercased() == trimmedCityName.lowercased() }) {
            alertMessage = Constants.duplicateCity
            showingAlert = true
            return
        }
        viewModel.addCity(trimmedCityName)
        cityName = ""
    }
}


// Preview
#Preview {
    AddCityView(viewModel: .preview)
}

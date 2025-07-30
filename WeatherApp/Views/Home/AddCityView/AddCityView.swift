//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 30/07/25.
//

import SwiftUI

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
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Enter city name", text: $cityName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            .background(.white.opacity(0.9))
                            .cornerRadius(15)
                        
                        Button("Add") {
                            addCity()
                        }
                        .disabled(cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.7) : Color.primaryColor
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
                            Text("Your Cities")
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
                                        
                                        Image(systemName: "location.fill")
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
                                        if let index = viewModel.cities.firstIndex(where: { $0.id == city.id }) {
                                            viewModel.cities.remove(at: index)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                    }
                                    .tint(Color.purple.opacity(0.7))
                                }
                            }
                            .onDelete(perform: deleteCity)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .addLinearGradientBackground()
            .navigationTitle("Manage Cities")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
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
            alertMessage = "This city is already in your list"
            showingAlert = true
            return
        }
        viewModel.addCity(trimmedCityName)
        cityName = ""
    }
    
    
    
    private func deleteCity(at offsets: IndexSet) {
        for index in offsets {
            let cityToDelete = viewModel.cities[index]
            viewModel.deleteCity(cityToDelete)
        }
    }
    
}


// Preview
#Preview {
    AddCityView(viewModel: .preview)
}

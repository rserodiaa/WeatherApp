//
//  WeatherLaunchScreen.swift
//  WeatherApp
//
//  Created by Rahul Serodia on 31/07/25.
//

import SwiftUI

private struct Constants {
    static let title = "WeatherPro"
    static let subtitle = "Your Weather Companion"
}

struct WeatherLaunchScreen: View {
    @State private var isAnimating = false
    @State private var showText = false
    @State private var rotateCloud = false
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.primaryColor.opacity(0.8),
                    Color.primaryColor.opacity(0.6),
                    Color.primaryColor.opacity(0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Floating particles background
            ForEach(0..<20, id: \.self) { index in
                Circle()
                    .fill(Color.primaryColor)
                    .frame(width: CGFloat.random(in: 4...12))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 2...4))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...2)),
                        value: isAnimating
                    )
                    .opacity(isAnimating ? 0.3 : 0.1)
            }
            
            VStack(spacing: 30) {
                ZStack {
                    // Outer glow
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 140, height: 140)
                        .scaleEffect(pulseScale)
                        .animation(
                            Animation.easeInOut(duration: 2)
                                .repeatForever(autoreverses: true),
                            value: pulseScale
                        )
                    
                    // Weather icon container
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: ImageConstants.cloudSun)
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(rotateCloud ? 360 : 0))
                        )
                        .scaleEffect(isAnimating ? 1.1 : 0.8)
                        .animation(
                            .spring(response: 1.2, dampingFraction: 0.6),
                            value: isAnimating
                        )
                }
                
                // App name
                VStack(spacing: 8) {
                    Text(Constants.title)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 20)
                        .animation(
                            .easeOut(duration: 0.8).delay(0.5),
                            value: showText
                        )
                    
                    Text(Constants.subtitle)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 20)
                        .animation(
                            .easeOut(duration: 0.8).delay(0.8),
                            value: showText
                        )
                }
            }
            
            // Loading indicator at bottom
            VStack {
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.white.opacity(0.7))
                            .frame(width: 8, height: 8)
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .animation(
                                Animation.easeInOut(duration: 0.6)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(index) * 0.2),
                                value: isAnimating
                            )
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        withAnimation {
            isAnimating = true
            pulseScale = 1.2
        }
        
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
            rotateCloud = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showText = true
        }
    }
}

struct LaunchScreenView: View {
    @State private var showMainApp = false
    
    var body: some View {
        if showMainApp {
            let storageService = WeatherStorageService()
            let repository = WeatherRepository(storageService: storageService)
            WeatherLandingView(viewModel: WeatherLandingViewModel(repostory: repository))
                .tint(Color.primaryColor)
        } else {
            WeatherLaunchScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showMainApp = true
                        }
                    }
                }
        }
    }
}

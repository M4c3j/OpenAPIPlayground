//
//  ContentView.swift
//  OpenAPIPlayground
//
//  Created by Maciej Lipiec on 2023-06-26.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    
    @State private var emoji = "🥳"
    @State private var greeting = GreetingClient()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(emoji)
                .task {
                    do {
                        emoji = try await greeting.getGreeting()
                    } catch {
                        emoji = ""
                    }
                }
        }
        .padding()
    }

    
}


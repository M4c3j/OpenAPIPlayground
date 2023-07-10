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
    
    @State private var emoji = "😼"
    @State private var greeting = GreetingClient()
    @State private var userName = ""
    @State private var age = "?"
    
    var body: some View {
        VStack {
            Spacer()
            Text("Cat info:")
                .font(.title)
            Text(emoji)
                .task {
                    do {
                        emoji = try await greeting.getGreeting()
                    } catch {
                        emoji = ""
                    }
                }
                .font(emoji == "😼" ? .largeTitle : .title3)
            Spacer()
            TextField("Type your name", text: $userName)
                .padding()
                .background(.gray)
                .cornerRadius(10)
            Text("Do not use whitespaces in names!!!!")
                .font(.footnote)
            HStack{
                Text("Your age is:")
                Text(age)
            }
            .padding()
            Button("Get Age") {
                Task {
                    do {
                        age = try await greeting.getAge(name: userName)
                    } catch {
                        age = "1000"
                    }
                }
            }
            .padding()
            .background(.gray)
            .cornerRadius(10)
            Spacer()
        }
        .padding()
    }
    
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

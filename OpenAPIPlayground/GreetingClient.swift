//
//  Client.swift
//  OpenAPIPlayground
//
//  Created by Maciej Lipiec on 2023-06-26.
//

import OpenAPIURLSession
import Foundation

public struct GreetingClient {
    
    public init() {}
    
    public func getGreeting() async throws -> String {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        let response = try await client.getFact(
            .init(
                query: .init()
            )
        )
        switch response {
        case .ok(let okResponse):
            print(okResponse)
            switch okResponse.body {
            case .json(let greeting):
                return greeting.fact ?? ""
            }
        case .undocumented(statusCode: let statusCode, _):
            print(statusCode)
            return "\(statusCode)"
        }
    }
    
    public func getAge(name: String) async throws -> String {
        let client = Client(
            serverURL: URL(string: "https://api.agify.io")!,
            transport: URLSessionTransport()
        )
        let response = try await client.getAge(
            .init(
                query: .init(name: name)
            )
        )
        switch response {
        case .ok(let okResponse):
            print(okResponse)
            switch okResponse.body {
            case .json(let greeting):
                guard let age = greeting.age else {
                    return "Faield"
                }
                return "\(age)"
            }
        case .undocumented(statusCode: let statusCode, _):
            print(statusCode)
            return "\(statusCode)"
        }
    }
}

//
//  Endpoint.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/05.
//

import Foundation

protocol Requestable {
    var scheme: String { get }
    var host: String { get }
    var basePath: String { get }
    var path: String { get }
    var parameter: Int? { get }
    var queryParameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    
    func url() -> URL?
}

enum HTTPMethod: String {
    case get = "GET"
}

struct Endpoint: Requestable {
    
    let scheme: String
    let host: String
    let basePath: String
    let path: String
    let parameter: Int?
    let queryParameters: [String: Any]?
    let method: HTTPMethod

    init(scheme: String, host: String, basePath: String, path: String, parameter: Int?, queryParameters: [String: Any]?, method: HTTPMethod) {
        self.scheme = scheme
        self.host = host
        self.basePath = basePath
        self.path = path
        self.parameter = parameter
        self.queryParameters = queryParameters
        self.method = method
    }
    
    func url() -> URL? {
        var component = URLComponents()
        component.scheme = self.scheme
        component.host = self.host
        if let parameter = parameter {
            component.path = self.basePath + self.path + "\(parameter)"
        } else {
            component.path = self.basePath + self.path
        }
        guard let queryParameters = queryParameters else { return component.url }
        var queryItems = [URLQueryItem]()
        queryParameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)")) }
        component.queryItems = queryItems
        return component.url
    }
    
}

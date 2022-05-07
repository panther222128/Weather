//
//  APIEndpoint.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/05.
//

import Foundation

enum Scheme: String {
    case https = "https"
}

enum Host: String {
    case base = "www.metaweather.com"
}

enum Path: String {
    case basePath = ""
    case locationPath = "/api/location/"
    case searchPath = "/api/location/search/"
}

struct APIEndpoint {
    
    static func getSearchEndpoint(with searchKeyword: String) -> Endpoint {
        let queryParameter = ["query":"\(searchKeyword)"]
        return Endpoint(scheme: Scheme.https.rawValue, host: Host.base.rawValue, basePath: Path.basePath.rawValue, path: Path.searchPath.rawValue, parameter: nil, queryParameters: queryParameter, method: .get)
    }
    
    static func getLocationEndpoint(with parameter: Int) -> Endpoint {
        return Endpoint(scheme: Scheme.https.rawValue, host: Host.base.rawValue, basePath: Path.basePath.rawValue, path: Path.locationPath.rawValue, parameter: parameter, queryParameters: nil, method: .get)
    }
    
}

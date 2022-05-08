//
//  LocationSearchResultDTO.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/05.
//

import Foundation

struct LocationSearchResultResponseDTO: Decodable {
    
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case lattLong = "latt_long"
        case woeid
    }
    
    func convertToDomain() -> LocationSearchResult {
        return .init(title: title, locationType: locationType, woeid: woeid, lattLong: lattLong)
    }
    
}

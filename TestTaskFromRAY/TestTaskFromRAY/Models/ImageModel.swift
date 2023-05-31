//
//  ImageModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

struct ImageModel: Codable {
    let imageData: Data
    
    enum CodingKeys: String, CodingKey {
        case imageData
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.imageData = try values.decode(Data.self, forKey: .imageData)
    }
}

//
//  HighSchool.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import Foundation

struct HighSchool: Identifiable, Codable {
    let id: String
    let schoolName: String

    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
    }
}

//
//  HighSchoolSATResults.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import Foundation

struct HighSchoolSATResults: Identifiable, Codable {
    let id: String
    let schoolName: String
    let satAvgMathScore: String
    let satReadingAvgScore: String
    let satWritingAvgScore: String
    let numberOfTestTakers: String
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case satAvgMathScore = "sat_math_avg_score"
        case satReadingAvgScore = "sat_critical_reading_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
        case numberOfTestTakers = "num_of_sat_test_takers"
    }
}

//
//  HighSchoolAdditionalInfoViewModel.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import Foundation

class HighSchoolAdditionalInfoViewModel: ObservableObject {
    
    func schoolHasResults (school: HighSchoolSATResults) -> Bool {
        guard !school.schoolName.isEmpty,
              !school.satAvgMathScore.isEmpty,
              !school.satReadingAvgScore.isEmpty,
              !school.satWritingAvgScore.isEmpty,
              school.satAvgMathScore.containsOnlyNumbers(),
              school.satReadingAvgScore.containsOnlyNumbers(),
              school.satWritingAvgScore.containsOnlyNumbers(),
              school.numberOfTestTakers.containsOnlyNumbers()
        else {
            return false
        }
        return true
    }
}

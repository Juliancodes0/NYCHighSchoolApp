//
//  HighSchoolAdditionalInfoView.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI
import Combine

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


struct HighSchoolAdditionalInfoView: View {
    @StateObject private var viewModel = HighSchoolAdditionalInfoViewModel()
    let highSchool: HighSchool
    let highSchoolResult: HighSchoolSATResults
    @State var showNoResults: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.customYellow.ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "xmark")
                        .bold()
                        .foregroundStyle(Color.black)
                    Spacer()
                }.padding(20)
                    .onTapGesture {
                    self.dismiss()
                }
                
                Text(highSchool.schoolName)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.black)
                    .padding(.all, 10)
                Spacer()
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.darkBlue)
                        .padding(.top)
                        .padding(2)
                        .frame(height: 500)
                
                        .overlay {
                            if showNoResults {
                                Text("No SAT results to display")
                                    .bold()
                                    .foregroundStyle(Color.white)
                            } else {
                                    VStack(alignment: .leading, spacing: 10) {
                                        
                                        Text("Average SAT Scores:")
                                            .font(.title)
                                            .padding(.bottom, 20)
                                        
                                        Text("Math Score:  \(highSchoolResult.satAvgMathScore)")
                                            
                                        Text("Writing Score:  \(highSchoolResult.satWritingAvgScore)")
                                        Text("Reading Score:  \(highSchoolResult.satReadingAvgScore)")
                                        Text("Number of test takers: \(highSchoolResult.numberOfTestTakers)")
                                    }.foregroundStyle(Color.white)
                                        .bold()
                                        .font(.title3)
                                
                            }
                        }.shadow(radius: 10)
                    Spacer()
                }
            
        }.preferredColorScheme(.light)
        .onAppear() {
            if !viewModel.schoolHasResults(school: highSchoolResult) {
                showNoResults = true
            }
        }
    }
}

#Preview {
    HighSchoolAdditionalInfoView(highSchool: HighSchool(id: "", schoolName: "NYC High School TEST NAME TEST TEST TEST TEST"), highSchoolResult: HighSchoolSATResults(id: "some id ", schoolName: "NYC High School", satAvgMathScore: "100", satReadingAvgScore: "200", satWritingAvgScore: "300", numberOfTestTakers: "1000"))
}

//
//  HighSchoolAdditionalInfoView.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI

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
                        .withBlackAndBoldText()
                    Spacer()
                }.padding(20)
                    .onTapGesture {
                    self.dismiss()
                }
                
                Text(highSchool.schoolName)
                    .withBlackAndBoldText()
                    .font(.title2)
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
                                schoolSatInfo
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

extension HighSchoolAdditionalInfoView {
   private var schoolSatInfo: some View {
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
}

#Preview {
    HighSchoolAdditionalInfoView(highSchool: HighSchool(id: "", schoolName: "NYC High School"), highSchoolResult: HighSchoolSATResults(id: "some id ", schoolName: "NYC High School", satAvgMathScore: "100", satReadingAvgScore: "200", satWritingAvgScore: "300", numberOfTestTakers: "1000"))
}

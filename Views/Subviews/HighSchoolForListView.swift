//
//  HighSchoolForListView.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI

struct HighSchoolForListView : View {
    let highSchool: HighSchool
    var viewModel: HighSchoolListViewModel
    @State private var goToDetailsView: Bool = false
    var body: some View {
        HStack {
            Button(action: {
                goToDetailsView = true
            }, label: {
                HStack {
                    Text(highSchool.schoolName)
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "note.text")
                        .padding(.leading)
                        .foregroundStyle(Color.blue, Color.customYellow)
                }
            })
        }.listRowBackground(Color.darkGray)
            .fullScreenCover(isPresented: $goToDetailsView, content: {
                HighSchoolAdditionalInfoView(highSchool: highSchool, highSchoolResult: viewModel.getResultForSchoolWithId(schoolId: highSchool.id, schoolName: highSchool.schoolName) ?? HighSchoolSATResults(id: "", schoolName: "", satAvgMathScore: "", satReadingAvgScore: "", satWritingAvgScore: "", numberOfTestTakers: ""))
            })
    }
}

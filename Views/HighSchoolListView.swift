//
//  HighSchoolListView.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI

struct HighSchoolListView: View {
    @StateObject private var viewModel: HighSchoolListViewModel = HighSchoolListViewModel()
    var body: some View {
        ZStack {
            Color.customYellow.edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading {
                VStack(spacing: 20) {
                    Text("Loading....")
                        .font(.footnote)
                        .foregroundStyle(Color.black)
                        .opacity(0.8)
                        .padding(15)
                    ProgressView()
                }
            } else {
                VStack {
                    Text("High Schools")
                        .font(.headline)
                        .padding(.bottom)
                        .withBlackAndBoldText()
                
                    textField

                    Spacer()
                    listOfHighschools
                }
            }
        }
        .preferredColorScheme(.light)
        .onAppear() {
            viewModel.getAllHighSchools()
            viewModel.getAllSATResults()
        }
    }
    
    var filteredHighSchoolResults: [HighSchool] {
        guard !viewModel.searchText.isEmpty else {
            return viewModel.highSchools
        }

        return viewModel.highSchools.filter { highSchoolResult in
            highSchoolResult.schoolName.lowercased().contains(viewModel.searchText.lowercased())
        }
    }

}

extension HighSchoolListView {
    private var listOfHighschools: some View {
        List {
            ForEach(filteredHighSchoolResults.sorted(by: {$0.schoolName < $1.schoolName}), id: \.id) { highSchool in
                HighSchoolForListView(highSchool: highSchool, viewModel: viewModel)
                    
            }
            .listRowSpacing(10)
        }.listStyle(.plain)
            .frame(width: UIScreen.main.bounds.width / 1.05)
            .cornerRadius(15.0)
    }
    
    private var textField: some View {
        TextField("", text: $viewModel.searchText)
            .placeholder(ifTrue: viewModel.searchText.isEmpty, placeholder: {
                Text("Search...")
                    .foregroundStyle(Color.gray)
            })
            .frame(width: 300, height: 5)
            .padding()
            .foregroundColor(.black)
            .background() {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.customGray)
                    .opacity(0.8)
            }.shadow(radius: 5)
    }
}

#Preview {
    HighSchoolListView()
}

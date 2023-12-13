//
//  HighSchoolListView.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI
import Combine

class HighSchoolListViewModel: ObservableObject {
    @Published var highSchools: [HighSchool] = []
    @Published var highSchoolSATResults: [HighSchoolSATResults] = []
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var isLoading: Bool = true
    
    func getAllHighSchools() {
        let urlString = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
            isLoading = true
        NetworkManager.shared.request(urlString: urlString) { [weak self] (result: Result<[HighSchool], Error>) in
            self?.isLoading = false
            switch result {
            case .success(let highSchools):
                self?.highSchools = highSchools
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllSATResults () {
        let urlString = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        NetworkManager.shared.request(urlString: urlString) { (result:
            Result<[HighSchoolSATResults], Error>) in
            switch result {
            case .success(let results):
                self.highSchoolSATResults = results
            case .failure(let error):
                print("Error with sat results: \(error.localizedDescription)")
            }
        }
    }
    
    func getResultForSchoolWithId (schoolId: String, schoolName: String) -> HighSchoolSATResults? {
        for result in self.highSchoolSATResults {
            if result.id == schoolId {
                return result
            }
        }
        return nil
    }
}

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
                        .bold()
                        .padding(.bottom)
                    
                    TextField("Search...", text: $viewModel.searchText)
                        .frame(width: 300, height: 10)
                        .padding()
                        .foregroundColor(.black)
                        .background() {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.white)
                        }
                    
                    Spacer()
                    listOfHighschools
                }
            }
        }.preferredColorScheme(.light)
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
    var listOfHighschools: some View {
        List {
            ForEach(filteredHighSchoolResults.sorted(by: {$0.schoolName < $1.schoolName}), id: \.id) { highSchool in
                HighSchoolInList(highSchool: highSchool, viewModel: viewModel)
            }
            .listRowSpacing(10)
        }.listStyle(.plain)
            .frame(width: UIScreen.main.bounds.width / 1.05)
            .cornerRadius(15.0)
    }
}

struct HighSchoolInList : View {
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

#Preview {
    HighSchoolListView()
}

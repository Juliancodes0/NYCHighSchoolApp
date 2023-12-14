//
//  HighSchoolListViewModel.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

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

//
//  NetworkingManager.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
    case badServerResponse
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

    private init() {}

      func requestAPIData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badURL))
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw NetworkError.badServerResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { completionSink in
                switch completionSink {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } receiveValue: { result in
                completion(.success(result))
            }
            .store(in: &cancellables)
    }
}

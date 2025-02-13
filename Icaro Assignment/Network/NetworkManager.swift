//
//  NetworkManager.swift
//  Icaro Assignment
//
//  Created by Jai Nijhawan on 12/02/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}

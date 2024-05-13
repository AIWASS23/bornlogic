//
//  Service.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import UIKit

class Service: NSObject {

    static let shared = Service()

    private override init() {}

    func request<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {

        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=36d53d85712e4fa78dcd574cad932d2d")!

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }

        }.resume()
    }
}


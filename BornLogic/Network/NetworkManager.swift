//
//  NetworkManager.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//


import Foundation

class NetworkManager { // final

    static var shared = NetworkManager()
    var onCompletionData: ((Response) -> Void)?

    init() {}


    public func getMyTopStories() {
        getURL(string: Constants.topHeadlinesString)
    }

    public func getMyTopStories(byPage: String) {
        getURL(string: Constants.topHeadlinesByPageString + byPage)
    }

    public func getMyUaSportsStories() {
        getURL(string: Constants.sportsString)
    }

    public func getMyUaSportsStories(byPage: String) {
        getURL(string: Constants.sportsByPageString + byPage)
    }

    public func getMyCategoryStories(by category: String) {
        getURL(string: Constants.topHeadlinesByCategoryString + category)
    }

    public func getMyCategoryStories(by category: String, andPage: String) {
        getURL(string: Constants.topHeadlinesByCategoryString + category + "&page=" + andPage)
    }

    public func searchURL(with query: String) {
        getURL(string: Constants.searchURLString + query)
    }

    func getURL(string: String) {
        guard let url = URL(string: string) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentData = self.parseJSON(withData: data) {
                    self.onCompletionData?(currentData)
                }
            }
        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> Response? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Response.self, from: data)
            return decodedData
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

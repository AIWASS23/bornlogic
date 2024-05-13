//
//  APIServiceMockData.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

final class APIServiceMockData: APIDataService {
    private let forceFetchFailure: Bool

    init(forceFetchFailure: Bool) {
        self.forceFetchFailure = forceFetchFailure
    }

    private func getFilePath(name: String) -> URL? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }

        return URL(fileURLWithPath: path)
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        if let object = try? JSONDecoder().decode(type, from: data) {
            return object
        }

        return nil
    }


    private func getArticles(with fileName: String) -> Result<[Article], APIError> {
        guard let fileURL = getFilePath(name: fileName) else {
            return .failure(.invalidURL)
        }

        let output: ArticleOutput?

        do {
            let data = try Data(contentsOf: fileURL)

            output = decode(ArticleOutput.self, from: data)

            if let articles = output?.articles {
                return .success(articles)
            } else {
                print("Data decoding has failed.")
                return .failure(.decodeError)
            }
        } catch {
            print("An error has occured: \(error)")
            return .failure(.apiError)
        }
    }

    func fetchTopHeadlinesNews(countryCode: String = "", category: String? = nil) async -> Result<[Article], APIError> {
        if let category {
            switch category {
                case "business":
                    return getArticles(with: "BusinessTopHeadlinesMockData")
                case "entertainment":
                    return getArticles(with: "EntertainmentTopHeadlinesMockData")
                case "general":
                    return getArticles(with: "GeneralTopHeadlinesMockData")
                case "science":
                    return getArticles(with: "ScienceTopHeadlinesMockData")
                case "health":
                    return getArticles(with: "HealthTopHeadlinesMockData")
                case "sports":
                    return getArticles(with: "SportsTopHeadlinesMockData")
                case "technology":
                    return getArticles(with: "TechnologyTopHeadlinesMockData")
                default:
                    return .failure(.invalidURL)
            }
        }

        return (countryCode == "fr" || countryCode == "us") ? getArticles(with: "FrenchTopHeadlinesMockData") : .failure(.invalidURL)
    }

    func fetchTopHeadlinesNews(sourceName: String) async -> Result<[Article], APIError> {
        return sourceName == "le-monde" ? getArticles(with: "SourcesTopHeadlinesMockData") : .failure(.invalidURL)
    }

    func searchNewsFromEverything(with searchQuery: String, language: String = "fr", sortBy: String = "publishedAt") async -> Result<[Article], APIError> {

        guard searchQuery == "iPhone" else {
            return .failure(.apiError)
        }

        return getArticles(with: "")
    }
}

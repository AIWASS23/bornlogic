//
//  APIServiceNetwork.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

final class APIServiceNetwork: APIDataService {
    internal var apiKey = ""
    internal var cacheKey = ""
    internal var articleCache = File<[Article]>(fileName: "article_cache_data", expirationInterval: 21600)

    fileprivate func getApiKey() -> String? {
        guard let path = Bundle.main.path(forResource: "apiKey", ofType: "plist") else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }

        return dictionary.object(forKey: "apiKey") as? String
    }

    private func getAuthorizationHeader() -> [String: String] {
        return ["Authorization": "Bearer \(apiKey)"]
    }


    init() {
        self.apiKey = getApiKey() ?? ""
        print(apiKey)

        Task(priority: .userInitiated) {
            print("Initializing file caches")
            await articleCache.loadFromDisk()
        }
    }

    func fetchTopHeadlinesNews(countryCode: String, category: String? = nil) async -> Result<[Article], APIError> {
        return await fetchArticleData(endpoint: .fetchTopHeadlinesNews(countryCode: countryCode, category: category))
    }

    func fetchTopHeadlinesNews(sourceName: String) async -> Result<[Article], APIError> {
        return await fetchArticleData(endpoint: .fetchTopHeadlinesNewsWithSource(name: sourceName))
    }

    func searchNewsFromEverything(with searchQuery: String, language: String = "fr", sortBy: String = "publishedAt") async -> Result<[Article], APIError> {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return await fetchArticleData(endpoint: .searchNewsFromEverything(searchQuery: encodedQuery, language: language, sortBy: sortBy))
    }

    private func fetchArticleData(endpoint: APIEndpoint) async -> Result<[Article], APIError> {
        cacheKey = endpoint.path
        print(cacheKey)

        if let articles = await articleCache.value(key: cacheKey) {
            return .success(articles)
        }

        return await handleArticlesResult(with: await getRequest(endpoint: endpoint))
    }


    private func handleArticlesResult(with result: Result<ArticleOutput, APIError>) async -> Result<[Article], APIError> {
        switch result {
            case .success(let data):
                await articleCache.setValue(data.articles ?? [], key: cacheKey)
                await articleCache.saveToDisk()

                return .success(data.articles ?? [])
            case .failure(let error):
                return .failure(error)
        }
    }

    private func getRequest<T: Decodable>(endpoint: APIEndpoint) async -> Result<T, APIError> {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = getAuthorizationHeader()

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.networkError)
        }
    }
}

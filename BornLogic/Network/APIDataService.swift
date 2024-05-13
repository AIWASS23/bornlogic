//
//  File.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

protocol APIDataService {
    func fetchTopHeadlinesNews(countryCode: String, category: String?) async -> Result<[Article], APIError>
    func fetchTopHeadlinesNews(sourceName: String) async -> Result<[Article], APIError>
    func searchNewsFromEverything(with searchQuery: String, language: String, sortBy: String) async -> Result<[Article], APIError>
}

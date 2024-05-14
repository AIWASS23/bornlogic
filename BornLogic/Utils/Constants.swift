//
//  Constants.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

struct Secret {
    static let apiKey: String = "36d53d85712e4fa78dcd574cad932d2d"
}

struct Constants {
    static let baseURL = "https://newsapi.org/v2"
    static let topHeadlinesString = "\(Constants.baseURL)/top-headlines?country=us&apiKey=\(Secret.apiKey)"
    static let topHeadlinesByPageString = "\(Constants.baseURL)/top-headlines?country=us&apiKey=\(Secret.apiKey)&page="
    static let topHeadlinesByCategoryString = "\(Constants.baseURL)/top-headlines?country=us&apiKey=\(Secret.apiKey)&category="
    static let sportsString = "\(Constants.baseURL)/top-headlines?country=us&category=sports&apiKey=\(Secret.apiKey)"
    static let sportsByPageString = "\(Constants.baseURL)/top-headlines?country=us&category=sports&apiKey=\(Secret.apiKey)&page="
    static let searchURLString =  "\(Constants.baseURL)/everything?sortBy=popularity&apiKey=\(Secret.apiKey)&q="
}

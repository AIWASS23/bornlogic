//
//  NewsAPIError.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

enum APIError: String, Error {
    case parametersMissing = "parametersMissing"
    case invalidApiKey = "invalidApiKey"
    case notFound = "notFound"
    case tooManyRequests = "tooManyRequests"
    case serverError = "serverError"
    case apiError = "apiError"
    case invalidURL = "invalidURL"
    case networkError = "networkError"
    case decodeError = "decodeDownloadError"
    case downloadError = "downloadError"
    case unknown = "unknownError"
}

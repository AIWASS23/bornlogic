//
//  Article.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

enum Section {
    case main
}

struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Hashable, Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    let uuid = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

struct Source: Codable {
    let name: String
}

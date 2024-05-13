//
//  ArticleViewModel.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import UIKit

class ArticleViewModel: NSObject {

    var articles: [Article]
    init(articles: [Article] = []) {
        self.articles = articles
    }

    func getArticles(completion: @escaping (Result<Response, Error>) -> Void) {
        Service.shared.request() { (result: Result<Response, Error>) in
            switch result {
            case .success(let head):
                self.articles = head.articles!
                completion(.success(head))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

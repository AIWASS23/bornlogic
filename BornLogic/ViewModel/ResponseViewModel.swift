//
//  ResponseViewModel.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//


import Foundation

protocol ResponseViewModelDelegate: AnyObject {
    func loadArticles(_ articles: [Article])
}

class ResponseViewModel: NSObject {

    private var articles = [Article]()
    var totalApiResults: Int = 0
    var currentPage: Int = 1

    weak var delegate: ResponseViewModelDelegate?


    func fetchArticlesWithDelegate() {
        NetworkManager.shared.onCompletionData = { [weak self] result in
            guard let self = self else { return }
            self.articles = result.articles
            self.totalApiResults = result.totalResults

            delegate?.loadArticles(self.articles)
        }
    }

    func addArticlesWithDelegate() {
        NetworkManager.shared.onCompletionData = { [weak self] result in
            guard let self = self else { return }
            self.articles.append(contentsOf: result.articles)

            delegate?.loadArticles(self.articles)
        }
    }

    func loadNextPage(by category: String) {
        if currentPage > 0 {
            guard articles.count < totalApiResults else { return }

            currentPage += 1
            print("LAST PAGE!!!")

            addArticlesWithDelegate()
            getMyCategoryStories(by: category)
        }
    }

    func getMyCategoryStories(by category: String) {
        NetworkManager.shared.getMyCategoryStories(by: category, andPage: String(currentPage))
    }

    func searchURL(with text: String) {
        NetworkManager.shared.searchURL(with: text)
    }
}

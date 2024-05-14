//
//  ArticleView.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import UIKit
import SafariServices

protocol ArticleViewControllerDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class ArticleView: UITableView {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        return table
    }()

    private var articles = [Article]() {
        didSet {
            createSnapshot()
        }
    }

    var delegate: ArticleViewControllerDelegate?
    private let viewModel = ResponseViewModel()

    var dataSource: UITableViewDiffableDataSource<Section, Article>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Article>! = nil

    var category: String? = nil

    func updateArticles(_ articles: [Article]) {
        self.articles = articles
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }

    func createDataSource() {
        dataSource = UITableViewDiffableDataSource(
            tableView: tableView, cellProvider: { tableView, indexPath, article in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ArticleTableViewCell.identifier,
                    for: indexPath
                ) as? ArticleTableViewCell else { fatalError() }

            cell.configure(with: self.articles[indexPath.row])

            return cell
        })

        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }

    private func createSnapshot() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(articles)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

extension ArticleView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        delegate?.didSelectArticle(article)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 1 {
            viewModel.loadNextPage(by: category ?? "General")
        }
    }
}

extension ArticleView: ResponseViewModelDelegate {
    func loadArticles(_ articles: [Article]) {
        self.articles = articles
        DispatchQueue.main.async {
            self.createSnapshot()
        }
    }
}

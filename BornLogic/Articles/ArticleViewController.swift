//
//  ViewController.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import UIKit
import SafariServices

class ArticleViewController: UIViewController, UITableViewDelegate {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        return table
    }()

    private let viewModel = ResponseViewModel()
    private var articles = [Article]()

    var dataSource: UITableViewDiffableDataSource<Section, Article>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Article>! = nil

    private let searchVC = UISearchController(searchResultsController: nil)

    var category: String? = nil
    let titleName: String = "Top News"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        tableView.delegate = self
        viewModel.delegate = self

        fetchMyCategoryStories()
        createDataSource()
        createSnapshot()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func createDataSource() {
        dataSource = UITableViewDiffableDataSource(
            tableView: tableView, cellProvider: {tableView, indexPath, article in
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

    func createSnapshot() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(articles)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }

    private func fetchMyCategoryStories() {
        viewModel.fetchArticlesWithDelegate()
        viewModel.getMyCategoryStories(by: category ?? "General")
    }
}


extension ArticleViewController {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "https://picsum.photos/200/300") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
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

extension ArticleViewController: ResponseViewModelDelegate {
    func loadArticles(_ articles: [Article]) {
        self.articles = articles
        DispatchQueue.main.async {
            self.createSnapshot()
        }
    }
}

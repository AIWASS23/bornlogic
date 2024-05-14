//
//  MenuViewController.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import UIKit

class MenuViewController: UIViewController {

    let categoryMenu = ["General", "Business", "Science", "Technology", "Health", "Entertainment", "Sports"]
    var menuCollectionView: UICollectionView!
    var search = UISearchController(searchResultsController: nil)

    var category: String? = nil
    let titleName: String = "BornLogic"

    private let viewModel = ResponseViewModel()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        createSearchBar()
        configureNavigationBar()
    }


    func configureCollectionView() {
        let menuLayout = MenuFlowLayout()

        menuCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: menuLayout)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
        )
        menuCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(menuCollectionView)
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = titleName
    }

    private func createSearchBar() {
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Pesquisa"
    }

    private func fetchMyCategoryStories() {
        viewModel.fetchArticlesWithDelegate()
        viewModel.getMyCategoryStories(by: category ?? "General")
    }
}

extension MenuViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.identifier,
            for: indexPath) as! MenuCollectionViewCell

        let categoryName = categoryMenu[indexPath.row]
        cell.configureBy(category: categoryName)
        return cell
    }
}

extension MenuViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryMenu[indexPath.row]
        print("Category \(selectedCategory) is selected")

        let article = ArticleViewController()
        article.category = self.categoryMenu[indexPath.row]

        self.navigationController?.pushViewController(article, animated: true)
    }
}

extension MenuViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty else {
            return
        }

        guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        viewModel.fetchArticlesWithDelegate()
        let articleSearch = ArticleViewController()
        articleSearch.category = encodedSearchText
        navigationController?.pushViewController(articleSearch, animated: true)
        searchBar.text = nil

        viewModel.searchURL(with: encodedSearchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.currentPage = 1
        fetchMyCategoryStories()

    }
}


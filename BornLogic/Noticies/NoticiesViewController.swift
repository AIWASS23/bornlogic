//
//  NoticiesViewController.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 15/05/24.
//

import UIKit
import SafariServices

class NoticieslViewController: UIViewController {

    var article: Article?
    var screen: NoticiesView?

    override func loadView() {
        self.screen = NoticiesView()
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Noticia"

        configureContent()
    }

    func configureContent() {
        guard let article = article else { return }
        screen?.titleLabel.text = article.title

        if let formattedDate = DateUtil.convert(input: article.publishedAt, inputFormat: .format4, outputFormat: .format6) {
            screen?.dateLabel.text = formattedDate
        } else {
            screen?.dateLabel.text = "Data não disponível"
        }

        if let urlString = article.urlToImage {
            screen?.articleImageView.download(from: urlString, contentMode: .scaleAspectFill)
        } else {
            let placeholderImage = UIImage(systemName: "photo")
            screen?.articleImageView.image = placeholderImage
        }

        screen?.contentTextView.text = article.content
    }
}

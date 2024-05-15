//
//  ArticleViewCell.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 14/05/24.
//
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    static let identifier = "ArticleTableViewCell"

    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    internal lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()


    internal lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    internal lazy var articleImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(articleImageView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 10
        let imageSize: CGFloat = 140
        let contentWidth = contentView.frame.size.width
        let contentHeight = contentView.frame.size.height

        titleLabel.frame = CGRect(
            x: padding,
            y: 0,
            width: contentWidth - imageSize - 3 * padding,
            height: contentHeight / 3
        )

        descriptionLabel.frame = CGRect(
            x: padding,
            y: titleLabel.frame.maxY + padding - 5,
            width: contentWidth - imageSize - 3 * padding,
            height: contentHeight / 3
        )

        authorLabel.frame = CGRect(
            x: padding,
            y: descriptionLabel.frame.maxY + padding,
            width: contentWidth - imageSize - 3 * padding,
            height: contentHeight / 3
        )

        articleImageView.frame = CGRect(
            x: contentWidth - imageSize - padding,
            y: padding,
            width: imageSize,
            height: contentHeight - 2 * padding
        )
    }


    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        authorLabel.text = nil
        articleImageView.image = nil
    }

    func configure(with article: Article) {
        titleLabel.text = article.title.isEmpty ? "No title" : article.title
        descriptionLabel.text = (article.description?.isEmpty == false) ? article.description : "No description"
        authorLabel.text = (article.author?.isEmpty ?? true) ? "No author" : article.author

        if let urlString = article.urlToImage {
            articleImageView.download(from: urlString, contentMode: .scaleAspectFill)
        } else {
            let placeholderImage = UIImage(systemName: "photo")
            articleImageView.image = placeholderImage
        }
    }
}

//
//  MenuCollectionViewCell.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 14/05/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    static let identifier = "menuCell"

    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(nameLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true

        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureBy(category: String) {
        switch category {
        case Menu.general:
            self.backgroundColor = UIColor.purple
        case Menu.business:
            self.backgroundColor = UIColor.green
        case Menu.science:
            self.backgroundColor = UIColor.orange
        case Menu.technology:
            self.backgroundColor = UIColor.blue
        case Menu.health:
            self.backgroundColor = UIColor.red
        case Menu.entertainment:
            self.backgroundColor = UIColor.yellow
        case Menu.sports:
            self.backgroundColor = UIColor.gray
        default:
            self.backgroundColor = UIColor.brown
        }

        self.nameLabel.text = category
        self.nameLabel.textColor = .black
    }

}

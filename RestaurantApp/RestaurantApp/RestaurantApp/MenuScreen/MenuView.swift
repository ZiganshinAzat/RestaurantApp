//
//  MenuView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 29.04.2024.
//

import UIKit

class MenuView: UIView {

    lazy var menuLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Меню"

        return label
    }()
    
    lazy var menuTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)
        tableView.separatorStyle = .none

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView {
    func setupLayout() {
        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(menuLabel)
        addSubview(menuTableView)

        NSLayoutConstraint.activate([
            menuLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            menuLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            menuTableView.topAnchor.constraint(equalTo: menuLabel.bottomAnchor, constant: 5),
            menuTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

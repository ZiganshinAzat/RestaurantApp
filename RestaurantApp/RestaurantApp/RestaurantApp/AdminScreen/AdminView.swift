//
//  AdminView.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit

class AdminView: UIView {

    lazy var ordersTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AdminTableViewCell.self, forCellReuseIdentifier: AdminTableViewCell.reuseIdentifier)
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

extension AdminView {

    func setupLayout() {
        backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        addSubview(ordersTableView)

        NSLayoutConstraint.activate([
            ordersTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            ordersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ordersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ordersTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

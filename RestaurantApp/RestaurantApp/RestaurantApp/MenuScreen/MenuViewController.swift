//
//  MenuViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 28.04.2024.
//

import UIKit
import Kingfisher
import Combine

class MenuViewController: UIViewController {

    private var menuViewModel: MenuViewModel
    private var menuView = MenuView()
    private var cancellables: Set<AnyCancellable> = []
    private var dishesByCategory: [String: [Dish]] = [:]
    private var categories: [String] = []
    private var dishQuantities: [Int: Int] = [:]

    init(menuViewModel: MenuViewModel) {
        self.menuViewModel = menuViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = menuView
        menuView.menuTableView.dataSource = self
        menuView.menuTableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        Task {
            await menuViewModel.getMenuDishes()
        }
    }

    func getDishesByCategory(_ dishes: [Dish]) -> [String: [Dish]] {
        var dishesByCategory: [String: [Dish]] = [:]

        for dish in dishes {
            if dishesByCategory[dish.category] == nil {
                dishesByCategory[dish.category] = [dish]
            } else {
                dishesByCategory[dish.category]?.append(dish)
            }
        }

        return dishesByCategory
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    func addToOrder(dish: Dish, indexPath: IndexPath) {
        let userId = UserDefaultsManager.loadUserId()
        if userId == 0 {
            showAuthorizationRequiredAlert()
        } else {
            let orderItem = OrderItem(id: 0, quantity: 0, userId: userId, dishId: dish.id, dish: dish)
            Task {
                let quantity = await menuViewModel.addOrderItem(orderItem: orderItem)
                dishQuantities[dish.id] = quantity
                DispatchQueue.main.async {
                    if let cell = self.menuView.menuTableView.cellForRow(at: indexPath) as? MenuTableViewCell {
                        cell.updateQuantityLabel(with: quantity)
                    }
                }
            }
        }
    }

    func removeFromOrder(dish: Dish, indexPath: IndexPath) {
        let userId = UserDefaultsManager.loadUserId()
        if userId == 0 {
            showAuthorizationRequiredAlert()
        } else {
            let orderItem = OrderItem(id: 0, quantity: 0, userId: userId, dishId: dish.id, dish: dish)
            Task {
                let quantity = await menuViewModel.removeOrderItem(orderItem: orderItem)
                dishQuantities[dish.id] = quantity
                DispatchQueue.main.async {
                    if let cell = self.menuView.menuTableView.cellForRow(at: indexPath) as? MenuTableViewCell {
                        cell.updateQuantityLabel(with: quantity)
                    }
                }
            }
        }
    }

    func setupBindings() {
        menuViewModel.$menuDishes
            .sink { [weak self] dishes in
                guard let self else { return }
                dishesByCategory = getDishesByCategory(dishes)
                categories = Array(dishesByCategory.keys)
                DispatchQueue.main.async {
                    self.menuView.menuTableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        return dishesByCategory[category]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 246/255.0, green: 234/255.0, blue: 190/255.0, alpha: 1.0)

        let headerLabel = UILabel(frame: CGRect(x: 15, y: -10, width: tableView.bounds.size.width - 30, height: 44))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.textColor = UIColor.black
        headerLabel.text = categories[section]
        headerLabel.backgroundColor = UIColor.clear

        headerView.addSubview(headerLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuTableViewCell.reuseIdentifier,
            for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        let category = categories[indexPath.section]
        let dish = (dishesByCategory[category]?[indexPath.row])!
        cell.configureCell(with: dish)
        let quantity = dishQuantities[dish.id] ?? 0
        cell.updateQuantityLabel(with: quantity)
        cell.addToOrderButtonAction = {
            self.addToOrder(dish: dish, indexPath: indexPath)
        }
        cell.removeFromOrderButtonAction = {
            self.removeFromOrder(dish: dish, indexPath: indexPath)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var backgroundConfig = cell.defaultBackgroundConfiguration()
        backgroundConfig.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 220/255.0, alpha: 1.0)
        backgroundConfig.cornerRadius = 20
        backgroundConfig.backgroundInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)

        cell.backgroundConfiguration = backgroundConfig

        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.2

        let shadowPath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 10, dy: 5), cornerRadius: backgroundConfig.cornerRadius)
        cell.layer.shadowPath = shadowPath.cgPath
    }

    func showAuthorizationRequiredAlert() {
        let alert = UIAlertController(title: "Требуется авторизация", message: "Для доступа к этой функции необходимо войти в систему. Пожалуйста, авторизуйтесь.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))
        present(alert, animated: true, completion: nil)
    }
}

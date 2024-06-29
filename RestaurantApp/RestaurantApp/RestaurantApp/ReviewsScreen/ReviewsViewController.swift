//
//  ReviewsViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit
import Combine

class ReviewsViewController: UIViewController {

    private let reviewsViewModel: ReviewsViewModel
    private let reviewsView = ReviewsView()
    private var reviewsDataSource: [Review] = []
    private var cancellables: Set<AnyCancellable> = []

    init(reviewsViewModel: ReviewsViewModel) {
        self.reviewsViewModel = reviewsViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = reviewsView
        reviewsView.addReviewButtonAction = navigateToAddingReview
        reviewsView.reviewsTableView.dataSource = self
        reviewsView.reviewsTableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        Task {
            await reviewsViewModel.getReviews()
        }
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {

    func setupBindings() {
        reviewsViewModel.$reviews
            .sink { [weak self] reviews in
                guard let self else { return }

                self.reviewsDataSource = reviews
                DispatchQueue.main.async {
                    self.reviewsView.reviewsTableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviewsDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewsTableViewCell.reuseIdentifier,
            for: indexPath) as? ReviewsTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        let review = reviewsDataSource[indexPath.row]
        cell.configureCell(with: review)

        return cell
    }

    func navigateToAddingReview() {
        let userId = UserDefaultsManager.loadUserId()
        if userId == 0 {
            showAuthorizationRequiredAlert()
        } else {
            Task {
                let addReviewViewModel = AddReviewViewModel(restaurantAPIManager: FoodiesAPIManager())
                self.navigationController?.pushViewController(AddReviewViewController(addReviewViewModel: addReviewViewModel), animated: true)
            }
        }
    }

    func showAuthorizationRequiredAlert() {
        let alert = UIAlertController(title: "Требуется авторизация", message: "Для доступа к этой функции необходимо войти в систему. Пожалуйста, авторизуйтесь.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))
        present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
}

//
//  AddReviewViewController.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 07.05.2024.
//

import UIKit

class AddReviewViewController: UIViewController {

    private let addReviewViewModel: AddReviewViewModel
    private let addReviewView = AddReviewView()

    init(addReviewViewModel: AddReviewViewModel) {
        self.addReviewViewModel = addReviewViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = addReviewView
        addReviewView.submitReviewButtonAction = addReview
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Добавление отзыва"
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen

    }
}

extension AddReviewViewController {

    func addReview(review: Review) {
        Task {
            do {
                try await addReviewViewModel.addReview(review: review)
                self.navigationController?.popViewController(animated: true)
            } catch {
                DispatchQueue.main.async {
                    self.showReviewRequirementAlert()
                }
            }
        }
    }

    func showReviewRequirementAlert() {
        let alert = UIAlertController(title: "Отзыв недоступен", message: "Для оставления отзыва необходимо иметь как минимум один выполненный заказ. Пожалуйста, сделайте заказ и воспользуйтесь нашими услугами, чтобы оценить их качество.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

        }))
        present(alert, animated: true, completion: nil)
    }
}

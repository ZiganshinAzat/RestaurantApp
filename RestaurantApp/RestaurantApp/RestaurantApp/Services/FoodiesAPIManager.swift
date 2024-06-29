//
//  FoodiesAPIManager.swift
//  RestaurantApp
//
//  Created by Азат Зиганшин on 30.04.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

actor FoodiesAPIManager: RestaurantAPIManager {

    func registerUser(user: User) async throws -> User? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let userData = try encoder.encode(user)

        let url = URL(string: "http://localhost:5277/users/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let updatedUser):
                    print("Success: User added with ID: \(updatedUser.id)")
                    continuation.resume(returning: updatedUser)
                case .failure(let error):
                    print("Error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func loginUser(user: User) async throws -> User? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let userData = try encoder.encode(user)

        let url = URL(string: "http://localhost:5277/users/signin")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let updatedUser):
                    print("Success: User logged in with ID: \(updatedUser.id)")
                    continuation.resume(returning: updatedUser)
                case .failure(let error):
                    print("Error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getAllDishes() async throws -> [Dish] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "http://localhost:5277/dishes/getalldishes"
            ).responseDecodable(of: [Dish].self) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func addReservation(reservation: Reservation) async throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let reservationData = try encoder.encode(reservation)

        let url = URL(string: "http://localhost:5277/reservations/addReservation")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = reservationData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).response { response in
                switch response.result {
                case .success(_):
                    print("Success: Reservation added.")
                    continuation.resume()
                case let .failure(error):
                    print("Error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func addOrderItem(orderItem: OrderItem) async throws -> Int {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let orderItemData = try encoder.encode(orderItem)

        let url = URL(string: "http://localhost:5277/Order/addOrderItem")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = orderItemData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let json = try JSON(data: data)
                        if let quantity = json["quantity"].int {
                            continuation.resume(returning: quantity)
                        } else {
                            print("Error: 'Quantity' not found")
                            continuation.resume(throwing: NSError(domain: "JSONError", code: 1, userInfo: [NSLocalizedDescriptionKey: "'Quantity' not found in JSON"]))
                        }
                    } catch {
                        print("JSON parsing error: \(error)")
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    print("Error during request: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func removeOrderItem(orderItem: OrderItem) async throws -> Int {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let orderItemData = try encoder.encode(orderItem)

        let url = URL(string: "http://localhost:5277/Order/removeOrderItem")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = orderItemData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let json = try JSON(data: data)
                        if let quantity = json["quantity"].int {
                            continuation.resume(returning: quantity)
                        } else {
                            print("Error: 'Quantity' not found")
                            continuation.resume(throwing: NSError(domain: "JSONError", code: 1, userInfo: [NSLocalizedDescriptionKey: "'Quantity' not found in JSON"]))
                        }
                    } catch {
                        print("JSON parsing error: \(error)")
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    print("Error during request: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getOrderItemsByUserId(userId: Int) async throws -> [OrderItem] {
        let url = URL(string: "http://localhost:5277/Order/GetOrderItemsByUser/\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseDecodable(of: [OrderItem].self) { response in
                switch response.result {
                case .success(let orderItems):
                    print("Success: Retrieved order items for user ID: \(userId)")
                    continuation.resume(returning: orderItems)
                case .failure(let error):
                    print("Error while fetching order items: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func addOrder(order: Order) async throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let orderData = try encoder.encode(order)

        let url = URL(string: "http://localhost:5277/Order/addOrder")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = orderData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).response { response in
                switch response.result {
                case .success(_):
                    print("Success: Order added")
                    continuation.resume()
                case .failure(let error):
                    print("Error while adding order: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getActiveOrders() async throws -> [Order] {
        let url = URL(string: "http://localhost:5277/Order/getActiveOrders")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseDecodable(of: [Order].self) { response in
                switch response.result {
                case .success(let orders):
                    print("Success: Retrieved active orders")
                    continuation.resume(returning: orders)
                case .failure(let error):
                    print("Error while fetching active orders: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func advanceOrderStatus(orderId: Int) async throws {
        let url = URL(string: "http://localhost:5277/Order/advanceOrderStatus/\(orderId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).response { response in
                switch response.result {
                case .success(_):
                    print("Success: Order status advanced for order ID: \(orderId)")
                    continuation.resume()
                case .failure(let error):
                    print("Error while advancing order status: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func cancelOrder(orderId: Int) async throws {
        let url = URL(string: "http://localhost:5277/Order/cancelOrder/\(orderId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).response { response in
                switch response.result {
                case .success(_):
                    print("Success: Order with ID \(orderId) has been cancelled")
                    continuation.resume()
                case .failure(let error):
                    print("Error while cancelling order: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func addReview(review: Review) async throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let reviewData = try encoder.encode(review)

        let url = URL(string: "http://localhost:5277/Reviews/addReview")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = reviewData

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).response { response in
                switch response.result {
                case .success(_):
                    print("Success: Review added.")
                    continuation.resume()
                case .failure(let error):
                    print("Error while adding review: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getAllReviews() async throws -> [Review] {
        let url = URL(string: "http://localhost:5277/Reviews/getAllReviews")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(request).responseDecodable(of: [Review].self) { response in
                switch response.result {
                case .success(let reviews):
                    print("Success: Retrieved all reviews")
                    continuation.resume(returning: reviews)
                case .failure(let error):
                    print("Error while fetching reviews: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

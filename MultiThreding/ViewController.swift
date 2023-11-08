//
//  ViewController.swift
//  MultithreadingTask
//
//  Created by Anna Sumire on 08.11.23.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.start()
    }
    
    // MARK: - Helper Methods
    
    private func generateRandomNumber() -> Int {
        return Int.random(in: 20...50)
    }

    private func factorial(of n: Int) -> Decimal {
        return n == 0 ? 1 : Decimal(n) * factorial(of: n - 1)
    }

    // MARK: - Main Function
    
    private func start() {
        let num1 = generateRandomNumber()
        let num2 = generateRandomNumber()

        let group = DispatchGroup()

        var winner: String?

        group.enter()
        DispatchQueue.global().async {
            let result = self.factorial(of: num1)
            print("Thread 1: --- Factorial of \(num1) is \(result)")
            if winner == nil {
                winner = "Thread 1"
            }
            group.leave()
        }

        group.enter()
        DispatchQueue.global().async {
            let result = self.factorial(of: num2)
            print("Thread 2: --- Factorial of \(num2) is \(result)")
            if winner == nil {
                winner = "Thread 2"
            }
            group.leave()
        }

        group.wait()
        print("🧮Calculations are complete✅. The winner is 🥇\(winner!)🥇.")
    }
}

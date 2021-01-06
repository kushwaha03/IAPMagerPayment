import UIKit
import StoreKit


class KKIAPManager: NSObject {


static let shared = KKIAPManager()
private override init() {
 super.init()
 }
    SKPaymentQueue.default().add(self)

}

// MARK: - SKProductsRequestDelegate

extension KKIAPManager: SKProductsRequestDelegate {

}

// MARK: - SKPaymentTransactionObserver

extension KKIAPManager: SKPaymentTransactionObserver {

public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch (transaction.transactionState) {
      case .purchased:
            SKPaymentQueue.default().finishTransaction(transaction)

        break
      case .failed:
            SKPaymentQueue.default().finishTransaction(transaction)

        break
      case .restored:
            SKPaymentQueue.default().finishTransaction(transaction)

        break
      case .deferred:
        break
      case .purchasing:
        break
      }
    }

}

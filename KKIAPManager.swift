import UIKit
import StoreKit


class KKIAPManager: NSObject {


static let shared = KKIAPManager()
private override init() {
 super.init()
 }
    SKPaymentQueue.default().add(self)

}
    fileprivate var productsRequest = SKProductsRequest()

    var iapProducts = [SKProduct]()
    let CONSUMABLE_PURCHASE_PRODUCT_ID = "PRODUCT_ID1"
    let NON_CONSUMABLE_PURCHASE_PRODUCT_ID = "PRODUCT_ID2"
    let AUTO_CONSUMABLE_PURCHASE_PRODUCT_ID = "PRODUCT_ID3"


    // MARK: - FETCH AVAILABLE IAP PRODUCTS
    func fetchAvailableProducts(){
        
        // Put here your IAP Products ID's
        let productIdentifiers = NSSet(objects: CONSUMABLE_PURCHASE_PRODUCT_ID,NON_CONSUMABLE_PURCHASE_PRODUCT_ID,AUTO_CONSUMABLE_PURCHASE_PRODUCT_ID
        )
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }


// MARK: - SKProductsRequestDelegate

extension KKIAPManager: SKProductsRequestDelegate {
        // MARK: - REQUEST IAP PRODUCTS
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {

        if (response.products.count > 0) {
            iapProducts = response.products
            for product in iapProducts{
                let numberFormatter = NumberFormatter()
                numberFormatter.formatterBehavior = .behavior10_4
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = product.priceLocale
                let price1Str = numberFormatter.string(from: product.price)
                print(product.localizedDescription + "\nfor just \(price1Str!)")
            }
        }
    }

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

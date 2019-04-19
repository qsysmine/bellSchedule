//
//  PremiumSettingsTableViewController.swift
//  bellSchedule
//
//  Created by Ari Stassinopoulos on 11/12/17.
//  Copyright © 2017 Stassinopoulos. All rights reserved.
//

import UIKit
import StoreKit
import BellScheduleDataKit

class PremiumSettingsTableViewController: UITableViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @IBOutlet var hasPremiumLabel: UILabel!;
    @IBOutlet var getPremiumButton: UIButton!;
    
    var productID = "com.Stassinopoulos.Ari.bellSchedule.premiumFeatures";
    var productsArray: [SKProduct?] = []
    var transactionInProgress = false
    
    var hasPremium = Settings.hasPremium();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        requestProductInfo();
        if(hasPremium) {
            self.hasPremiumLabel.text = "★ You already have Premium.";
            self.getPremiumButton.isEnabled = false;
        } else {
            self.hasPremiumLabel.text = "You do not have Premium yet.";
        }
    }
    
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productRequest = SKProductsRequest(productIdentifiers: [productID])
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.payment.productIdentifier);
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self);
                transactionInProgress = false
                purchased();
            case .failed:
                transactionInProgress = false
                SKPaymentQueue.default().finishTransaction(transaction)
                self.getPremiumButton.isEnabled = true;
                failed();
            case .purchasing:
                print("purchasing");
            case .restored:
                print("restored");
                purchased();
            case .deferred:
                transactionInProgress = false
                SKPaymentQueue.default().finishTransaction(transaction)
                self.getPremiumButton.isEnabled = true;
                failed();
			@unknown default: break
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product)
                getPremiumButton.setTitle("Get Premium for only $\(product.price.description(withLocale: product.priceLocale))", for: .normal);
            }
        } else {
            print("There are no products.")
        }
        if response.invalidProductIdentifiers.count != 0 {
            print(response.invalidProductIdentifiers.description)
        }
        
    }
    
    @IBAction func buy() {
		if(self.productsArray.count > 0) {
            let payment = SKPayment(product: self.productsArray[0]!)
			self.navigationController?.view.isUserInteractionEnabled = false;
            SKPaymentQueue.default().add(self);
            SKPaymentQueue.default().add(payment)
            self.getPremiumButton.isEnabled = false;
            self.transactionInProgress = true;
        } else {
            print("No products, you fool");
        }
    }
    
    @IBAction func restore() {
		self.navigationController?.view.isUserInteractionEnabled = false;
		SKPaymentQueue.default().add(self);
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func failed() {
        let alert = UIAlertController(title: "Sorry.", message: "You were not able to purchase Premium.", preferredStyle: .alert);
        let okayAction = UIAlertAction(title: "I guess I'll try again later", style: .default) { (action) in
        }
		self.navigationController?.view.isUserInteractionEnabled = true;
        alert.addAction(okayAction);
        print("Transaction failed");
    }
    
    func purchased() {
        let alert = UIAlertController(title: "You're a star!", message: "★ You have successfully purchased Premium!", preferredStyle: .alert);
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
        }
        alert.addAction(okayAction);
        self.present(alert, animated: true) {}
        Settings.setHasPremium(hasPremium: true);
        self.getPremiumButton.isEnabled = false;
		self.navigationController?.view.isUserInteractionEnabled = true;
        self.hasPremium = true;
        self.hasPremiumLabel.text = "★ You have purchased Premium."
    }
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated);
		SKPaymentQueue.default().remove(self);
	}
    
}

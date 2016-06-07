//
//  ChocolatesOfTheWorldViewController.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/5/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit
import RxSwift

class ChocolatesOfTheWorldViewController: UIViewController {
    
    @IBOutlet private var cartButton: UIBarButtonItem!
    let chocolates = Chocolate.ofEurope
    let cart = ShoppingCart()
    let disposeBag = DisposeBag()
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chocolate!!!"
        
        setupCartObserver()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: Rx Setup
    
    private func setupCartObserver() {
        cart.chocolates.asObservable()
            .subscribeNext {
                chocolates in
                self.cartButton.title = "\(chocolates.count) 🍫"
        }.addDisposableTo(disposeBag)
    }

}

extension ChocolatesOfTheWorldViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chocolates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(ChocolateCell.Identifier, forIndexPath: indexPath) as?  ChocolateCell else {
            assertionFailure("Couldn't get the proper cell type!")
            return UITableViewCell()
        }
        
        let chocolate = chocolates[indexPath.row]
        cell.configureWithChocolate(chocolate)
        
        return cell
    }
}

extension ChocolatesOfTheWorldViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let chocolate = chocolates[indexPath.row]
        cart.chocolates.value.append(chocolate)
    }
}

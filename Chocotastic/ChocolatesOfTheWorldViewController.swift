//
//  ChocolatesOfTheWorldViewController.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/5/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChocolatesOfTheWorldViewController: UIViewController {
  
  @IBOutlet private var cartButton: UIBarButtonItem!
  @IBOutlet private var tableView: UITableView!
  let chocolates = Observable.just(Chocolate.ofEurope)
  let disposeBag = DisposeBag()
  
  //MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Chocolate!!!"
    
    setupCellConfiguration()
    setupCellTapHandling()
    setupCartObserver()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    //TODO: y u no work?
    return .LightContent
  }
  
  //MARK: Rx Setup
  
  private func setupCellConfiguration() {
    //Equivalent of cell for row at index path
    chocolates.bindTo(tableView.rx_itemsWithCellIdentifier(ChocolateCell.Identifier, cellType: ChocolateCell.self)) {
      row, chocolate, cell in
      cell.configureWithChocolate(chocolate)
      }
      .addDisposableTo(disposeBag)
  }
  
  private func setupCellTapHandling() {
    //Equivalent of did select row at index path
    tableView
      .rx_modelSelected(Chocolate)
      .subscribeNext {
        chocolate in
        ShoppingCart.sharedCart.chocolates.value.append(chocolate)
        
        if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
          self.tableView.deselectRowAtIndexPath(selectedRowIndexPath, animated: true)
        }
      }
      .addDisposableTo(disposeBag)
  }
  
  private func setupCartObserver() {
    ShoppingCart.sharedCart.chocolates.asObservable()
      .subscribeNext {
        chocolates in
        self.cartButton.title = "\(chocolates.count) 🍫"
      }
      .addDisposableTo(disposeBag)
  }
  
}

extension ChocolatesOfTheWorldViewController: SegueHandler {
  
  enum SegueIdentifier: String {
    case
    GoToCart
  }
}

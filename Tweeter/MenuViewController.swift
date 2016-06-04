//
//  MenuViewController.swift
//  Tweeter
//
//  Created by Yat Choi on 6/4/16.
//  Copyright © 2016 yatchoi. All rights reserved.
//

import UIKit

protocol MenuViewDelegate: class {
  func menuView(menuView: MenuViewController, didSelectIndexAtRow indexPath: NSIndexPath)
}

class MenuViewController: UIViewController {
  
  let menuItems:[String] = [
    "Profile",
    "Timeline"
  ]

  @IBOutlet weak var menuTable: UITableView!
  var delegate: MenuViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuTable.dataSource = self
    menuTable.delegate = self
    
    let menuCellNib = UINib(nibName: "MenuCell", bundle: nil)
    self.menuTable.registerNib(menuCellNib, forCellReuseIdentifier: "menuCell")
    menuTable.contentInset = UIEdgeInsetsZero
    menuTable.scrollIndicatorInsets = UIEdgeInsetsZero

    // Do any additional setup after loading the view.
  }
}

extension MenuViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = menuTable.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuCell
    cell.titleLabel.text = menuItems[indexPath.row]
    return cell
  }
}

extension MenuViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.delegate?.menuView(self, didSelectIndexAtRow: indexPath)
  }
}

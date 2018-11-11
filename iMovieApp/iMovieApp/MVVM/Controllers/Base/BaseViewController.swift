//
//  BaseViewController.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import UIKit

protocol UIHandable {
  func setupUI()
}

class BaseViewController: UIViewController, UIHandable {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    view.backgroundColor = .black
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

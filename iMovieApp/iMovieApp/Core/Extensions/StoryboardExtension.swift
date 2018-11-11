//
//  StoryboardExtension.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/9/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import UIKit

protocol SelfInitializable: class {
  static var defaultViewController: String { get }
}

extension SelfInitializable where Self: UIViewController {
  static var defaultViewController: String {
    return String(describing: self)
  }
  
  static func storyboardViewController(_ storyboard: UIStoryboard) -> Self {
    guard let vc = storyboard.instantiateViewController(withIdentifier: defaultViewController) as? Self else {
      fatalError("Could not instantiate viewController with name: \(defaultViewController)")
    }
    
    return vc
  }
}

extension UIViewController: SelfInitializable { }

enum AppStoryboard: String {
  
  case Movies = "Movies"
  
  var instance: UIStoryboard {
    return UIStoryboard(name: self.rawValue, bundle: nil)
  }
}


//
//  MovieDetailViewController.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/9/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
  
  var viewModel: MovieDetailViewModel!
  
  private var backdropImageView: AsyncImageView!
  private var loadingIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getBackdropImage { [weak self] (image) in
      guard let `self` = self else { return }
      guard let rImage = image else { return }
      
      DispatchQueue.main.async {
        self.loadingIndicator.stopAnimating()
        self.backdropImageView.image = rImage
      }
    }
  }
  
  override func setupUI() {
    super.setupUI()
    title = "Movie Details"
    navigationController?.navigationBar.prefersLargeTitles = false
    
    let defaultSpacing: CGFloat = 10
    
    //backdrop Image
    backdropImageView = AsyncImageView()
    backdropImageView.backgroundColor = .gray
    view.addSubview(backdropImageView)
    
    backdropImageView.translatesAutoresizingMaskIntoConstraints = false
    backdropImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    backdropImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    backdropImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
    
    //movieTitle Label
    let movieTitleLabel = UILabel(frame: CGRect.zero)
    movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    movieTitleLabel.setupDefaultWhiteLabel()
    movieTitleLabel.text = viewModel.movie.title
    view.addSubview(movieTitleLabel)
    
    movieTitleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: defaultSpacing).isActive = true
    movieTitleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -defaultSpacing).isActive = true
    movieTitleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: defaultSpacing).isActive = true
    
    //overview Label
    let overviewTextLabel = UILabel(frame: CGRect.zero)
    overviewTextLabel.setupDefaultWhiteLabel()
    overviewTextLabel.text = viewModel.movie.overview
    view.addSubview(overviewTextLabel)
    
    overviewTextLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: defaultSpacing).isActive = true
    overviewTextLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -defaultSpacing).isActive = true
    overviewTextLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: defaultSpacing).isActive = true
    overviewTextLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    //spinner
    loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
    backdropImageView.addSubview(loadingIndicator)
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.centerXAnchor.constraint(equalTo: backdropImageView.centerXAnchor).isActive = true
    loadingIndicator.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor).isActive = true
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.startAnimating()
  }
}

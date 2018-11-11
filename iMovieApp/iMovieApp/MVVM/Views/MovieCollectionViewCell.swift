//
//  MovieCollectionViewCell.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  
  private var movieImageView: AsyncImageView!
  private var loadingIndicator: UIActivityIndicatorView!
  
  private let defaultImageW: Int = 200
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindData(_ imageUrl: String?,
                _ imageWebService: ImageWebService,
                imageCache: NSCache<AnyObject, AnyObject>) {
    resetImage()
    
    guard let imageUrl = imageUrl else { return }
    
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let `self` = self else { return }
      
      //checking if we cached it before, to avoid consuming network data
      if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
        self.setImage(imageFromCache)
        return
      }
      
      //downloading the image
      imageWebService.getImageWithUrl(imageUrl, imageWidth: self.defaultImageW, imageCache: imageCache) { (image) in
        guard let rImage = image else { return }
        self.setImage(rImage)
      }
    }
  }
}

private extension MovieCollectionViewCell {
  func setImage(_ image: UIImage) {
    DispatchQueue.main.async {
      self.movieImageView.image = image
      self.loadingIndicator.stopAnimating()
    }
  }
  
  func resetImage() {
    movieImageView.image = nil
    loadingIndicator.startAnimating()
  }
  
  func setupUI() {
    movieImageView = AsyncImageView()
    movieImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(movieImageView)
    movieImageView.backgroundColor = .gray
    
    movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
    movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
    movieImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
    movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    
    loadingIndicator = UIActivityIndicatorView()
    loadingIndicator.style = .whiteLarge
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(loadingIndicator)
    loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}

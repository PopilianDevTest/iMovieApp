//
//  MoviesListViewController.swift
//  iMovieApp
//
//  Created by Popilian Andrei on 11/8/18.
//  Copyright © 2018 Popilian Andrei. All rights reserved.
//

import RxSwift
import RxCocoa

class MoviesListViewController: BaseViewController {
  
  private var colView: UICollectionView!
  private var noDataLabel: UILabel!
  
  var viewModel: MoviesListViewModel!
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let searchBar = navigationItem.searchController!.searchBar
    
    searchBar.rx.text
      .orEmpty
      .debounce(0.7, scheduler: MainScheduler.instance)
      .skip(1)
      .observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .userInteractive)))
      .subscribe(onNext: { [weak self] (searchText) in
        guard let `self` = self else { return }
        guard searchText != self.viewModel.searchText else { return }
        
        self.viewModel.fetchMovies(searchText)
      }).disposed(by: disposeBag)
    
    viewModel.movieList
      .asObservable()
      .skip(3)
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] (movies) in
        guard let `self` = self else { return }
        
        self.noDataLabel.isHidden = !(movies?.isEmpty ?? false)
        
        //this could be improved, by using insert
        //reloadData is a bad design, but due to time limitation I used it
        self.colView.reloadData()
        self.viewModel.isFetching = false
      }).disposed(by: disposeBag)
    
    viewModel.fetchMovies()
  }
  
  override func setupUI() {
    super.setupUI()
    title = "Movies"
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.definesPresentationContext = true
    
    setupCollectionView()
    setupSearchBar()
    setupNoDataFoundLabel()
  }
}

//MARK: - Private funcs
private extension MoviesListViewController {
  func setupCollectionView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.sectionInset =  UIEdgeInsets.zero
    layout.itemSize = CGSize(width: view.bounds.width / 2 , height: view.bounds.height / 3)
    
    colView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    colView.backgroundColor = .clear
    colView.dataSource = self
    colView.delegate = self
    colView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier.MovieCell.rawValue)
    view.addSubview(colView)
    
    colView.translatesAutoresizingMaskIntoConstraints = false
    colView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    colView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    colView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    colView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
  }
  
  func setupSearchBar() {
    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = true
    navigationItem.searchController?.searchBar.tintColor = .white
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
  }
  
  func setupNoDataFoundLabel()
  {
    noDataLabel = UILabel(frame: CGRect.zero)
    noDataLabel.setupDefaultWhiteLabel()
    noDataLabel.font = UIFont.boldSystemFont(ofSize: 20)
    noDataLabel.text = "No data found..."
    noDataLabel.isHidden = true;
    view.addSubview(noDataLabel)
    
    noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func showDetailsAtRow(_ row: Int) {
    let detailVC = viewModel.getDetailVCForRow(row)
    self.navigationController?.pushViewController(detailVC!, animated: true)
  }
}

//MARK: - UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.movieList.value?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.MovieCell.rawValue, for: indexPath) as! MovieCollectionViewCell
    let photoUrl = viewModel.movieList.value![indexPath.row].posterPath
    cell.bindData(photoUrl, Injector.injImageWebService(), imageCache: viewModel.imageCache)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension MoviesListViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    showDetailsAtRow(indexPath.row)
  }
}

//MARK: - UIScrollViewDelegate
extension MoviesListViewController: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHight = scrollView.contentSize.height
    
    //just to accentuate the infinite scrollview,
    //getting data before end of the scroll
    let defaultOffset: CGFloat = 200
    
    if offsetY > contentHight - scrollView.frame.height - defaultOffset {
      if !viewModel.isFetching {
        viewModel.fetchNextPage()
      }
    }
  }
}


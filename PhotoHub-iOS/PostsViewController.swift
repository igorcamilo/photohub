//
//  PostsViewController.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit

class PostsViewController: UITableViewController {
  
  static let cellId = "PostImageCell"
  static let headerId = "PostHeaderView"
  
  let viewModel = PostsViewModel()
  
  init() {
    super.init(style: .grouped)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedSectionHeaderHeight = 68
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.register(PostImageCell.self, forCellReuseIdentifier: PostsViewController.cellId)
    tableView.register(PostHeaderView.self, forHeaderFooterViewReuseIdentifier: PostsViewController.headerId)
    tableView.separatorStyle = .none
    
    let spinner = UIRefreshControl()
    refreshControl = spinner
    refreshControl?.beginRefreshing()
    spinner.addTarget(self, action: #selector(updateContents), for: .valueChanged)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateContents()
  }
  
  @objc func updateContents() {
    
    guard let refreshControl = refreshControl, refreshControl.isRefreshing else {
      return
    }
    
    viewModel.update { [weak self] (result) in
      refreshControl.endRefreshing()
      guard let strongSelf = self else {
        return
      }
      
//      strongSelf.tableView.tableHeaderView
      strongSelf.tableView.reloadData()
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfPosts
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostsViewController.headerId) as! PostHeaderView
    
    return header
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfImages(section: section)
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.size.width * 0.75
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PostsViewController.cellId, for: indexPath) as! PostImageCell
    cell.indexPath = indexPath
    cell.postImageView.image = nil
    let size = viewModel.image(indexPath: indexPath) { (result) in
      switch result {
      case .success(let value):
        if indexPath == cell.indexPath {
          cell.postImageView.image = value
        }
      case .failure(let error):
        print(error)
      }
    }
    cell.adjust(for: size ?? .zero)
    return cell
  }
}

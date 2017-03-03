//
//  PostsViewController.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit

class PostsViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableHeaderView = ForumHeaderView()
    updateHeaderView(for: view.bounds.size)
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    updateHeaderView(for: size)
  }
  
  private func updateHeaderView(for size: CGSize) {
    let contentWidth = min(size.width, CGFloat(LayoutConstants.maxWidth))
    let headerView = tableView.tableHeaderView
    headerView?.frame.size.height = contentWidth / 2
    tableView.tableHeaderView = headerView
  }
}

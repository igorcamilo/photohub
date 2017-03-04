//
//  PostsViewController.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import AlamofireImage

class PostsViewController: UITableViewController {
  
  /// ReuseID for cells
  private static let cellId = "PostImageCell"
  /// ReuseID for headers
  private static let headerId = "PostHeaderView"
  
  private let viewModel = PostsViewModel()
  
  private let tableHeaderView = ForumHeaderView()
  
  /// Asks to viewModel to update its contents.
  @objc private func updateContents() {
    
    guard let refreshControl = refreshControl, refreshControl.isRefreshing else {
      return
    }
    
    viewModel.update { [weak self] (result) in
      refreshControl.endRefreshing()
      
      guard let strongSelf = self else {
        return
      }
      
      switch result {
      case .success(_):
        
        let tableHeaderView = strongSelf.tableHeaderView
        let forumInfo = strongSelf.viewModel.forumHeader
        
        strongSelf.navigationItem.title = forumInfo?.slug
        tableHeaderView.nameLabel.text = forumInfo?.title
        tableHeaderView.descriptionLabel.text = forumInfo?.description
        if let coverURL = forumInfo?.headerImageURL {
          tableHeaderView.headerView.af_setImage(withURL: coverURL)
        }
        if let avatarURL = forumInfo?.imageURL {
          tableHeaderView.avatarView.af_setImage(withURL: avatarURL)
        }
        tableHeaderView.updateHeight(for: strongSelf.view.bounds.size.width)
        strongSelf.tableView.tableHeaderView = tableHeaderView
        strongSelf.tableView.reloadData()
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    tableHeaderView.updateHeight(for: size.width)
    tableView.tableHeaderView = tableHeaderView
  }
  
  // MARK: - UITableViewController
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfPosts
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostsViewController.headerId) as! PostHeaderView
    let postInfo = viewModel.postHeader(section: section)
    header.avatarView.image = nil
    if let avatarURL = postInfo?.userAvatarURL {
      header.avatarView.af_setImage(withURL: avatarURL)
    }
    header.userDisplayNameLabel.text = postInfo?.userDisplayName
    header.contentLabel.text = postInfo?.text
    header.dateLabel.text = postInfo?.date
    header.upVotesLabel.text = postInfo?.upVotes
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
    let imageInfo = viewModel.image(indexPath: indexPath)
    cell.adjust(for: imageInfo?.size ?? .zero)
    cell.postImageView.image = nil
    if let imageURL = imageInfo?.url {
      cell.postImageView.af_setImage(withURL: imageURL)
    }
    return cell
  }
  
  // MARK: - Initialization
  
  init() {
    super.init(style: .grouped)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.allowsSelection = false
    tableView.estimatedSectionHeaderHeight = 80
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
}

//
//  ForumHeaderView.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit
import SnapKit

/// Presents information about the forum.
class ForumHeaderView: UIView {
  
  private let wrapper = UIView()
  let headerView = UIImageView()
  let avatarView = UIImageView()
  let nameLabel = UILabel()
  let descriptionLabel = UILabel()
  
  func updateHeight(for width: CGFloat) {
    frame.size.width = width
    layoutIfNeeded()
    frame.size.height = wrapper.frame.size.height + CGFloat(LayoutConstants.bigMargin)
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    
    addSubview(wrapper)
    wrapper.snp.makeConstraints { (make) in
      make.leading.greaterThanOrEqualToSuperview()
      make.top.equalToSuperview()
      make.width.equalTo(LayoutConstants.maxWidth).priority(999)
      make.centerX.equalToSuperview()
    }
    
    headerView.contentMode = .scaleAspectFill
    headerView.clipsToBounds = true
    wrapper.addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.equalTo(headerView.snp.width).multipliedBy(0.4)
    }
    
    avatarView.contentMode = .scaleAspectFill
    avatarView.clipsToBounds = true
    wrapper.addSubview(avatarView)
    avatarView.snp.makeConstraints { (make) in
      make.size.equalTo(CGSize(width: 64, height: 64))
      make.leading.equalToSuperview().inset(LayoutConstants.bigMargin)
    }
    
    nameLabel.text = "Pretty name label"
    nameLabel.numberOfLines = 0
    nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    wrapper.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { (make) in
      make.top.equalTo(headerView.snp.bottom).offset(LayoutConstants.smallMargin)
      make.leading.equalTo(avatarView.snp.trailing).offset(LayoutConstants.smallMargin)
      make.trailing.equalToSuperview().inset(LayoutConstants.bigMargin)
    }
    
    descriptionLabel.text = "Cupcake ipsum dolor sit amet. Gummies bonbon gummi bears cake topping jelly-o. Candy dragée wafer chocolate cake donut. Wafer carrot cake oat cake toffee tart candy. Carrot cake cake gingerbread biscuit jujubes apple pie jujubes gummies sweet."
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    wrapper.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints { (make) in
      make.top.equalTo(avatarView.snp.bottom).offset(LayoutConstants.smallMargin)
      make.top.equalTo(nameLabel.snp.lastBaseline).offset(LayoutConstants.smallMargin)
      make.leading.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.trailing.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.bottom.equalToSuperview()
    }
  }
}

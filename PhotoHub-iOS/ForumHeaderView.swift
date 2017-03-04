//
//  ForumHeaderView.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit
import SnapKit

class ForumHeaderView: UIView {
  
  private let wrapper = UIView()
  let headerView = UIImageView()
  let avatarView = UIImageView()
  let nameLabel = UILabel()
  let descriptionLabel = UILabel()
  
  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    
    backgroundColor = .yellow
    
    wrapper.backgroundColor = .green
    addSubview(wrapper)
    wrapper.snp.makeConstraints { (make) in
      make.leading.greaterThanOrEqualToSuperview()
      make.top.equalToSuperview()
      make.width.equalTo(LayoutConstants.maxWidth).priority(.high)
      make.centerX.equalToSuperview()
    }
    
    headerView.backgroundColor = .blue
    wrapper.addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.equalTo(headerView.snp.width).multipliedBy(0.4)
    }
    
    avatarView.backgroundColor = .red
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

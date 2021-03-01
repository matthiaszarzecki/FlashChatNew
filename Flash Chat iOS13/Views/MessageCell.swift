//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Shruti on 27/05/20.
//  Copyright © 2020 Shruti. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var rightImageView: UIImageView!
  @IBOutlet weak var leftImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

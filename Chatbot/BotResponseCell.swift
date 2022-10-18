//
//  BotResponseCell.swift
//  Chatbot
//
//  Created by Luke Schrezenmeier on 10/6/22.
//

import UIKit

class BotResponseCell: UITableViewCell {

    @IBOutlet weak var BotMessageBubble: UIView!
    
    @IBOutlet weak var BotTextLabel: UILabel!
    
    @IBOutlet weak var BotIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //This changes the sharp corners of our message bubbles to slighly rounded corners for #aesthetics
        BotMessageBubble.layer.cornerRadius = BotMessageBubble.frame.size.height / 5
    }

    //This allows the cells of the BotMessageBubble to be animated should we need it for scrolling through them
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

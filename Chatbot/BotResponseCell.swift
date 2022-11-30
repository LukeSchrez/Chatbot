//
//  BotResponseCell.swift
//  Chatbot
//
//  Created by Luke Schrezenmeier and Anthony Mardiros on 10/6/22.
//
//  SOURCES REFERENCED:
//  https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16813324#overview
//  https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16813328#overview

import UIKit

/***********************************************************************************
 * Class BotResponseCell:
 * This class allows us to manipulate our custom message bubbles which will be used
 * in our TableView back in the main.storyboard. It handles the formatting and
 * constraints of the bubbles so that it does not go out of bounds and also handles
 * the spacing between the "type something..." text field and the user icon. This
 * specific cell is used for all of the bot's responses
 ***********************************************************************************/

class BotResponseCell: UITableViewCell {
    
    /***********************************************************************************
     * IBOutlets and IBActions:
     * ---------------------------------------------------------------------------------
     * BotMessageBubble: Allows us to access and manipulate the look of the message bubble
     *
     * BotTextLabel: Allows us to manipulate the text within the bot's message field
     *
     * BotIconImageView : This outlet allows us to insert custom images for the bot icon
     ***********************************************************************************/

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

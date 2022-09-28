//
//  MessageBubbleCell.swift
//  Chatbot
//
//  Created by Luke Schrezenmeier and Anthony Mardiros on 9/15/22.
//

import UIKit

/***********************************************************************************
 * Class MessageBubbleCell:
 * This class allows us to manipulate our custom message bubbles which will be used
 * in our TableView back in the main.storyboard. It handles the formatting and
 * constraints of the bubbles so that it does not go out of bounds and also handles
 * the spacing between the "type something..." text field and the user icon
 ***********************************************************************************/
class MessageBubbleCell: UITableViewCell {

/***********************************************************************************
 * IBOutlets and IBActions:
 * ---------------------------------------------------------------------------------
 * messageBubble: Allows us to access and manipulate the look of the message bubble
 *
 * label: This is solely to have the "type something..." displayed within the
 *        actual message bubble.
 *
 * rightImageLabel : This outlet allows us to insert custom images for the user
 ***********************************************************************************/
    @IBOutlet weak var messageBubble: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var rightImageLabel: UIImageView!
    
    
    //This function is necessary because our MessageBubbleCell class is created from a nib archive. So in order
    //for the parent class to use it, the awakeFromNib() func must be called to initialize it
    override func awakeFromNib() {
        super.awakeFromNib()
        //This changes the sharp corners of our message bubbles to slighly rounded corners for #aesthetics
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    //This allows the cells of the messageBubble to be animated should we need it for scrolling through them
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
//End of class MessageBubbleCell

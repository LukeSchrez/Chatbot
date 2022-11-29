//
//  ViewController.swift
//  Chatbot
//
//  Created by Luke Schrezenmeier and Anthony Mardiros on 9/7/22.
//

import UIKit

//SOURCES REFERENCED:
//https://developer.apple.com/forums/thread/108048
//https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3
//https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16253400?start=1155#overview

//Constants used to specify file name and file identifier for the MessageBubbleCell xib files. These are so
//we can register our new MessageBubbleCell within the ViewController so we can output them within the TableView


var botText = ""

struct constants{
    static let xibFileName          = "MessageBubbleCell"
    static let botXibFileName       = "BotResponseCell"
    static let xibFileIdentifier    = "ReusableMessageCell"
    static let botXibFileIdentifier = "BotMessageCell"
}

/***************************************************************************************
 * Class: ViewController
 * Responsible for the output of any data within the view of the main.storyboard. The
 * ViewController class will update when it recieves any input or action from the main
 * storyboard. Some of the functions of this class involve updating the table view with
 * new message bubbles, updating the view when the send button is pressed, and updating
 * the view with a keyboard for the user to type new messages.
 ***************************************************************************************/
class ViewController: UIViewController {

/****************************************************************************************
 * IBOutlets and IBActions:
 * This section is dedicated to the outlets and actions from the main.storyboard. These
 * outlets allow us to link properties from the storyboard to the view controller so that
 * we can update them with new data according to user input.
 * --------------------------------------------------------------------------------------
 * MessageTableView: Responsible for updating the TableView of our chatbot message field
 *
 * messageTextField: Responsible for updating the "type something..." message text
 *                   bubble for the user to input their chats. This will allow us to
 *                   collect the user input from the keyboard and relay it as a chat
 *                   bubble
 *
 * bottomContraintTextField: This outlet has one function, we created it to use as a
 *                           constant which changes depending on if the user clicks on
 *                           the "type something..." bubble, which opens up the keyboard.
 *                           This will change the value of this constraint so that the
 *                           entire messageBubbleCell will move up with the keyboard
 *                           instead of being hidden at the bottom of the screen
 *
 * sendButtonPressed: This is one of our IBActions. It activates when the user presses
 *                    the send button. It's purpose is to update the TableView
 *                    controller with the data the user has typed into the
 *                    "type something..." message field. This data will be reflected as
 *                    a new MessageBubbleCell
 ****************************************************************************************/
    @IBOutlet weak var MessageTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var bottomContraintTextField: NSLayoutConstraint!
    
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "moveToOptions", sender: self)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
        //text is the new input typed in by the user of type messageTextField.text
        if let text = messageTextField.text {
            //Set newMessage to equal a new sampleMessages, with the body being new input text
            var newMessage = sampleMessages(body: text)
            //Just in case the user types nothing, make sure we set the new text equal to nothing
            messageTextField.text = ""
            //Once the user hits send, append newMessage to the messages array which is linked to the struct
            //sampleMessages
            self.messages.append(newMessage)
            
            MessageTableView.reloadData()
            //This will automatically scroll the table view to the most recent message sent
            MessageTableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
            
            responses(msg: &newMessage)
            //With our data loaded, make sure to update the table view with the new data
        }
    }
    
    func responses(msg: inout sampleMessages) {
        //Array to store user inputs for use at any point in the conversation
        var memory: [Any] = Array(repeating: 0, count: 99)
        
        //Bot response and subsequent conversation depends on user input
        if ((msg.body).lowercased() == "hello") {
            botText = "Hello there, welcome to your personal chatbot developed in Swift!"
            //Append memory user input to memory array after each user input and bot response pair
            memory.append("hello")
            //Call appendMessage function to process and display messages in the table view
            Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                appendMessage(botText: botText)
            }
        }
        
        //User inputs are automatically lowercased to ignore input cases
        if ((msg.body).lowercased() == "how are you?") {
            botText = "I'm good, how are you?"
            memory.append("how are you?")
            Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                appendMessage(botText: botText)
            }
        }
        
        if ((msg.body).lowercased() == "goodbye" || msg.body == "bye") {
            botText = "Goodbye!"
            memory.append("goodbye")
            //Clear table view if user says "goodbye" or "bye" to the bot
            messages = []
            //Reloads process to start again, prompting the user for input
            MessageTableView.reloadData()
        }
        
        if (botText == ("I'm good, how are you?")) {
            if ((msg.body).lowercased() == "good") {
                botText = "That's good to hear"
                //Delays bot response time by 0.75 seconds
                Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                    appendMessage(botText: botText)
                }
            }
        }
        
        if (botText == "My name is Taylor, what is yours?") {
            botText = "Nice to meet you, \(msg.body)!"
            Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                appendMessage(botText: botText)
            }
        }
        
        if ((msg.body).lowercased() == "what is your name?") {
            botText = "My name is Taylor, what is yours?"
            memory.append("what is your name?")
            Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                appendMessage(botText: botText)
            }
        }
            
        if (botText == "Woah we go to the same school! What is your major?") {
            //Example of when user can have two different types of responses
            //Bot determines which one, and formulates a response based on that
            if (((msg.body).lowercased() == "CS") || (msg.body == "Computer science")) {
                botText = "We have the same major too! How do you like it?"
                memory.append("CS")
                memory.append("Computer science")
                Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                    appendMessage(botText: botText)
                }
            } else {
                //Conversation will take a different direction if first conditions are not met
                botText = "Oh interesting, how do you like \(msg.body)?"
                memory.append(msg.body)
                Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                    appendMessage(botText: botText)
                }
            }
        }
        
        if (botText == "I go to CSUF! What about you?") {
            if ((msg.body).lowercased() == "CSUF") {
                botText = "Woah we go to the same school! What is your major?"
                memory.append("CSUF")
                Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                    appendMessage(botText: botText)
                }
            }
        }
        
        if ((msg.body).lowercased() == "what school do you go to?") {
            botText = "I go to CSUF! What about you?"
            memory.append("what school do you go to?")
            Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { (timer) in
                appendMessage(botText: botText)
            }
        }
        
        //Function called after every user input and bot response pair
        func appendMessage(botText: String) {
            let newBotMessage = sampleMessages(body: botText)
            print (newBotMessage)
            //Display messages in chat bubble form
            self.messages.append(newBotMessage)
            self.MessageTableView.reloadData()
            //Automatically scrolls to only display the most recent messages
            MessageTableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
        }
        
    }
    
    //This is the core of our chat messages. A struct called sampleMessages, with a single variable body of
    //type string to store the chats
    struct sampleMessages{
        let body: String
    }
    
    //Now with our core sampleMessages above, create an array of sampleMessages and just call it messages.
    //Now we can store as many chats as we want into this array and it will update our table view accordingly
    var messages: [sampleMessages] = [
        //sampleMessages(body: "Hello! I am your semi-smart Swift Chatbot!")
    ]
        
    
    //This function is called right when the view is loaded. It is a predefined function that has to be here to
    //ensure our storyboards are outputting correctly
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This register() function is responsible for "registering" our MessageBubbleCell so that it can be used
        //within the table view. Now, our table view knows how to create new cells and it will use the design of
        //our MessageBubbleCell to do it!
        MessageTableView.register(UINib(nibName: constants.xibFileName, bundle: nil), forCellReuseIdentifier: constants.xibFileIdentifier)
        
        //This register() function is responsible for "registering" our MessageBubbleCell so that it can be used
        //within the table view. Now, our table view knows how to create new cells and it will use the design of
        //our MessageBubbleCell to do it!
        MessageTableView.register(UINib(nibName: constants.botXibFileName, bundle: nil), forCellReuseIdentifier: constants.botXibFileIdentifier)
    
        
        //addObserver() will allow us to manipulate the keyboard when it is pressed. That way, we can use the
        //keyboardWillShow() function below to manipulate how our view looks when it is being displayed
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
    }
    
    //This functions purpose is to acquire the height of the keyboard as a float value when the keyboard is active.
    private func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        return ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)?.height
    }
    
    //Now that we have an observer, we can use this function to change the bottom constraint of the
    //"type something..." text field. That way, when the keyboard pops up, the entire MessageBubbleCell will move
    //up with the keyboard since every element is linked together in a StackView
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardHeight = self.getKeyboardHeight(notification: sender) {
            //With the height of the keyboard given by getKeyboardHeight(), make sure the bottom
            //constraint is 25 units above the keyboard
            bottomContraintTextField.constant = keyboardHeight - 18
        }
        else {
            bottomContraintTextField.constant = 300
        }
    }
}
//End of class ViewController


/*****************************************************************************************
 * Class extension ViewController:
 * This extension has one purpose: Allow us to use our messages array as the data source
 * for our TableView using our unique design for the MessageBubbleCell.
 *****************************************************************************************/
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //This func ensures that every new cell in our TableView will be using the data from messages and updating
    //the TableView with that data using our MessageBubbleCell and BotResponse cell. The .xibFileIdentifier is what is allowing the
    //cell to access the MessageTableView and the MessageBubbleCell/BotResponseCell identifier is what allows the cell to use
    //the unique designs
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Check if the current row index of the table view is odd for the bot or even for the user so that they alternate
        if (indexPath.row % 2) == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: constants.xibFileIdentifier, for: indexPath)
            as! MessageBubbleCell
            //Assign the text of the cell with the current index of messages and return the new cell
            cell.label.text = messages[indexPath.row].body
            return cell
        }
        else{
            let botCell = tableView.dequeueReusableCell(withIdentifier: constants.botXibFileIdentifier, for: indexPath)
            as! BotResponseCell
            //Assign the text of the bot cell with the current index of messages and return the new cell
            botCell.BotTextLabel.text = messages[indexPath.row].body
            return botCell
        }
    }
}
//End of extension class ViewController


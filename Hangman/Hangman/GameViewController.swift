//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    @IBOutlet weak var correctGuessCharacterDisplay: UILabel!
    @IBOutlet weak var userGuessCharacterInput: UITextField!
    
    let validCharacters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    var hangmanWord = ""
    var incorrectGuessedCharacters = ""
    var phraseMask = ""
    var hangmanWordArray = [Character]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
    
        for i in phrase.characters.indices {
            if (phrase[i] == " ") {
                phraseMask += " "
//                hangmanWord += " "
            } else {
                phraseMask += "_ "
                hangmanWord += String(phrase[i]).lowercaseString
            }
        }
        hangmanWordArray = Array(hangmanWord.characters)
        
        correctGuessCharacterDisplay.text = phraseMask
        hangmanImage.image = UIImage(named: "hangman1.gif")
        incorrectGuessesLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressCorrectButton(sender: AnyObject) {
        
        
    }

    @IBAction func pressIncorrectButton(sender: AnyObject) {
        let guessedCharacter = userGuessCharacterInput.text!
        if (validCharacters.contains(guessedCharacter)) {
            print(hangmanWordArray)
            if (!hangmanWordArray.contains(Character(guessedCharacter))) {
                incorrectGuessedCharacters += userGuessCharacterInput.text!
                incorrectGuessesLabel.text = incorrectGuessedCharacters
                incorrectGuessedCharacters += ", "
            }
        }
        
        userGuessCharacterInput.text = ""
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

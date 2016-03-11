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
    let hangmanPictures = ["hangman1.gif", "hangman2.gif", "hangman3.gif", "hangman4.gif", "hangman5.gif", "hangman6.gif", "hangman7.gif"]

    var hangmanWord = ""
    var incorrectGuessedCharactersForDisplay = ""
    var phraseMask = ""
    var hangmanWordArray = [Character]()
    var correctGuessedCharacters = [Character]()
    var incorrectGuessedCharacters = [Character]()
    var numberOfIncorrectGuesses = 0
    var finishedGame = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset() {
        finishedGame = false
        numberOfIncorrectGuesses = 0
        phraseMask = ""
        correctGuessedCharacters = [Character]()
        hangmanWord = ""
        incorrectGuessedCharacters = [Character]()
        userGuessCharacterInput.text = ""
        incorrectGuessedCharactersForDisplay = ""
    }
    
    func newGame() {
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
    
        reset()
        for i in phrase.characters.indices {
            if (phrase[i] == " ") {
                phraseMask += "  "
                hangmanWord += " "
            } else {
                phraseMask += "_ "
                hangmanWord += String(phrase[i]).lowercaseString
            }
        }
        hangmanWordArray = Array(hangmanWord.characters)
        
        correctGuessCharacterDisplay.text = phraseMask
        hangmanImage.image = UIImage(named: hangmanPictures[numberOfIncorrectGuesses])
        incorrectGuessesLabel.text = ""
    }
    
    func startOver() {
        reset()
        for (var i = 0; i < hangmanWordArray.count; i++) {
            if (hangmanWordArray[i] == " ") {
                phraseMask += "  "
            } else {
                phraseMask += "_ "
            }
        }
        
        correctGuessCharacterDisplay.text = phraseMask
        hangmanImage.image = UIImage(named: hangmanPictures[numberOfIncorrectGuesses])
        incorrectGuessesLabel.text = ""
    }

    @IBAction func pressNewGameButton(sender: AnyObject) {
        newGame()
    }
    
    @IBAction func pressStartOverButton(sender: AnyObject) {
        startOver()
    }
    
    
    @IBAction func pressGuessButton(sender: AnyObject) {
        let guessedCharacter = userGuessCharacterInput.text!.lowercaseString
        if (finishedGame) {
            return
        }
        if (guessedCharacter == "") {
            return
        }
        if (validCharacters.contains(guessedCharacter)) {
            if (hangmanWordArray.contains(Character(guessedCharacter))) {
                updateCorrectCharacters(guessedCharacter)
            } else {
                updateIncorrectCharacts(guessedCharacter)
            }
        } else {
            let wrongInputAlert = UIAlertController(title: "Incorrect Character", message: "Please enter ONE alpha character only", preferredStyle: .Alert)
            let gotItButton = UIAlertAction(title: "Got it!", style: .Default, handler: nil)
            wrongInputAlert.addAction(gotItButton)
            showViewController(wrongInputAlert, sender: self)
        }
        
        userGuessCharacterInput.text = ""
        
    }
    
    func updateCorrectCharacters(guessedCharacter: String) {
        if (!correctGuessedCharacters.contains(Character(guessedCharacter))) {
            correctGuessedCharacters.append(Character(guessedCharacter))
            phraseMask = ""
            var numberOfCorrectGuesses = 0
            var numberOfSpacesInHangManWord = 0
            for (var i = 0; i < hangmanWordArray.count; i++) {
                if (hangmanWordArray[i] == " ") {
                    phraseMask += "  "
                    numberOfSpacesInHangManWord += 1
                } else if (hangmanWordArray[i] == Character(guessedCharacter)) {
                    phraseMask += String(hangmanWordArray[i])
                    numberOfCorrectGuesses += 1
                } else if (correctGuessedCharacters.contains(hangmanWordArray[i])) {
                    phraseMask += String(hangmanWordArray[i])
                    numberOfCorrectGuesses += 1
                } else {
                    phraseMask += "_ "
                }
            }
            correctGuessCharacterDisplay.text = phraseMask
            if ((numberOfCorrectGuesses + numberOfSpacesInHangManWord) == hangmanWordArray.count) {
                let winAlert = UIAlertController(title: "You're the Champion!", message: " Great job! Press Start Over to guess the same word. Press New Game to guess a new word.", preferredStyle: UIAlertControllerStyle.Alert)
                let hellYeahAction = UIAlertAction(title: "Hell Yeah!", style: .Default, handler: nil)
                winAlert.addAction(hellYeahAction)
                showViewController(winAlert, sender: self)
                finishedGame = true
            }
        }
    }
    
    func updateIncorrectCharacts(guessedCharacter: String) {
        if (incorrectGuessedCharacters.contains(Character(guessedCharacter))) {
            return
        } else {
            incorrectGuessedCharacters.append(Character(guessedCharacter))
            incorrectGuessedCharactersForDisplay += userGuessCharacterInput.text!
            incorrectGuessesLabel.text = incorrectGuessedCharactersForDisplay
            incorrectGuessedCharactersForDisplay += ", "
            numberOfIncorrectGuesses += 1
            if (numberOfIncorrectGuesses < 7) {
                hangmanImage.image = UIImage(named: hangmanPictures[numberOfIncorrectGuesses])
            } else {
                let loseAlert = UIAlertController(title: "You lose!", message: "Press New Game to guess a new word. Press Start Over to guess the same word.", preferredStyle: UIAlertControllerStyle.Alert)
                let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                let newGameAction = UIAlertAction(title: "New Game", style: .Default, handler: {(act: UIAlertAction) -> Void in self.newGame()})
                loseAlert.addAction(doneAction)
                loseAlert.addAction(newGameAction)
                showViewController(loseAlert, sender: self)
                finishedGame = true
            }
        }
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

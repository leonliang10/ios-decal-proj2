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
    @IBOutlet weak var guessesLabel: UILabel!
    
    

    var hangmanWord = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        var phraseMask = ""
        for i in phrase.characters.indices {
            if (phrase[i] == " ") {
                phraseMask += " "
                hangmanWord += " "
            } else {
                phraseMask += "_ "
                hangmanWord += String(phrase[i])
            }
        }
        guessesLabel.text = phraseMask
        hangmanImage.image = UIImage(named: "hangman1.gif")
        incorrectGuessesLabel.text = "Incorrect Guesses:"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

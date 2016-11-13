//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var tries = 1
    var wrongGuesses = Set<String>()
    var secretWord : String?
    var secretWordLength : Int?
    var arrayOfGuesses : [Bool]?
    var secretWordArray : [Character]?
    var setOfWordCharacters = Set<String>()
    
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var incorrectGuessList: UILabel!
    @IBOutlet weak var letterToGuess: UITextField!
    @IBOutlet weak var wordToGuess: UILabel!
    @IBOutlet weak var hangman: UIImageView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        //set hangman image
        hangman.image = UIImage(named: "hangman1.gif")
        
        //set secretword parameters
        secretWord = HangmanPhrases().getRandomPhrase()
        secretWordArray = [Character](secretWord!.characters)
        secretWordLength = secretWord!.characters.count
        arrayOfGuesses = [Bool](repeating: false, count: secretWordLength!)
        for c in secretWordArray! {
            setOfWordCharacters.insert(String(c))
            
        }
        
        //display hidden word
        wordToGuess.text = ""
        for index in 0...secretWordLength!-1 {
            if arrayOfGuesses![index] {
                wordToGuess.text = wordToGuess.text! + String(secretWordArray![index]) + " "
            } else if secretWordArray?[index] == " "{
                wordToGuess.text = wordToGuess.text! + "  "
                
            } else {
                wordToGuess.text = wordToGuess.text! + "_ "
            }
        }
    }
    
    
    
    func startOver() {
        //reset image
        hangman.image = UIImage(named: "hangman1.gif")
        
        
        //reset parameters
        tries = 1
        secretWord = HangmanPhrases().getRandomPhrase()
        secretWordArray = [Character](secretWord!.characters)
        secretWordLength = secretWord!.characters.count
        wordToGuess.text = ""
        setOfWordCharacters = Set<String>()
        wrongGuesses = Set<String>()
        
        //reset guess list
        arrayOfGuesses = [Bool](repeating: false, count: secretWordLength!)
        for c in secretWordArray! {
            setOfWordCharacters.insert(String(c))
            
        }
        
        //redisplay blank guesses
        incorrectGuessList.text = ""
        wordToGuess.text = ""
        for index in 0...secretWordLength!-1 {
            if arrayOfGuesses![index] {
                wordToGuess.text = wordToGuess.text! + String(secretWordArray![index]) + " "
            } else if secretWordArray?[index] == " "{
                wordToGuess.text = wordToGuess.text! + "  "
                
            } else {
                wordToGuess.text = wordToGuess.text! + "_ "
            }
        }
    }
    
    @IBAction func guessMade(_ sender: AnyObject) {
        let guess = letterToGuess.text
        if guess!.characters.count == 1 {
            
            if (setOfWordCharacters.contains(guess!)) {
                for index in 0...secretWordLength!-1 {
                    if guess == String(secretWordArray![index]) {
                        arrayOfGuesses![index] = true
                    }
                    if (String(secretWordArray![index]) == " ") {
                        arrayOfGuesses![index] = true
                    }
                }
                //checkwin
                if (!(arrayOfGuesses?.contains(false))!) {
                    let alertController = UIAlertController(title: "WOOHOO! YOU WON!", message: "New Game?", preferredStyle: .alert)
                    let newGameAction = UIAlertAction(title: "let's go", style: .default) {
                        action in self.startOver()
                    }
                    alertController.addAction(newGameAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
                
            else {
                if !wrongGuesses.contains(String(guess!)) {
                    wrongGuesses.insert(String(guess!))
                    if tries <= 6 {
                        tries += 1
                        let imageName = "hangman" + String(tries) + ".gif"
                        hangman.image = UIImage(named: imageName)
                    }
                    if tries > 6{
                        let alertController = UIAlertController(title: "YOU LOSE.", message: "New Game?", preferredStyle: .alert)
                        let newGameAction = UIAlertAction(title: "let's go", style: .default) {
                            action in self.startOver()
                        }
                        alertController.addAction(newGameAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    incorrectGuessList.text = String(describing: wrongGuesses)
                }
            }
        }
        
        //redisplay word so far
        letterToGuess.text = ""
        wordToGuess.text = ""
        for index in 0...secretWordLength!-1 {
            if arrayOfGuesses![index] {
                wordToGuess.text = wordToGuess.text! + String(secretWordArray![index]) + " "
            } else if secretWordArray?[index] == " "{
                wordToGuess.text = wordToGuess.text! + "  "
            } else {
                wordToGuess.text = wordToGuess.text! + "_ "
            }
        }
    }
    
    @IBAction func typingInText(_ sender: AnyObject) {
        if letterToGuess.text!.characters.count > 2 {
            letterToGuess.text = ""
        }
    }
    
    @IBAction func newGameRequested(_ sender: AnyObject) {
        startOver()
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

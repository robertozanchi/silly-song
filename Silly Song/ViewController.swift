//
//  ViewController.swift
//  Silly Song
//
//  Created by Roberto on 01/12/15.
//  Copyright © 2015 Roberto Zanchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if (nameField.text != "") {
            lyricsView.text = lyricsForName(bananaFanaTemplate, fullName: nameField.text!)
        }
        
    }

    func shortNameForName(name: String) -> String {
        let lowercaseName = name.lowercaseString
        let vowelSet = NSCharacterSet(charactersInString: "aeiou")
        
        if let firstVowelRange = lowercaseName.stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: nil).rangeOfCharacterFromSet(vowelSet) {
            return lowercaseName.substringFromIndex(firstVowelRange.startIndex)
        }
        
        return lowercaseName
    }
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joinWithSeparator("\n")
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameForName(fullName)
        
        let lyrics = lyricsTemplate
            .stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
            .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
        
        return lyrics
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
//
//  TweetViewController.swift
//  Twitter
//
//  Created by Evelyn Hasama on 10/14/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        tweetTextView.text = ""
        characterCount.text = "280"
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var characterCount: UILabel!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        self.characterCount.text = String(280 - newText.count)
        return newText.count < characterLimit
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: {
                print("tweeted")
                })
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

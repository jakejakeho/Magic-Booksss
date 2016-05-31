//
//  GameOverViewController.swift
//  Magic Booksss
//
//  Created by Jake on 31/5/2016.
//  Copyright © 2016 Jake. All rights reserved.
//

import Foundation
import UIKit

class GameOverViewController: UIViewController {
    var score:Int = 0;
    var gamemode:String=String();
    
    @IBOutlet weak var GameModeLabel: UILabel!
    @IBOutlet weak var HighestScoreLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    override func viewDidLoad() {
        let defaults=NSUserDefaults()
        let highscore=defaults.integerForKey("highscore")
        if(score>highscore)
        {
            defaults.setInteger(score, forKey: "highscore")
        }
        let highscoreshow=defaults.integerForKey("highscore")
        GameModeLabel.text = ("Game Mode: ")+gamemode;
        HighestScoreLabel.text = ("Highest Score: ")+String(highscoreshow);
        ScoreLabel.text = ("Score:")+String(score);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  GameModeViewController.swift
//  Magic Booksss
//
//  Created by Jake on 30/5/2016.
//  Copyright © 2016 Jake. All rights reserved.
//

import UIKit

class GameModeViewController: UIViewController {

    @IBOutlet weak var SurvivalMode: UIButton!
    @IBOutlet weak var TimeAttack: UIButton!
    @IBOutlet weak var RelaxMode: UIButton!
    @IBOutlet weak var LearningMode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var gamemode = "Empty";
        if (segue.identifier == "SurvivalMode") {
            gamemode = "Survival Mode"
        }else if (segue.identifier == "TimeAttack") {
            gamemode = "Time Attack"
        }else if (segue.identifier == "RelaxMode") {
            gamemode = "Relax Mode"
        }else if (segue.identifier == "LearningMode") {
            gamemode = "Learning Mode"
        }
        if(!(gamemode=="Empty")){
            let svc = segue.destinationViewController as! GameViewController;
            svc.gamemode=gamemode
        }
    }
}
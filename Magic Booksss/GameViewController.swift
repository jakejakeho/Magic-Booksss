//
//  GameViewController.swift
//  Magic Booksss
//
//  Created by Jake on 30/5/2016.
//  Copyright © 2016 Jake. All rights reserved.
//
import Foundation
import UIKit

class GameViewController: UIViewController {
    // to receive gamemode from gamemodeview
    var gamemode: String = "";
    
    // to store gamedata
    var gamedata: GameModel = GameModel();
    
    // to store array of imagebutton
    @IBOutlet var ImageButtonArray: [UIButton]!
    
    // to link the score label to controller
    @IBOutlet weak var ScoreLabel: UILabel!

   
    
    // get screen resoulution
    let screenSize = UIScreen.mainScreen().bounds;
    var width = CGFloat(0);
    var height = CGFloat(0);
    var intWidth = UInt32(0);
    var intHeight = UInt32(0);
    var count=0;
    
    // timer variable
    var animationtimer:[NSTimer] = [NSTimer]();
    
    // to pause 
    var pause:Bool = false;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
        // get screen resoulution
        width = screenSize.width;
        height = screenSize.height;
        
        // calculate the maximum width
        print("old width",width)
        width-=(CGFloat(127))
        print("new width",width)
        intWidth = UInt32(width)
        intHeight = UInt32(height)
        
        
        // disable autolayout random y axis

        for index:Int in 0...ImageButtonArray.count-1{
            self.ImageButtonArray[index].translatesAutoresizingMaskIntoConstraints = true;
            //random X Y Position
            self.ImageButtonArray[index].frame = CGRectMake(randomBetweenNumbers(width, secondNum: CGFloat(0)), randomBetweenNumbers(CGFloat(-300), secondNum: CGFloat(-50)), CGFloat(127), CGFloat(86))
        }
        // select the gamemode to call different mode functions
        print(gamemode)
        if(gamemode=="Survival Mode"){
            survivalMode()
        }
        
        
        // settimer repeat animation and checking functions
        for index:Int in 0...ImageButtonArray.count-1{
            animationtimer.append(NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(GameViewController.animation), userInfo: index, repeats: true))
            animationtimer.append(NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameViewController.checking), userInfo: index, repeats: true))
        }
        
    }

    func survivalMode(){
        // initliaze images 
        for index:Int in 0...ImageButtonArray.count-1{
            ImageButtonArray[index].setImage(UIImage.init(named: gamedata.randomSurvivalID(index)), forState: UIControlState.Normal)
        }
     }
    
    // to check wheter the button is correct or not get from the gamedata
    @IBAction func ButtonAction(sender: UIButton) {
        // check the button ID
        let id:Int = ImageButtonArray.indexOf(sender)!
        
        // if correct
        if (gamedata.isCorrect(id)){
            // add one score
            gamedata.plusScore()
            print("Score++ = ",gamedata.getScore(),"id = ",id)
            
            //update the score label
            ScoreLabel.text="Score: "+String(gamedata.getScore());
            
            // put the button back to the top
            self.ImageButtonArray[id].frame.origin.y = randomBetweenNumbers(CGFloat(-400), secondNum: CGFloat(-50))
            
            // buffer Image
            let tempUIImage:UIImage = UIImage.init(named: self.gamedata.randomSurvivalID(id))!
            
            // call UI Thread to update the Image of the buttom
            dispatch_async(dispatch_get_main_queue(), {
                print("Updating Image",id,"is",self.gamedata.isCorrect(id))
                self.ImageButtonArray[id].setImage(tempUIImage, forState: UIControlState.Normal)
            });
        }
        // wrong button
        else{
            print("Wrong Button","id = ",id)
            gameOver(sender);
        }
    }
    
    // this function will be called if the player has pressed the wrong button
    func gameOver(sender:UIButton){
        // switch to gameover veiw
        print("Switch here")
        performSegueWithIdentifier("GameOverSegue", sender: sender)
        print("bug thread?")
        // to free up all thread
        for index in 0...animationtimer.count-1{
            animationtimer[index].invalidate()
        }

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let svc = segue.destinationViewController as! GameOverViewController;
        print("gg")
        svc.score=gamedata.getScore()
        svc.gamemode=gamemode;
    }
    func animation(timer: NSTimer?) {
        // increase the y value
        let i = timer!.userInfo?.integerValue
        self.ImageButtonArray[i!].frame.origin.y += CGFloat(1);
    }
    func checking(timer:NSTimer?) {
        // get the current buttonID
        let i = timer!.userInfo?.integerValue
        
        // to create a temp float for faster speed
        let tempcgfloat =  CGFloat(-50);
        
        // when the button is at the top of the screen which is not visible
        if(ImageButtonArray[i!].frame.origin.y < tempcgfloat){
            // check collision if collision it will reposition the y axis
            while(collision(i!)){
                self.ImageButtonArray[i!].frame.origin.y = randomBetweenNumbers(CGFloat(-400), secondNum: tempcgfloat)
            }
        }
        // when the buttno is at the bottom of the screen which is not visible
        if(ImageButtonArray[i!].frame.origin.y > height){
            
            // if it is a correct which is not cliked
            if (gamedata.isCorrect(i!)){
                gameOver(ImageButtonArray[i!]);
            }
            
            // if the wrong button is not cliked
            else{
                // randomize the y axis back to the top
                self.ImageButtonArray[i!].frame.origin.y = randomBetweenNumbers(CGFloat(-400), secondNum: tempcgfloat)
                
                // buffer Image
                let tempUIImage:UIImage = UIImage.init(named: self.gamedata.randomSurvivalID(i!))!
                
                // call the Main UI Thread to load the Iamge
                dispatch_async(dispatch_get_main_queue(), {
                    print("Updating Image",i!,"is",self.gamedata.isCorrect(i!))
                    self.ImageButtonArray[i!].setImage(tempUIImage, forState: UIControlState.Normal)
                });
            }
        }
    }
    
    // to check wheter the buttons have collision return true if collision otherwise return false
    func collision(inID:Int) -> Bool {
        for _i:Int in 0 ..< ImageButtonArray.count{
            if(_i != inID){
                if(((ImageButtonArray[inID].frame.origin.y + CGFloat(86)) > ImageButtonArray[_i].frame.origin.y)&&((ImageButtonArray[inID].frame.origin.y - CGFloat(86)) < ImageButtonArray[_i].frame.origin.y)){
                    print("collision detected")
                    return true;
                }
            }
        }
        return false
    }
    
    // to get a random CGFloat between first number and second nubmer
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

}

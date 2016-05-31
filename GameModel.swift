//
//  GameModel.swift
//  Magic Booksss
//
//  Created by Jake on 30/5/2016.
//  Copyright © 2016 Jake. All rights reserved.
//

import UIKit

class GameModel{
    var ImageID:[Int] = [Int](count:3, repeatedValue: 0);
    var correctWord:[Bool] = [Bool](count:3, repeatedValue: false);
    var numOfCorrectWords:Int = 10;
    var score:Int = 0;
    init(){
    }
    func randomSurvivalID(inID:Int)->String{
        if(isatleastonecorrect(inID)){
            ImageID[inID] = (Int)(arc4random_uniform(30)+1);
        }else{
            ImageID[inID] = (Int)(arc4random_uniform(10)+1);
        }
        if(ImageID[inID]<=numOfCorrectWords){
            correctWord[inID]=true;
        }else{
            correctWord[inID]=false;
        }
        var ImageIDString:String = "survival";
        ImageIDString+="\(ImageID[inID])";
        return ImageIDString;
    }
    func SurvivalID(inID:Int)->String{
        var ImageIDString:String = "survival";
        ImageIDString+="\(ImageID[inID])";
        return ImageIDString;
    }
    
    func isCorrect(inID:Int)->Bool{
        return correctWord[inID]
    }
    
    func plusScore(){
        score+=1;
    }
    func getScore()->Int{
        return score
    }
    func isatleastonecorrect(inID:Int)->Bool{
        for index in 0...(correctWord.count-1){
            if(index != inID){
                if(correctWord[index]){
                    return true;
                }
            }
        }
        return false;
    }
}
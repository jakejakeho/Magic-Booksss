//
//  GameModel.swift
//  Magic Booksss
//
//  Created by Jake on 30/5/2016.
//  Copyright © 2016 Jake. All rights reserved.
//

import Foundation

class GameModel{
    var ImageID:[Int] = [Int](count:3, repeatedValue: 0);
    var numOfCorrectWords:Int = 10;
    var correctWord:Bool = false;
    func randomSurvivalID(inID:Int)->String{
        if(isatleastonecorrect()){
            ImageID[inID] = (Int)(arc4random_uniform(30)+1);
        }else{
            ImageID[inID] = (Int)(arc4random_uniform(10)+1);
        }
        if(ImageID[inID]<=10){
            correctWord=true;
        }else{
            correctWord=false;
        }
        var ImageIDString:String = "survival";
        ImageIDString+="\(ImageID[inID])";
        return ImageIDString;
    }
    func isatleastonecorrect()->Bool{
        for index in 0...ImageID.count{
            if(ImageID[index]<=numOfCorrectWords){
                return true;
            }
        }
        return false;
    }
}
//
//  ViewController.swift
//  MiniGame
//
//  Created by 박주영 on 2015. 10. 20..
//  Copyright © 2015년 tAcademy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!  //up or down
    @IBOutlet weak var inputBox: UITextField!  //입력상자
    var randomNum = 0
    var inputNum = ""
    var count : Int = 0
    var limit : Int = 0
    var timeLeft = 0
    var ing = false
    
    //타이머
    @IBOutlet weak var timeLabel: UILabel!
    var timer : NSTimer!
    
    func startTimer() {
        ing = true
        let interval: NSTimeInterval = 1
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "countDown:", userInfo: nil, repeats: true)
    }
    
    func countDown(timer: NSTimer) {
        //        for (var i=30;i>0;i--){
        //            var timeLeft = i
        //            timeLabel.text = timeLeft.description
        //        }
        //pickerView.countDownDuration -= 60
        
        
//        let now = NSDate()
//        timeLabel.text = now.description
        timeLabel.text = "남은 시간 : " + timeLeft.description + "초"
        
        timeLeft--
        
        if timeLeft == -1 {
            timer.invalidate()
            let dialog = UIAlertController(title: "실패", message: "제한시간이 초과되었습니다", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "다시하기", style: UIAlertActionStyle.Default) {(action) -> Void in print("OK 선택")}
            dialog.addAction(okAction)
            self.presentViewController(dialog, animated: true, completion: nil)
            
            textLabel.text = "게임을 선택하세요!"
            inputBox.text = nil
            randomNum = 0
            count = 0
        }
    }
    

    @IBAction func chooseGame(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            randomNum = Int(arc4random() % 5)+1 //1부터 5사이의 난수
            limit = 5
            count = 0
            timeLeft = 10
            textLabel.text = "게임 START!"
            if ing == true {
                timer.invalidate()
            }
            startTimer()
            
        case 1:
            randomNum = Int(arc4random() % 50)+1 //1부터 50사이의 난수
            limit = 10
            count = 0
            timeLeft = 15
            textLabel.text = "게임 START!"
            if ing == true {
                timer.invalidate()
            }
            startTimer()
            
        case 2:
            randomNum = Int(arc4random() % 100)+1 //1부터 100사이의 난수
            limit = 15
            count = 0
            timeLeft = 20
            textLabel.text = "게임 START!"
            if ing == true {
                timer.invalidate()
            }
            startTimer()
            
        default:
            break
        }
    }
    
    
    @IBAction func check(sender: UIButton) {
        inputNum = inputBox.text!
        inputBox.text = nil
        count++

        //게임오버
        if inputNum != "" {
        if count == limit {
            let dialog = UIAlertController(title: "실패", message: "Game Over", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "다시하기", style: UIAlertActionStyle.Default) {(action) -> Void in print("OK 선택")}
            dialog.addAction(okAction)
            self.presentViewController(dialog, animated: true, completion: nil)
            timer.invalidate()
            textLabel.text = "게임을 선택하세요!"
            inputBox.text = nil
            randomNum = 0
            count = 0
        }
        } else {
            let dialog = UIAlertController(title: "입력 오류", message: "숫자를 입력해주세요!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(action) -> Void in print("OK 선택")}
            dialog.addAction(okAction)
            self.presentViewController(dialog, animated: true, completion: nil)
            count--
            //            countLabel.text = nil
            //            textLabel.text = nil
            //            count = 0
        }
        
        //카운트 보여주기
        let left = limit-count
        countLabel.text = "* " + String(left) + "번의 기회 남음"
        
        //up and down 또는 정답?
        if randomNum > Int(inputNum) {
            textLabel.text = "UP"
        } else if randomNum < Int(inputNum) {
            textLabel.text = "DOWN"
        } else if randomNum == Int(inputNum) {
            let dialog = UIAlertController(title: "성공 (정답 : \(randomNum))", message: "숫자를 맞추셨습니다!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "다시하기", style: UIAlertActionStyle.Default) {(action) -> Void in print("OK")}
            dialog.addAction(okAction)
            self.presentViewController(dialog, animated: true, completion: nil)
            
            timer.invalidate()
            textLabel.text = "게임을 선택하세요!"
            countLabel.text = nil
            inputBox.text = nil
            randomNum = 1000
            count = 0
        }
        
        //게임을 선택해주세요 (시작할때)
        if randomNum == 0 {
            let dialog = UIAlertController(title: "게임 셋", message: "게임을 선택해주세요!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(action) -> Void in print("OK 선택")}
            dialog.addAction(okAction)
            self.presentViewController(dialog, animated: true, completion: nil)
            
            inputBox.text = nil
            countLabel.text = nil
            textLabel.text = "게임을 선택하세요!"
            count = 0
        }
        
        //게임을 다시 선택하세요
        if randomNum == 1000 {
            let dialog = UIAlertController(title: "게임 리셋", message: "게임을 다시 선택해주세요!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(action) -> Void in print("OK 선택")}
            dialog.addAction(okAction)
            self.presentViewController(dialog, animated: true, completion: nil)
            countLabel.text = nil
            inputBox.text = nil
            textLabel.text = "게임을 선택하세요!"
            count = 0
        }
        
}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
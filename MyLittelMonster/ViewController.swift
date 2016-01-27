//
//  ViewController.swift
//  MyLittelMonster
//
//  Created by Amr Sami on 1/27/16.
//  Copyright © 2016 Amr Sami. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var diggerImg: DiggerImg!
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var restartLbl: UILabel!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var chooseingView: UIView!
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    var isMonsterChoosen = true
    
    var musicPlayer: AVAudioPlayer!
    var sfxBit: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        penaltyDimAlpha()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBit = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxSkull.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxBit.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        //startTimer()
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBit.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            penalties++
            
            sfxSkull.play()
            
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penaltyDimAlpha()
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
            
        }
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodDimAlfa()
            heartOpaque()
        } else {
            foodOpaque()
            heartDimAlfa()
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        timer.invalidate()
        foodDimAlfa()
        heartDimAlfa()
        if isMonsterChoosen {
            monsterImg.playDeathAnimation()
        } else {
            diggerImg.playDeathAnimation()
        }
        sfxDeath.play()
        restartAppear()
    }
    
    @IBAction func onRestartPressed(sender: AnyObject) {
        restart()
        restartDisappear()
    }
    
    func restart() {
        penalties = 0
        penaltyDimAlpha()
        if isMonsterChoosen {
            monsterImg.playReverseDeathAnimation()
            monsterImg.playIdelAnimation()
        } else {
            diggerImg.playReverseDeathAnimation()
            diggerImg.playIdelAnimation()
        }
        
    }
    
    func restartAppear() {
        restartLbl.hidden = false
        restartBtn.hidden = false
    }
    
    func restartDisappear() {
        restartBtn.hidden = true
        restartLbl.hidden = true
    }
    
    func foodDimAlfa() {
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
    }
    
    func heartDimAlfa() {
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
    }
    
    func foodOpaque() {
        foodImg.alpha = OPAQUE
        foodImg.userInteractionEnabled = true
    }
    
    func heartOpaque() {
        heartImg.alpha = OPAQUE
        heartImg.userInteractionEnabled = true
    }
    
    
    func penaltyDimAlpha() {
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
    }
    
    @IBAction func onMonster1Pressed(sender: AnyObject) {
        chooseingView.hidden = true
        monsterTarget()
        diggerImg.hidden = true
        isMonsterChoosen = true
        startTimer()
    }
    
    
    @IBAction func onMonster2Pressed(sender: AnyObject) {
        chooseingView.hidden = true
        diggerTarget()
        monsterImg.hidden = true
        isMonsterChoosen = false
        startTimer()
    }
    
    func monsterTarget() {
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
    }
    func diggerTarget() {
        foodImg.dropTarget = diggerImg
        heartImg.dropTarget = diggerImg
    }

}


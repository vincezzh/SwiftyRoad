//
//  ViewController.swift
//  SwiftyRoad
//
//  Created by Vince Zhang on 2015-05-27.
//  Copyright (c) 2015 Akhaltech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var road: RoadView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    var soundManager = SoundManager()
    var player: UIImageView!
    var enemy: EnemyCarView!
    var carMovementGestureRecognizer: UILongPressGestureRecognizer!
    var animationTimer: NSTimer!
    var updateTimer: NSTimer!
    var playing = false
    var points = 0
    var level = 1
    var updateRate = 0.05
    var difficutly = 0.0
    var gameSpeed = 2.5
    
    // iPhone 6p border
    var leftBorder = 58
    var rightBorder = 298
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        road.addDriveAnimation()
        soundManager.startLoopingSound(kSoundBackgroundMusic, volume: 0.5)
        
        initGame()
    }
    
    func initGame() {
        soundManager.startLoopingSound(kSoundCar, volume: 0.1)
        
        playing = true
        difficutly = 0.0
        gameSpeed = 2.5
        level = 1
        points = 0
        levelLabel.text = "\(level)"
        pointsLabel.text = "\(points)"
        
        player = UIImageView(image: UIImage(named: "car"))
        player.frame = CGRectMake(0, 0, 60, 91)
        player.frame.origin.y = self.view.bounds.height - player.frame.size.height - 10
        player.center.x = CGRectGetMidX(self.view.bounds)
        self.view.insertSubview(player, aboveSubview: road)
        
        carMovementGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "playerPressed:")
        carMovementGestureRecognizer.minimumPressDuration = 0.001
        road.addGestureRecognizer(carMovementGestureRecognizer)
        
        addEnemy()
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(updateRate), target: self, selector: "update:", userInfo: nil, repeats: true)
    }
    
    func addEnemy() {
        if playing {
            var randomEnemyFrame = CGRectMake(0, -player.frame.size.height, player.frame.size.width, player.frame.size.height)
            let randomX = leftBorder + random() % rightBorder
            randomEnemyFrame.origin.x = CGFloat(randomX)
            
            enemy = EnemyCarView(frame: randomEnemyFrame)
            enemy.addPoluteAnimation()
            self.view.insertSubview(enemy, aboveSubview: road)
            
            UIView.animateWithDuration(NSTimeInterval(gameSpeed), delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.enemy.frame.origin.y = self.view.bounds.height + self.enemy.frame.height
                }) { (success: Bool) -> Void in
                    if self.playing {
                        self.points += 1
                        self.pointsLabel.text = "\(self.points)"
                        self.soundManager.playSound(kSoundSuccess)
                    }
                    
                    self.enemy.removeFromSuperview()
                    self.addEnemy()
            }
        }
    }
    
    func playerPressed(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Ended {
            if animationTimer != nil {
                animationTimer.invalidate()
            }
        }else if recognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = recognizer.locationInView(road)
            if touchPoint.x > CGRectGetMidX(road.frame) {
                animationTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.005), target: self, selector: "moveCar:", userInfo: "right", repeats: true)
            }else {
                animationTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.005), target: self, selector: "moveCar:", userInfo: "left", repeats: true)
            }
        }
    }
    
    func moveCar(timer: NSTimer) {
        if let direction = timer.userInfo as! String! {
            var playerFrame = player.frame
            if direction == "right" {
                if playerFrame.origin.x < CGFloat(rightBorder) {
                    playerFrame.origin.x += 2
                }
            }else {
                if playerFrame.origin.x > CGFloat(leftBorder) {
                    playerFrame.origin.x += -2
                }
            }
            player.frame = playerFrame
        }
    }
    
    func update(timer: NSTimer) {
        // LevelUpdate
        if difficutly < 20 {
            difficutly += updateRate
        }else {
            difficutly = 0.0
            if gameSpeed > 0.5 {
                level += 1
                levelLabel.text = "\(level)"
                gameSpeed -= 0.5
            }
        }
        
        // Hittest
        if CGRectIntersectsRect(player.layer.presentationLayer().frame, enemy.layer.presentationLayer().frame) {
            endGame()
        }
    }
    
    func endGame() {
        soundManager.playSound(kSoundBoom)
        soundManager.stopLoopingSound(kSoundCar)
        
        enemy.layer.removeAllAnimations()
        updateTimer.invalidate()
        playing = false
        
        let explosion = ExplosionView(frame: CGRectMake(0, 0, 150, 150))
        explosion.center = CGPointMake(enemy.center.x, enemy.center.y - 250)
        explosion.contentMode = .Center
        
        self.view.insertSubview(explosion, aboveSubview: player)
        enemy.removeFromSuperview()
        player.removeFromSuperview()
        
        explosion.addExplodeAnimation { (success: Bool) -> Void in
            let alert = UIAlertController(title: "Game Over", message: "Do you want to play again?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default, handler: { (alertAction: UIAlertAction!) -> Void in
                self.initGame()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            explosion.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


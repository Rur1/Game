//
//  Character.swift
//  Game
//
//  Created by 瑠璃 on 2019/04/14.
//  Copyright © 2019 瑠璃. All rights reserved.
//

import UIKit
import UserNotifications

class Character {
    
    var viewFrame: CGRect!
    var imageView: UIImageView!
    var label: UILabel!
    var button: UIButton!
    
    var timer: Timer!
    
    var image: UIImage!
    var cgRect: CGRect!
    var x = 64
    var y = 0
    var i = 0
    
    var speed: CGFloat = -5
    
    var stomach: Int = 100 {
        willSet(newValue) {
            if newValue < 1 {
                let content = UNMutableNotificationContent()
                content.title = "title"
                content.body = "body"
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request)
            }
        }
    }
    
    init(_viewFrame: CGRect, _imageView: UIImageView, _label: UILabel, _button: UIButton) {
        viewFrame = _viewFrame
        imageView = _imageView
        label = _label
        label.text = "満腹"
        button = _button
        button.isEnabled = false
        image = UIImage(named: "1345010301.png")
        cgRect = CGRect(x: x * i, y: y, width : 64, height: 64)
        imageView.image = image.cropping(_image: image, _cgRect: cgRect)
    }
    
    func update() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(characterUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func characterUpdate() {
        setImage()
        if stomach > 0 {
            move()
            stomach -= 5
        }
        setText()
        
        button.isEnabled = false
        if stomach < 1 {
            button.isEnabled = true
        }
    }
    
    func setImage() {
        x = 64
        y = 0
        i += 1
        i = i % 2
        if stomach < 1 {
            x = 384
            y = 320
            i = 1
        }
        cgRect = CGRect(x: x * i, y: y, width : 64, height: 64)
        imageView.image = image.cropping(_image: image, _cgRect: cgRect)
    }
    
    func move() {
        var frame = imageView.frame
        frame.origin.x += speed
        moveLeft(_frame: frame)
        moveRight(_frame: frame)
        imageView.frame = frame
    }
    
    func moveLeft(_frame: CGRect) {
        let _frame = _frame
        if _frame.origin.x < 0 {
            speed = 10
            imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    func moveRight(_frame: CGRect) {
        let _frame = _frame
        if _frame.origin.x > viewFrame.maxX - imageView.frame.width {
            speed = -10
            imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func setText() {
        label.text = "満腹"
        if stomach < 50 {
            label.text = "普通"
        }
        if stomach < 1 {
            label.text = "空腹"
        }
    }
    
    func setStomach(_stomach: Int) {
        stomach = _stomach
    }
    
}

extension UIImage {
    
    func cropping(_image: UIImage, _cgRect: CGRect) -> UIImage {
        let cgImage = _image.cgImage!.cropping(to: _cgRect)
        let image = UIImage(cgImage: cgImage!)
        return image
    }
    
}

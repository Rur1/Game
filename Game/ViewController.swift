//
//  ViewController.swift
//  Game
//
//  Created by 瑠璃 on 2019/04/07.
//  Copyright © 2019 瑠璃. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        character = Character(_viewFrame: view.frame, _imageView: imageView, _label: label, _button: button)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        character.update()
    }
    
    @IBAction func touch(_ sender: UIButton) {
        character.setStomach(_stomach: 100)
    }
    
}

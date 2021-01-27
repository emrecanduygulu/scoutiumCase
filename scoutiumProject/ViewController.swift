//
//  ViewController.swift
//  scoutiumProject
//
//  Created by emre can duygulu on 23.01.2021.
//  Copyright © 2021 emre can duygulu. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig
import Network



class ViewController: UIViewController {
    
    
    @IBOutlet weak var text: UILabel!
    
    @IBOutlet weak var dino: UIImageView!
    
    @IBOutlet weak var noCon: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func isPressed(_ sender: Any) {
        checkInt()
        
    }
    
    var timer = 3
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        checkInt()
        
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        
    }
    
    var monitor = NWPathMonitor()
    func checkInt() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                
                self.noCon.isHidden = true
                self.dino.isHidden = true
                self.button.isHidden = true
                
                self.setupRemoteConfigDefaults()
                self.fetchRemoteConfig()
                self.displayNewValues()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    let nextVC = self.storyboard?.instantiateViewController(identifier: "second_vc") as! secondView
                    let navController = UINavigationController(rootViewController: nextVC)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true)
                    
                }
                
                
            } else {
                
                self.noCon.isHidden = false
                self.dino.isHidden = false
                self.button.isHidden = false
                self.text.isHidden = true
                print("No connection.")
                
            }
            
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    func setupRemoteConfigDefaults() {
        let defaultValue = ["text": " " as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }

    func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else { return }
            remoteConfig.activate()
            
            self.displayNewValues()
        }
    }
    
    func displayNewValues() {
        let newLabelText = remoteConfig.configValue(forKey: "text").stringValue ?? ""
        text.text = newLabelText

    }
}

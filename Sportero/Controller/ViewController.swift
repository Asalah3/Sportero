//
//  ViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 01/05/2023.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var splashScreen: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        splashScreen.contentMode = .scaleAspectFit
        splashScreen.loopMode = .loop
        splashScreen.play()
        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
    }

    @objc func navigate(){
        let sportsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController
        sportsViewController?.modalTransitionStyle = .crossDissolve
        sportsViewController?.modalPresentationStyle = .fullScreen
        self.present(sportsViewController!, animated: true)
    }

}


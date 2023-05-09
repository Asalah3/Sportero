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
        if #available(iOS 13.0, *){
            let appDelegate = UIApplication.shared.windows.first
           if UserDefaults.standard.darkMode {
                appDelegate?.overrideUserInterfaceStyle = .dark
                splashScreen.contentMode = .scaleAspectFit
                splashScreen.loopMode = .loop
                splashScreen.play()
                Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
                return
            }else{
                appDelegate?.overrideUserInterfaceStyle = .light
                splashScreen.contentMode = .scaleAspectFit
                splashScreen.loopMode = .loop
                splashScreen.play()
                Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
                return
            }
        }
        
        
    }

    @objc func navigate(){
        
        if UserDefaults.standard.hasOnboarded {
            let sportsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController
            sportsViewController?.modalTransitionStyle = .crossDissolve
            sportsViewController?.modalPresentationStyle = .fullScreen
            UserDefaults.standard.hasOnboarded = true
            self.present(sportsViewController!, animated: true)
        }else{
            let onBoardingViewController = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingViewController") as? OnBoardingViewController
            onBoardingViewController?.modalTransitionStyle = .crossDissolve
            onBoardingViewController?.modalPresentationStyle = .fullScreen
            self.present(onBoardingViewController!, animated: true)
        }
        
    }

}


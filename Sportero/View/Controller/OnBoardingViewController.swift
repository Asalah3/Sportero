//
//  OnBoardingViewController.swift
//  Sportero
//
//  Created by Asalah Sayed on 09/05/2023.
//

import UIKit

class OnBoardingViewController: UIViewController {
    var slides : [OnBoardingSlide] = [
        OnBoardingSlide(description: "Sportero let You Watch Leagues , In Each League You Can Watch UpComing Events ,Latest Result and Teams", image: UIImage(named: "sportero")!),
        OnBoardingSlide(description: "You Can Add Teams Or Players To Favourite ", image: UIImage(named: "background")!)]
    
    var currentPage = 0 {
        didSet {
            pagrControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                skipButton.setTitle("Get Started", for: .normal)
            }else{
                skipButton.setTitle("Next", for: .normal)
            }
        }
    }
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagrControl: UIPageControl!
    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func skipButton(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let sportsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController
            sportsViewController?.modalTransitionStyle = .crossDissolve
            sportsViewController?.modalPresentationStyle = .fullScreen
            UserDefaults.standard.hasOnboarded = true
            self.present(sportsViewController!, animated: true)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
extension OnBoardingViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
        cell.setUp(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

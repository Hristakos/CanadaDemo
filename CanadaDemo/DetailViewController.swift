//
//  DetailViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 24/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabele: UILabel!
    
    var screenTitle : String?
    var landscapeImageView = UIImageView()
    var portraitImageView = UIImageView()
    var image : UIImage?
    var descriptionLabelText : String?
    var isLandscapedloaded = false
    var isPortraitLoaded = false
    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.image = image!
        detailImageView.clipsToBounds = true
        detailImageView.contentMode = .scaleAspectFit
        detailDescriptionLabele.text = descriptionLabelText!
        
        // Do any additional setup after loading the view.
        // Check orientation
//        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
//            loadLandscapeScreen()
//
//        }
//        else if UIDevice.current.orientation == .portrait {
//            loadPortraitScreen()
//        }
  

        
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
//
//        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
//            // check if portrait is loaded
//            if isPortraitLoaded == true{
//                unloadPortraitScreen()
//            }
//            if isLandscapedloaded != true
//            {
//                loadLandscapeScreen()
//
//            }
//        }
//        else if UIDevice.current.orientation == .portrait {
//            if isLandscapedloaded == true{
//                unloadLandscapeScreen()
//            }
//            if isPortraitLoaded != true
//            {
//                loadPortraitScreen()
//
//            }
 //       }
        
    }
    override func viewDidAppear(_ animated: Bool) {
     print("viewDidAppear")

    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadLandscapeScreen(){
        
        // landscpe add imageView and Description label
        // Set constraints to have 30:70 ratio
        // Set navigation bar title
       // navigationItem.title = screenTitle!
        
        landscapeImageView.image = image!
        landscapeImageView.clipsToBounds = true
        landscapeImageView.contentMode = .scaleAspectFit
        
        landscapeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Add imageView to screen
        self.view.addSubview(landscapeImageView)
        
        let leadingImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        
   //     let trailingImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let topImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        let bottomImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let widthImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0)
        
        view.addConstraints([leadingImageViewConstraint,
                             topImageViewConstraint,
          //                   trailingImageViewConstraint,
                             bottomImageViewConstraint,
                             widthImageViewConstraint])
        
        // Add Description Label
        
        descriptionLabel.text = descriptionLabelText!
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(descriptionLabel)
        
        let leadingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: landscapeImageView, attribute: .trailing, multiplier: 1.0, constant: 0)
        
  //      let trailingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let topDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        let bottomDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let widthDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        
        // Add constraints
        view.addConstraints([leadingDescriptionLabelConstraint,
                             topDescriptionLabelConstraint,
                            // trailingDescriptionLabelConstraint,
                             bottomDescriptionLabelConstraint,
                             widthDescriptionLabelConstraint])
        
        // Set flag
        isLandscapedloaded = true
    }
    
    func unloadLandscapeScreen() {
        landscapeImageView.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        isLandscapedloaded = false
    }
    
    func loadPortraitScreen(){
        
        let bannerWidth = view.frame.width
        let bannerHeight = view.frame.height
        
        let bannerX = bannerWidth / 2 - image!.size.width / 2
        let bannerY = bannerHeight / 2 - image!.size.height / 2
        
        portraitImageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        portraitImageView.image = image!
        portraitImageView.contentMode = .scaleAspectFit
        portraitImageView.translatesAutoresizingMaskIntoConstraints = false
        portraitImageView.backgroundColor = UIColor.cyan
        //view.addSubview(portraitImageView)

        let leadingImageViewConstraint = NSLayoutConstraint(item: portraitImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)

        let trailingImageViewConstraint  = NSLayoutConstraint(item: portraitImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)

        let topImageViewConstraint  = NSLayoutConstraint(item: portraitImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)

        let bottomImageViewConstraint  = NSLayoutConstraint(item: portraitImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)

        let widthImageViewConstraint = NSLayoutConstraint(item: portraitImageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 00)
        //
        // Add constraints
        view.addConstraints([leadingImageViewConstraint ,
                             topImageViewConstraint ,
                             trailingImageViewConstraint ,
                             bottomImageViewConstraint]) // widthImageViewConstraint])
        
        
        descriptionLabel.text = descriptionLabelText!
        descriptionLabel.frame.size.height = 100
        descriptionLabel.frame.size.width = 100
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = UIColor.red
        
        view.addSubview(descriptionLabel)
        
        let leadingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let trailingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let topDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        let bottomDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let widthDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
        

        // Add constraints
        view.addConstraints([leadingDescriptionLabelConstraint,
                             topDescriptionLabelConstraint,
                             trailingDescriptionLabelConstraint,
                             bottomDescriptionLabelConstraint,])
            //,widthDescriptionLabelConstraint])
        
        
        isPortraitLoaded = true
    }
    func unloadPortraitScreen(){
        // Remove portrait screen
        portraitImageView.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        isPortraitLoaded = false
    }

}

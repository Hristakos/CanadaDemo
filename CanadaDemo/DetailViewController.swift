//
//  DetailViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 24/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var screenTitle : String?
    var landscapeImageView = UIImageView()
    var image : UIImage?
    var descriptionLabelText : String?
    var isLandscapedloaded = false
    var isPortraitLoaded = false
    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Check orientation
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            loadLandscapeScreen()
            
        }
        else if UIDevice.current.orientation == .portrait {
            
        }
  

        
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
       
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            // check if portrait is loaded
            if isPortraitLoaded == true{
                unloadPortraitScreen()
            }
            if isLandscapedloaded != true
            {
                loadLandscapeScreen()
                
            }
        }
        else if UIDevice.current.orientation == .portrait {
            if isLandscapedloaded == true{
                unloadLandscapeScreen()
            }
            if isPortraitLoaded != true
            {
                loadPortraitScreen()
                
            }
        }
        
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
        navigationItem.title = screenTitle!
        
        landscapeImageView.image = image!
        landscapeImageView.clipsToBounds = true
        landscapeImageView.contentMode = .scaleAspectFit
        
        landscapeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Add imageView to screen
        self.view.addSubview(landscapeImageView)
        
        let leadingImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        
        let trailingImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let topImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        let bottomImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let widthImageViewConstraint = NSLayoutConstraint(item: landscapeImageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0)
        
        view.addConstraints([leadingImageViewConstraint,
                             topImageViewConstraint,
                             trailingImageViewConstraint,
                             bottomImageViewConstraint,
                             widthImageViewConstraint])
        
        // Add Description Label
        
        descriptionLabel.text = descriptionLabelText!
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(descriptionLabel)
        
        let leadingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: landscapeImageView, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let trailingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let topDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        let bottomDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let widthDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        
        // Add constraints
        view.addConstraints([leadingDescriptionLabelConstraint,
                             topDescriptionLabelConstraint,
                             trailingDescriptionLabelConstraint,
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
        
        isPortraitLoaded = true
    }
    func unloadPortraitScreen(){
        // Remove portrait scree
        isPortraitLoaded = false
    }

}

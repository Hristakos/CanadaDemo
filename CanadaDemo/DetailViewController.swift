//
//  DetailViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 24/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Outlet properties
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
   // var screenTitle : String?
    var landscapeImageView = UIImageView()
    var portraitImageView = UIImageView()
    var image : UIImage?
    var descriptionLabelText : String?
   
    
    // Constraints to handle ipad
    var leadingImageViewConstraint = NSLayoutConstraint()
    var topImageViewConstraint = NSLayoutConstraint()
    var bottomImageViewConstraint = NSLayoutConstraint()
    var widthImageViewConstraint = NSLayoutConstraint()
    var heightImageViewConstraint = NSLayoutConstraint()
    var trailingImageViewConstraint  = NSLayoutConstraint()
    
    var leadingDetailLabelConstraint = NSLayoutConstraint()
    var topDetailLabelConstraint = NSLayoutConstraint()
    var bottomDetailLabelConstraint = NSLayoutConstraint()
    var widthDetailLabelConstraint = NSLayoutConstraint()
    var heightDetailLabelConstraint = NSLayoutConstraint()
    var trailingDetailLabelConstraint  = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Notification observer to notify when orientaation has changed to handle ipad as the class side is wR hR for both orientations
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        detailImageView.image = image!
        detailImageView.clipsToBounds = true
        
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailDescriptionLabel.text = descriptionLabelText!
        
        // Do any additional setup after loading the view.
        // Check orientation to determine how the image is displayed
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            
            detailImageView.contentMode = .scaleAspectFit
            //            loadLandscapeScreen()
            // layout screen for ipad in landscape mode
            if traitCollection.userInterfaceIdiom == .pad{
                ipadLandscapeLayout()
            }
        }
        else if UIDevice.current.orientation == .portrait {
            
            detailImageView.contentMode = .scaleAspectFill
            // layout screen for ipad in portrait mode
            if traitCollection.userInterfaceIdiom == .pad{
                ipadLoadPortrait()
            }
       }
  

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    
    @objc func orientationChanged(notification:NSNotification){
    
        // Check the new orientation and change the imageView to change the way the image is displayed in order to create banner image in portait mode for ipad for iphone constraints have been varied via storyboard traits
        // If Ipad need to load the screen constraints as class size for both orientaions is the same wR hR
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight{
            detailImageView.contentMode = .scaleAspectFit
            // layout screen for ipad in landscape mode
            if traitCollection.userInterfaceIdiom == .pad{
                view.removeConstraints([leadingImageViewConstraint, topImageViewConstraint,
                                        bottomImageViewConstraint,widthImageViewConstraint,heightImageViewConstraint,
                                        trailingImageViewConstraint,leadingDetailLabelConstraint,
                                        topDetailLabelConstraint,bottomDetailLabelConstraint,
                                        widthDetailLabelConstraint,heightDetailLabelConstraint,
                                        trailingDetailLabelConstraint])
                ipadLandscapeLayout()
            }
        }
        else if UIDevice.current.orientation == .portrait{
            detailImageView.contentMode = .scaleAspectFill
            
            // layout screen for ipad in landscape mode
            if traitCollection.userInterfaceIdiom == .pad{
                view.removeConstraints([leadingImageViewConstraint, topImageViewConstraint,
                                        bottomImageViewConstraint,widthImageViewConstraint,heightImageViewConstraint,
                                        trailingImageViewConstraint,leadingDetailLabelConstraint,
                                        topDetailLabelConstraint,bottomDetailLabelConstraint,
                                        widthDetailLabelConstraint,heightDetailLabelConstraint,
                                        trailingDetailLabelConstraint])
                ipadLoadPortrait()
            }
        }

    }
    
    // MARK: - Setting contraints for Ipad dependong on orientaion
    
    func ipadLoadPortrait(){
        
        leadingImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        
//        if #available(iOS 11.0, *) {
//            topImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide.topAnchor, attribute: .top, multiplier: 1.0, constant: 0)
//        } else {
            // Fallback on earlier versions
        topImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20)
        //}
        
        trailingImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        widthImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        heightImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.25, constant: 0)
        
        view.addConstraints([leadingImageViewConstraint,
                             topImageViewConstraint,
                             trailingImageViewConstraint,
                             widthImageViewConstraint,
                             heightImageViewConstraint])
        
        // Add contraints for label

        
        leadingDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: detailImageView, attribute: .leading, multiplier: 1.0, constant: 0)
        
        topDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: detailImageView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
//        bottomDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel , attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
            trailingDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        widthDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        heightDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel , attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.25, constant: 0)
        
        view.addConstraints([leadingDetailLabelConstraint,
                             topDetailLabelConstraint,
                             trailingDetailLabelConstraint,
                             widthDetailLabelConstraint,
                             heightDetailLabelConstraint])
    }
    func ipadLandscapeLayout(){
        
        // Image view constraints

        
        leadingImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        
        topImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        
        bottomImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        widthImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0)
        
        heightImageViewConstraint = NSLayoutConstraint(item: detailImageView , attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
        
        view.addConstraints([leadingImageViewConstraint,
                             topImageViewConstraint,
                             bottomImageViewConstraint,
                             widthImageViewConstraint,
                             heightImageViewConstraint])
        
        // Add contraints for label

        
        leadingDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel , attribute: .leading, relatedBy: .equal, toItem: detailImageView, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        topDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: view , attribute: .top, multiplier: 1.0, constant: 0)
        
        bottomDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel , attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        widthDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel , attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        
        heightDetailLabelConstraint = NSLayoutConstraint(item: detailDescriptionLabel , attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)

        view.addConstraints([leadingDetailLabelConstraint,
                             topDetailLabelConstraint,
                             bottomDetailLabelConstraint,
                             widthDetailLabelConstraint,
                             heightDetailLabelConstraint])
        
    }
}

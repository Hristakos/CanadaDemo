//
//  PhotoCollectionViewCell.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 21/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    // Cell Outlet properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // Property to store row passed in from cell method call displayRow
    var rowToDisplay:Row?

/* This method adds text to titleLabel, Attemptm to create a url string, then url object, creates session object and attemps to download image via dataTask. Then it fires off the task. The image for cell is set to nil when it is loaded in order to make sure we don't get the wrong image with for title as cell may be reused, also check when it fires off dataTask to download the image that the request is still relevant as cell my have dequed again
     
 */
func displayRow(_ row:Row){
    
    //Clear the image in case cell is being reuesed
    imageView.image = nil
    
    // set here so change later to animate the loading of the image
    imageView.alpha = 0
    
    // Set property to keep track of row that needs to be displayed
    rowToDisplay = row
    
    // Display the headline
    titleLabel.text = row.title!

    
    // Create url object
    let urlString = rowToDisplay?.imageHref
    
    // Check if the row has an image
    guard urlString != nil else{
        
        // Assign the default no image avail image to image view and exit
        
        imageView.image = UIImage(named: "no_image_available.jpg")!
        imageView.alpha = 1
        return
    }
    
    
    // Before se the image check if the image has already downloaded in and is in cache
    let cachedImage = CacheManager.retrieveImageData(urlString!)
  
    if cachedImage != nil {
        imageView.image = UIImage(data: cachedImage!)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.imageView.alpha = 1
        }, completion: nil)
        return
    }
    let url = URL(string: urlString!)
    
    // Check that it isn't nil if it is nil set defaut image and return
    guard url != nil else{
        print("Coiuldn't create url object")

        imageView.image = UIImage(named: "no_image_available.jpg")
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.imageView.alpha = 1
        }, completion: nil)
        return
    }
    

    // Here we can set the request time out period setting to 1 sec for now don't know what is reasonable might up it a bit not sure this allows the view to display no image available if the response takes too loang and gives the app the ability to display default no image available
    
    // Need to create URLSessionConfiguration object set yhe timeout interval to 1
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 1.0
    sessionConfig.timeoutIntervalForResource = 60.0
    
    let session = URLSession(configuration: sessionConfig)



    // Create the DataTask
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
        
        // Check if we have data returned and no error
        guard let data = data, error == nil  else {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: "no_image_available.jpg")
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.imageView.alpha = 1
            }, completion: nil)

            }
            return
        }

  
        //Befor setting set the image, ensure that the image data is still relevant to the cell
        if self.rowToDisplay!.imageHref == urlString!{
            
            //Set the image view with data on main thread
            DispatchQueue.main.async {
            
                let image = UIImage(data: data)
                
                // chceck if we have an image created if set the image and store in cache
                if image != nil{
                    self.imageView.image = UIImage(data: data)
                    
                    // Save image to cache
                    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.imageView.alpha = 1
                        }, completion: nil)
                        CacheManager.saveImageData(urlString!, data)
                }
                else{
                    self.imageView.image = UIImage(named: "no_image_available.jpg")
                    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                        self.imageView.alpha = 1
                    }, completion: nil)
                    }
                }
            }
    }

    // Fire the datatask
    dataTask.resume()

}


// This is used to create the cell size based on the layout attributes size if the width is not smaller than the contentview width size don not change.
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
      
        //  print("Title: \(titleLabel.text!)\nlayoutAttributes.frame.size: \(layoutAttributes.frame.size)")
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width if size.width is not less than new frame width
        if ceil(size.width) < newFrame.size.width{
            newFrame.size.width = ceil(size.width)
        }

        newFrame.size.height = ceil(size.height)
//        print("new frame size is \(newFrame.size)")
        layoutAttributes.frame = newFrame

        return layoutAttributes
    }

}




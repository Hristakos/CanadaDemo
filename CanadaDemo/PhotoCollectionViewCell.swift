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


    var rowToDisplay:Row?
    var isUsed : Bool = false

    var cellTitle = ""
 

/* This method adds text to titleLabel, Attemptm to create a url string, then url object, creates session object and attemps to download image via dataTask. Then it fires off the task. The image for cell is set to nil when it is loaded in order to make sure we don't get the wrong image with for title as cell may be reused, also check when it fires off dataTask to download the image that the request is still relevant as cell my have dequed again
     
 */
func displayRow(_ row:Row){
    
    //Clear the image in case cell is being reuesed
    imageView.image = nil
    
    // Set property to keep track of row that needs to be displayed
    rowToDisplay = row
    
    // Display the headline
    titleLabel.text = row.title!
    
    // Display the article image
    
    // Create url object
    let urlString = rowToDisplay?.imageHref
    
    // Check if the row has an image
    guard urlString != nil else{
        print("Coiuldn't create url string")
        return
    }
    
    let url = URL(string: urlString!)
    
    // Check that it isn't nil
    guard url != nil else{
        print("Coiuldn't create url object")
        imageView.image = UIImage(named: "error-1.jpg")
        return
    }
    
    //Get the session
    let session = URLSession.shared
    
    // Create the DataTask
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
        
        
        //Check there is no error and we have data
        if error == nil && data != nil {
        //    let rsp = response! as! HTTPURLResponse
//            if rsp.statusCode != 200 {
//                DispatchQueue.main.async {
//                    self.imageView.image = UIImage(named: "Error.png")
//                    //print(self.imageView.image!.size)
//                    return
//                }
//            }
 //           print("response \(response!)")
  
            //Befor setting set the image, ensure that the image data is still relevant to the title
            if self.rowToDisplay!.imageHref == urlString!{
                //self.reloadInputViews()
                //Set the image view with data
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                    //print(self.imageView.image!.size)
                }
            }
            
        }
        
    }
    
    // Fire the datatask
    dataTask.resume()

}



//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //Exhibit A - We need to cache our calculation to prevent a crash.
//        if !isHeightCalculated {
//            setNeedsLayout()
//            layoutIfNeeded()
//            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//            var newFrame = layoutAttributes.frame
//            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//            layoutAttributes.frame = newFrame
//            isHeightCalculated = true
//        }
//        return layoutAttributes
//    }
    
    
    //
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        print("Title: \(titleLabel.text!)\nlayoutAttributes.frame.size: \(layoutAttributes.frame.size)")
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width if size.width is not less than new frame width
        if ceil(size.width) < newFrame.size.width{
            newFrame.size.width = ceil(size.width)
        }else{
            print("newFrame.size is \(newFrame.size.width) which is lesss that size.width \(size.width)")
            
        }

        newFrame.size.height = ceil(size.height)
        print("new frame size is \(newFrame.size)")
        layoutAttributes.frame = newFrame

        return layoutAttributes
    }

}




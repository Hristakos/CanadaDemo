//
//  ViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    // This will be use when the app is loading json file to give indication that we are loading
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // UICollectionViewFlowLayout instance for collection view to dynamically resize cells
    var flowLayout = UICollectionViewFlowLayout()
    
    // To store image and descriptionto pass to detailView
    var selectedItemImage = UIImage()
    var selectedItemDescripton : String?
    //UICollectionViewDelegateFlowLayout
    
    // collection View outlet property to moodify collection view porperties
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    // Create Model and data object to store data retieved
    var model = DataModel()
    var data = CanadaData()

  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the refresh button to nab bar and disable o load
        addRefreshButtonToNavigationBar()
        navigationItem.rightBarButtonItem?.isEnabled = false
       
        // Assign viewcontroller as delegate and request json data
        model.delegate = self
        
        // Start activity indicator json data may take some time to download and return to view
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        //Retrieve json feed data from the model
        model.getRemoteJsonData()
    
        // Set delegate properties
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Set the flow layout for collection view to display images
        setFlowLayoutForColletionView()

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the item to display which the user tapped on
        let indexPath = collectionView.indexPathsForSelectedItems
        
        // Check if we have a selection
        guard indexPath != nil else {
            print("user didn't select item")
            return
        }
        
        // create item row object to store
        let item = data.rows![(indexPath?.first?.row)!]
        
        // Get reference to the DetailViewController
        let detailVC = segue.destination as! DetailViewController
        
        // set the  property of DetailViewController
        detailVC.navigationItem.title = item.title!
        
        // Assign the selected image and descriptoin text of Detail View Controller
        detailVC.image = selectedItemImage
        detailVC.descriptionLabelText = selectedItemDescripton!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    // MARK:- Collection View Methods
    
    func setFlowLayoutForColletionView(){
        // Set the flow layout to determine estimated size for the cell based on orientation for iphone and ipaad
       
        // Check if landscape orientation
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            
            
            // Check if iphone or ipad
            if traitCollection.userInterfaceIdiom == .phone{
                flowLayout.minimumInteritemSpacing = 10 // (using 10 for now)
                flowLayout.minimumLineSpacing = 10 // (using 10 for now)
                
                flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width  * 0.5, height:collectionView.frame.size.height)
                collectionView.setCollectionViewLayout(flowLayout, animated: true)
            }
                else if traitCollection.userInterfaceIdiom == .pad{
                    flowLayout.minimumInteritemSpacing = 10 // (using 10 for now)
                    flowLayout.minimumLineSpacing = 10 // (using 10 for now)
                
                    flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width  * 0.5, height:collectionView.frame.size.height)
                    collectionView.setCollectionViewLayout(flowLayout, animated: true)
            }
        }
            // Check if portrail orientation
        else if (UIDevice.current.orientation == .portrait ){
            
            // check if iphone or ipad
            if traitCollection.userInterfaceIdiom == .phone{
                flowLayout.minimumInteritemSpacing = 10 // (using 10 for now)
                flowLayout.minimumLineSpacing = 10 // (uisng 10 for now)
                flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width -
                    40 , height:collectionView.frame.size.height * 0.35)
                collectionView.setCollectionViewLayout(flowLayout, animated: true)
            }
            else if traitCollection.userInterfaceIdiom == .pad{
                flowLayout.minimumInteritemSpacing = 10 // (using 10 for now)
                flowLayout.minimumLineSpacing = 10 // (uisng 10 for now)
                flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width -
                    120 , height:collectionView.frame.size.height * 0.35)
                collectionView.setCollectionViewLayout(flowLayout, animated: true)
            }
            
        }
        
        
    }
}

extension ViewController : DataModelProtocol{
    // MARK: - DataModelProtocol methods
    
    func dataRetrieved(data: CanadaData) {
        
        // Set the data property once the mode returns parsed data from json file
        self.data.rows = data.rows!
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.title = data.title!
        
        // reload collerction view
        collectionView.reloadData()
        
        // Stop activity indicator data has been retieved
        activityIndicator.stopAnimating()
        print("Number of rows in file \(self.data.rows!.count)")
  
    }
    
    
}
    
    // MARK: - CollectionViewProtocol methods

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        //check if we have data first (downlaod takes time may be nil when we are here)
        if data.rows != nil {
            return data.rows!.count
            
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //      collectionView.invalidateIntrinsicContentSize()
        
        // Craete a cell that is of custom class PhotoColectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        // display cell details for row using current index path
        cell.displayRow(data.rows![indexPath.row])
        
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        //set selected image to pass to detailVC when prepare segue is called
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        
        if selectedCell.imageView.image != nil{
            selectedItemImage = selectedCell.imageView.image!
        }
        else{
            // Show a default image indicting no image available
            selectedItemImage = UIImage(named: "no_image_available.jpg")!
        }
        
        // set selected description to pass
        if data.rows![indexPath.row].description != nil{
            selectedItemDescripton = data.rows![indexPath.row].description!
        }else{
            selectedItemDescripton = "No description available"
        }
        
        // Transition to Detail View Controller
        performSegue(withIdentifier: "segueToDetail", sender: self)
        
    }
    
    
    // MARK: - Refresh button for navigation bar
    
    func addRefreshButtonToNavigationBar(){
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshTapped))
        
        navigationItem.rightBarButtonItem = refreshButton
        
    }
    
    // Here we want to download json data again from he feed
    
    @objc func refreshTapped(){

        
        // Show activity indicator
        activityIndicator.startAnimating()
        
        // Get Json Data
        model.getRemoteJsonData()

    }
}

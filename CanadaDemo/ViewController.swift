//
//  ViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // UICollectionViewFlowLayout instance for collection view to dynamically resize cells
    var flowLayout = UICollectionViewFlowLayout()
    // To store image to pass to detailView
    var selectedItemImage = UIImage()
    var selectedItemDescripton : String?
    //UICollectionViewDelegateFlowLayout
    
    // collection View outlet property to moodify collection porperties
    @IBOutlet weak var collectionView: UICollectionView!

    
    // Create Model and data object to store data retieved
    var model = DataModel()
    var data = CanadaData()

  
    override func viewDidAppear(_ animated: Bool) {
 
    }
    override func viewDidLayoutSubviews() {

    }
    
    override func viewWillAppear(_ animated: Bool) {


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Assign viewcontroller as delegate and request json data
        model.delegate = self
        
        // Start activity indicator json data may take some time to download and return to view
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        //Retrieve json feed data from the model
        //model.getRemoteJsonData()

        model.getLocalJsonFile()
        


        
        //model.GetJson()
        // Set delegate properties
        collectionView.delegate = self
        collectionView.dataSource = self
        setFlowLayoutForColletionView()
        addRefreshButtonToNavigationBar()
        

        

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the item to display which the user tapped on
        let indexPath = collectionView.indexPathsForSelectedItems
        
        guard indexPath != nil else {
            
            print("user didn't select item")
            return
        }
        
        let item = data.rows![(indexPath?.first?.row)!]
        
        // Get reference to the DetailViewController
        let detailVC = segue.destination as! DetailViewController
        
        // set the  property of DetailViewController
        
        detailVC.navigationItem.title = item.title!
        
        detailVC.image = selectedItemImage
        detailVC.descriptionLabelText = selectedItemDescripton!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    // MARK:- Collection View Methods
    
    func setFlowLayoutForColletionView(){
        // Set the flow layout to determine estimated size for the cell based on orientation for iphone at the momment
       
        // Check if landscape orientation
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            
            // TODO: - Ipad
            // Check if iphone
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
            
            // check if iphone
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
        //set selected image to pass to detailVC
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        
        if selectedCell.imageView.image != nil{
            selectedItemImage = selectedCell.imageView.image!
        }
        else{
            // Show a default image indicting no image available
            selectedItemImage = UIImage(named: "error-1.jpg")!
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
    // MARK: - Refresh button 
    func addRefreshButtonToNavigationBar(){
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshTapped))
        
        navigationItem.rightBarButtonItem = refreshButton
        
    }
    @objc func refreshTapped(){
        // Here we want to download json data again but because I am working locally cant't get fresh data as the file is already loaded in project. but I think it works
        
        // Show activity indicator
        activityIndicator.startAnimating()
        
        model.getLocalJsonFile()

        
    }
}

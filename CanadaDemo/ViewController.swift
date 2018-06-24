//
//  ViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    
    // UICollectionViewFlowLayout instance for collection view to dynamically resize cells
    var flowLayout = UICollectionViewFlowLayout()

    //UICollectionViewDelegateFlowLayout
    
    // collection View outlet property to moodify collection porperties
    @IBOutlet weak var collectionView: UICollectionView!

    
    // Create Model and data object to store data retieved
    var model = DataModel()
    var data = CanadaData()

    // Set flowLayout here for now
    override func viewDidAppear(_ animated: Bool) {
        
        setFlowLayoutForColletionView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign viewcontroller as delegate and request json data
        model.delegate = self
        
        //Retrieve json feed data from the model
        //model.getRemoteJsonData()
        model.getLocalJsonFile()
        
        // Set delegate properties
        collectionView.delegate = self
        collectionView.dataSource = self

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
        }
            // Check if portrail orientation
        else if (UIDevice.current.orientation == .portrait ){
            
            // check if iphone
            if traitCollection.userInterfaceIdiom == .phone{
                flowLayout.minimumInteritemSpacing = 10 // (using 10 for now)
                flowLayout.minimumLineSpacing = 10 // (uisng 10 for now)
                flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width , height:collectionView.frame.size.height * 0.35)
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

        // reload collerction view
        collectionView.reloadData()
        
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
}

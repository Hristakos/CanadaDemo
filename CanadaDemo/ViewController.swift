//
//  ViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataModelProtocol,UICollectionViewDelegate,UICollectionViewDataSource{


    
    @IBOutlet weak var collectionView: UICollectionView!

    
    // Create Model and data object to store data retieved
    var model = DataModel()
    var data = CanadaData()
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.estimatedItemSize = CGSize(width: 300, height: 200)


        
       collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    // MARK: - DataModelProtocol methods
    
    func dataRetrieved(data: CanadaData) {
        self.data = data
        
        print("Number of rows in file \(self.data.rows!.count)")
        
        
        
    }
    
    // MARK: - CollectionViewProtocol methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.rows!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.backgroundColor = UIColor.cyan
        
        cell.imageView.image = nil
        
        var url = URL(string: "")
        if (data.rows?[indexPath.row].imageHref)! != "" {
            url = URL(string: (data.rows?[indexPath.row].imageHref)!)!
            DispatchQueue.main.async {
                cell.imageView.load(url: url!)
            }
//            if let cellSize = cell.imageView.image?.size{
//                cell.frame.size = cellSize
//            }
            
            
        }
        
        
//        cell.translatesAutoresizingMaskIntoConstraints = false
//        cell.stackView.translatesAutoresizingMaskIntoConstraints = false
//        cell.titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        cell.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        

        //cell.imageView.image = imageView.image
        // Set the properties of cell to display the data from the feed
        // TODO: - Download image from url
        cell.titleLabel.text = data.rows?[indexPath.row].title
        
       // print(cell.frame.width)
       // print(cell.titleLabel.frame.width)
        
        return cell
    }
    


}



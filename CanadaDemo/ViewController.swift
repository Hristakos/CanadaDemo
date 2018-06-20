//
//  ViewController.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataModelProtocol{

    var model = DataModel()
    var data = CanadaData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Assign viewcontroller as delegate and request json data
        model.delegate = self
        //model.getRemoteJsonData()
        model.getLocalJsonFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - DataModelProtocol methods
    
    func dataRetrieved(data: CanadaData) {
        self.data = data
        print(self.data.title!)
    }
}


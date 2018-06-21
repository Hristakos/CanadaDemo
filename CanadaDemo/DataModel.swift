//
//  DataModel.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import Foundation

protocol DataModelProtocol{
    func dataRetrieved(data:CanadaData)
}

class DataModel {
    
    var delegate:DataModelProtocol?
    
    func getLocalJsonFile(){
        
        // get a path to the json file in our app bundle
        let path = Bundle.main.path(forResource: "canada", ofType: ".json")
        
        // make sure we have a path
        guard path != nil else{
            print("Can't find the json file")
            return
        }
        
        // Create a URL object from that string path
        let url = URL(fileURLWithPath: path!)
        
        // Decode the data into instances of the Question struct
        do {
            // get the data from that URL
            let data = try Data(contentsOf: url)
            
            //Decode the JSON data
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CanadaData.self, from: data)
            
            // Handle cases of null values from JSON file
            var cleanData = CanadaData()
            cleanData = cleanJsonData(rawData: decodedData)
            //Return the question struts to the view controller
            delegate?.dataRetrieved(data: cleanData)
        }
        catch{
            
            print("Couldn't create Data from object from file!")
        }
        
        
    }
    
    func getRemoteJsonData(){
        
        // Create url object from string
        let stringUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        let url = URL(string: stringUrl)
        
        // check we have url object
        guard url != nil else{
            print("couldn't get a url object")
            //TODO: show alert msg
            return
        }
        // Create session object
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil{
                // Create decoder object
                let decoder = JSONDecoder()
                //TODO:- Not able to decode data from network maybe security settings
                do {
                    let decodedData = try decoder.decode(CanadaData.self, from: data!)
                    //print(decodedData.title!)
                    
                    // Handle cases of null values from JSON file
                    var cleanData = CanadaData()
                    cleanData = self.cleanJsonData(rawData: decodedData)
                    
                    // Notify the view controller with the results by passing the data to on main thread
                    DispatchQueue.main.async {
                        
                        self.delegate?.dataRetrieved(data: cleanData)
                    }
                }catch{
                    print("couldn't parse json")
                }
                
            }
        }
        dataTask.resume()
    }
    
    func cleanJsonData(rawData:CanadaData) -> CanadaData {
        
        var cleanData = CanadaData(title: "", rows: [Row]())
        
        //Loop though each element of the data and replace any Null values check if entire element has null values remove from data
        for i in 0...(rawData.rows?.count)! - 1{
           
            
            var title = rawData.rows![i].title
            var description = rawData.rows![i].description
            var imageHref = rawData.rows![i].imageHref


            // Check at least 1 element has a value, if so check each value and replace invalid vaues to avoid a crash

            if title != nil || description != nil || imageHref != nil {
                if title == nil {
                    title = ""
                }
                if description == nil {
                    description = ""
                }
                if imageHref == nil {
                    imageHref = ""
                }
                
                // Add element
                cleanData.rows?.append(Row(title: title, description: description, imageHref: imageHref))
                
            }
        
        }
        return cleanData
    }
    
}

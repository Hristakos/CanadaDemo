//
//  DataModel.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import Foundation

/* The Data Model is designed to download data from a url which is in json format. Once data object s creaed it will the check for valid entries and return the data back to view that set itself as the delegate
 
 */

// Protocol used to communicate between model and view when retrieving JSON data from feed and returning back in CanaData structure
protocol DataModelProtocol{
    func dataRetrieved(data:CanadaData)
}

class DataModel {
    

    // delegate property for view to assign itself to
    var delegate:DataModelProtocol?
    

    // This method uses a local json and decodes the json data I used this for my development and testing as I had a lot of trouble reading the dowloaded data from serever.
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
    
    // retrieves JSON data from server and parse data using JSONDecoder and CanaData Struct returns data via protocol to the delegate via dataRetrieved(data:CanadaData)
    
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
        
        // Create a DataTask Object

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//            print(response!.description)
//            print(response!.textEncodingName == "iso-8859-1")
            
            // Check if we have no error and data returned
            if error == nil && data != nil{
            
                // Here we convert data returned to a string thas is readable. The data returned uses so-8859-1 encoding need to convert to utf8
                let responseString = NSString(data: data!, encoding: String.EncodingConversionOptions.allowLossy.rawValue)
                let s = responseString! as String
                
                // Create Data object to use to parse json data
                let d = Data(s.utf8)
                
                // print("Response: \(String(describing: responseString))")
                
                // Create decoder object
                let decoder = JSONDecoder()


                do {
                    // Decode the json data to CanadaData Data struct
                    let decodedData = try decoder.decode(CanadaData.self, from: d)

                    // Handle cases of null values from JSON file perofom cleand data and will remove any entries that have null for all 3 values title,description,imagehref
                    
                    var cleanData = CanadaData()
                    cleanData = self.cleanJsonData(rawData: decodedData)

                    // Notify the view controller with the results by passing the data to on main thread back to the delegate
                    DispatchQueue.main.async {
                        self.delegate?.dataRetrieved(data: cleanData)
                    }
                }
                catch{
                    print("couldn't parse json error = \(error.localizedDescription)")

                }
            }
        }
        
        // Fire off the task
        dataTask.resume()
    }
    
    // This function looks at the data specificall each Row struct in the array aretrieved from jason decoder and checks for invalid entries like null if all 3 values title , desription, imageHref are null will remove from Json file

    func cleanJsonData(rawData:CanadaData) -> CanadaData {
        
        var cleanData = CanadaData(title: "", rows: [Row]())
        
        //Loop though each element of the data and replace any Null values check if entire element has null values remove from data
        
        for i in 0...(rawData.rows?.count)! - 1{
            cleanData.title = rawData.title
            var title = rawData.rows![i].title
            var description = rawData.rows![i].description
            var imageHref = rawData.rows![i].imageHref
            
            // Check at least 1 element has a value, if so check each value and replace invalid vaues to avoid a crash
            
            if title != nil || description != nil || imageHref != nil {
                if title == nil {
                    title = "No title"
                }
                if description == nil {
                    description = "No Description"
                }
                if imageHref == nil {
                    imageHref = ""
                }

                // Add element to clean data for return
                cleanData.rows?.append(Row(title: title, description: description, imageHref: imageHref))
                
            }
        
        }
        return cleanData
    }
    
 
}

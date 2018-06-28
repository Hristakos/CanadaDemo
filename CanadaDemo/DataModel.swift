//
//  DataModel.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 20/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import Foundation

/*
 
 */

// Protocol used to communicate between model and view when retrieving JSON data from feed and returning back in CanaData structure
protocol DataModelProtocol{
    func dataRetrieved(data:CanadaData)
}

class DataModel {
    

    // delegate property for view to assign itself to
    var delegate:DataModelProtocol?
    
    /*  NOTES: Using this method at the momment having problems decode data from server. Data is download unable to parse JSON using same line of code that works from local file in project need to investigate further have created jsondata.swift to compare data but need to understand further. Might try and parse data retrieved pre swift 4 if it makes a difference ?????
     */
    
    // retrieved JSON data from local file (stored in project) and parse data using JSONDecoder and CanaData Struct returns data via protocol to the delegate via dataRetrieved(data:CanadaData)

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
            
            
//            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//            // data is 3108 bytes
//
//            let rows = json!["rows"] as? [NSDictionary]
//            print("number of rows = ", rows!.count)
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
        
        // Create a DataTask Object

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            print(response!.description)
            print(response!.textEncodingName == "iso-8859-1")
            
            
            
            if error == nil && data != nil{
            
                let responseString = NSString(data: data!, encoding: String.EncodingConversionOptions.allowLossy.rawValue)
                
                print("Response: \(String(describing: responseString))")
                
                // Create decoder object
                let decoder = JSONDecoder()
                //JSONSerialization.ReadingOptions =
                let s = responseString! as String
                let d = Data(s.utf8)
                //TODO:- Not able to decode data from network maybe security settings
                // When download file data is 3107 bytes from local its 3108 ???
                do {
                    // Data returned is not valid
                    //JSONSerialization.i
                    print("is vallid JSON data = \(JSONSerialization.isValidJSONObject(d)) ")
                    
                    let decodedData = try decoder.decode(CanadaData.self, from: d)
//                   let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                    let title = json!["title"] as? String
                    // Handle cases of null values from JSON file
                    var cleanData = CanadaData()
                    cleanData = self.cleanJsonData(rawData: decodedData)

                    // Notify the view controller with the results by passing the data to on main thread
                    DispatchQueue.main.async {
                        self.delegate?.dataRetrieved(data: cleanData)
                    }
                }
                catch{
                    print("couldn't parse json error = \(error.localizedDescription)")
                    print(data!.base64EncodedString())
                }
            }
        }
        
        // Fire off the task
        dataTask.resume()
    }
    
    // This function look at the data retrieved from jason decoder and check for invalid entries like null and removed any invalid entries
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
                print("row tile in clean data = \(title)")
                // Add element to clean data for return
                cleanData.rows?.append(Row(title: title, description: description, imageHref: imageHref))
                
            }
        
        }
        return cleanData
    }
    
    func GetJson(){
    //--------set URL --------//
    let myUrl = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json");
    var request = URLRequest(url:myUrl!)
    request.httpMethod = "POST"
    let postString = "";
    request.httpBody = postString.data(using: String.Encoding.utf8);
    let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
    if error != nil
    {
    print("error=\(error!)")
    return
    }
    // You can print out response object
    print("response = \(response!)")
    
    do {
    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
    //print("json", (json?.allKeys.debugDescription))
    if let parseJSON = json {
    // Now we can access value of latiutde
    //let latitude= parseJSON["latitude"] as? String //<---- Here , which i need latitude value
        print("in parse JSON", parseJSON)
    }
    } catch {
    print("error in catch ",error)
    }
    }
    task.resume()
    }
}

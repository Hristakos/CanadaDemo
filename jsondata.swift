//
//  jsondata.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 23/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import Foundation
/*
 
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
 let sessionConfig = URLSessionConfiguration.default
 let configuration = URLSessionConfiguration.ephemeral
 
 let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
 sessionConfig.timeoutIntervalForRequest = 1.0
 //sessionConfig.timeoutIntervalForResource = 60.0
 // sessionConfg.
 // sessionConfig.networkServiceType = .default
 // sessionConfig.isDiscretionary
 
 var request = URLRequest(url: url!)
 request.httpMethod = "GET"
 request.networkServiceType = .default
 //     request.allHTTPHeaderFields   =
 //        ["Content-Type": "application/json; charset=UTF-8; ISO-8859-1;utf-8; " ,"Accept-Encoding":"gzip"]
 
 
 
 
 print("session config default = ", sessionConfig.description)
 //let session = URLSession(configuration: sessionConfig)
 session.dataTask(with: request) { (data, resp, error) in
 let urlrsp = resp as? HTTPURLResponse
 
 
 let newdata = data!.base64EncodedString().utf16
 
 //
 ////            print (urlrsp)
 ////            String utf_decode(data!as?String)
 ////            var b = [UInt8]()
 ////            var x = 0
 ////            while x <= data!.count - 1{
 ////
 ////                b.append((a.popFirst())!)
 ////                x += 1
 ////            }
 //                let serverAns = data?.base64EncodedData().base64EncodedData(options: .endLineWithCarriageReturn)
 //
 //            var readBytes = 1
 //            var c = 0
 //            var i = 0
 //
 //            var newString = ""
 //            while readBytes <= b.count{
                 let truncatedServerAns = b[c..<readBytes]
                 let tsaData = Data(bytes: truncatedServerAns)
 
                 newString += String(data: tsaData, encoding: .utf8)!
                 print("newString : *****\(newString)***** ", newString)
                 c += 1
                 readBytes += 1
 //                i += 1
 ////                print("tsaData at \(i) = \(tsaData)")
 ////                switch i {
 ////                case : 2642; do {
 ////                        readBytes += 1
 ////                        c += 1
 ////                    }
 ////                    default
 ////                    print("do nothing")
 ////                    }
 //                }
 //
 ////                    print("newString=\(String( describing: newString))")
 ////                    var y = 1
 ////                    let newstartindex = y + c
 ////                    let newendindex = readBytes + y
 ////                    while y <= 64{
 ////                        let truncatedServerAns = b[newstartindex..<newendindex]
 ////                        let tsaData = Data(bytes: truncatedServerAns)
 ////                        newString += String(data: tsaData, encoding: .utf8)!
 ////
 ////                        y += 1
 ////                    }
 ////                }
 //            }
 //            print("newString=\(String( describing: newString))")
 //            (Data(bytes: b[newstartindex..<newendindex])
 //            // Prints:
 //            // serverIdStr=Optional("PPPPPPPP")
 //            let readBytes = 8
 //            let truncatedServerAns = serverAns[0..<readBytes]
 //            let tsaData = Data(bytes: truncatedServerAns)
 //            let serverIdStr = String(data: tsaData, encoding: .utf8)
 //            print("serverIdStr=\(String( describing: serverIdStr))")
 //
 //            // Prints:
 // serverIdStr=Optional("PPPPPPPP")
 //            if let string = String(data: b, encoding: .utf8) {
 //                print(string)
 //            } else {
 //                print("not a valid UTF-8 sequence")
 //            }
 // print("is vallid JSON data = \(JSONSerialization.isValidJSONObject(a!))")
 
 print("try again")
 //}.resume()
 //        session.downloadTask(with: url!) { (url, rsp, err) in
 //            print("test this one out")
 //            //let stringUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
 //
 //            self.getLocalJsonFile(url!)
 //
 //
 //
 //        }.resume()
 // Create a DataTask Object
 
 //        let dataTask = session.dataTask(with: url!) { (data, response, error) in
 //            if error == nil && data != nil{
 //                print(response!.description)
 //
 //                // Create decoder object
 let decoder = JSONDecoder()
 
 //                //JSONSerialization.ReadingOptions =
 //
 //                //TODO:- Not able to decode data from network maybe security settings
 //                // When download file data is 3107 bytes from local its 3108 ???
 do {
 // Data returned is not valid
 json.data(using: "ISO-8859-1")!
 print("is vallid JSON data = \(JSONSerialization.isValidJSONObject(data!))")
 
 //             let decodedData = try decoder.decode(CanadaData.self, from: serverAns!)
 //                   let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
 //
 //                    let title = json!["title"] as? String
 // Handle cases of null values from JSON file
 var cleanData = CanadaData()
 //           cleanData = self.cleanJsonData(rawData: decodedData)
 
 // Notify the view controller with the results by passing the data to on main thread
 DispatchQueue.main.async {
 self.delegate?.dataRetrieved(data: cleanData)
 }
 }
 catch{
 print("couldn't parse json error = \(error.localizedDescription)")
 print(data!.base64EncodedString())
 }
 //            }
 //        }
 //
 //        // Fire off the task
 }.resume()
 
func loadPortraitScreen(){
    
    
    let bannerWidth = view.frame.width
    let bannerHeight = view.frame.height
    
    let bannerX = bannerWidth / 2 - image!.size.width / 2
    let bannerY = bannerHeight / 2 - image!.size.height / 2
    
    portraitImageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
    portraitImageView.image = image!
    portraitImageView.contentMode = .scaleAspectFit
    portraitImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(portraitImageView)
    
    let leadingImageViewConstraint = NSLayoutConstraint(item: portraitImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
    
    let trailingImageViewConstraint  = NSLayoutConstraint(item: portraitImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
    
    let topImageViewConstraint  = NSLayoutConstraint(item: portraitImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
    
    let bottomImageViewConstraint  = NSLayoutConstraint(item: portraitImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    let widthImageViewConstraint = NSLayoutConstraint(item: portraitImageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 00)
    //
    // Add constraints
    view.addConstraints([leadingImageViewConstraint ,
                         topImageViewConstraint ,
                         trailingImageViewConstraint ,
                         bottomImageViewConstraint ,
                         widthImageViewConstraint])
    
    
    descriptionLabel.text = descriptionLabelText!
    descriptionLabel.numberOfLines = 0
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(descriptionLabel)
    
    let leadingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
    
    let trailingDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
    
    let topDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: portraitImageView, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    let bottomDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    let widthDescriptionLabelConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
    
    // Add constraints
    view.addConstraints([leadingDescriptionLabelConstraint,
                         topDescriptionLabelConstraint,
                         //  trailingDescriptionLabelConstraint,
        bottomDescriptionLabelConstraint, widthDescriptionLabelConstraint])
    
    isPortraitLoaded = true
}
func unloadPortraitScreen(){
    // Remove portrait screen
    portraitImageView.removeFromSuperview()
    descriptionLabel.removeFromSuperview()
    isPortraitLoaded = false
}
*/


/*from network

 charset=ISO-8859-1
 UTF-8'
 Strict-Transport-Security
 ewoidGl0bGUiOiJBYm91dCBDYW5hZGEiLAoicm93cyI6WwoJewoJInRpdGxlIjoiQmVhdmVycyIsCgkiZGVzY3JpcHRpb24iOiJCZWF2ZXJzIGFyZSBzZWNvbmQgb25seSB0byBodW1hbnMgaW4gdGhlaXIgYWJpbGl0eSB0byBtYW5pcHVsYXRlIGFuZCBjaGFuZ2UgdGhlaXIgZW52aXJvbm1lbnQuIFRoZXkgY2FuIG1lYXN1cmUgdXAgdG8gMS4zIG1ldHJlcyBsb25nLiBBIGdyb3VwIG9mIGJlYXZlcnMgaXMgY2FsbGVkIGEgY29sb255IiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vdXBsb2FkLndpa2ltZWRpYS5vcmcvd2lraXBlZGlhL2NvbW1vbnMvdGh1bWIvNi82Yi9BbWVyaWNhbl9CZWF2ZXIuanBnLzIyMHB4LUFtZXJpY2FuX0JlYXZlci5qcGciCgl9LAoJewoJInRpdGxlIjoiRmxhZyIsCgkiZGVzY3JpcHRpb24iOm51bGwsCgkiaW1hZ2VIcmVmIjoiaHR0cDovL2ltYWdlcy5maW5kaWNvbnMuY29tL2ZpbGVzL2ljb25zLzY2Mi93b3JsZF9mbGFnLzEyOC9mbGFnX29mX2NhbmFkYS5wbmciCgl9LAoJewoJInRpdGxlIjoiVHJhbnNwb3J0YXRpb24iLAoJImRlc2NyaXB0aW9uIjoiSXQgaXMgYSB3ZWxsIGtub3duIGZhY3QgdGhhdCBwb2xhciBiZWFycyBhcmUgdGhlIG1haW4gbW9kZSBvZiB0cmFuc3BvcnRhdGlvbiBpbiBDYW5hZGEuIFRoZXkgY29uc3VtZSBmYXIgbGVzcyBnYXMgYW5kIGhhdmUgdGhlIGFkZGVkIGJlbmVmaXQgb2YgYmVpbmcgZGlmZmljdWx0IHRvIHN0ZWFsLiIsCgkiaW1hZ2VIcmVmIjoiaHR0cDovLzEuYnAuYmxvZ3Nwb3QuY29tL19WWlZPbVlWbTY4US9TTWt6WnprR1hLSS9BQUFBQUFBQUFEUS9VODltaWFDa2N5by9zNDAwL3RoZV9nb2xkZW5fY29tcGFzc19zdGlsbC5qcGciCgl9LAoJewoJInRpdGxlIjoiSG9ja2V5IE5pZ2h0IGluIENhbmFkYSIsCgkiZGVzY3JpcHRpb24iOiJUaGVzZSBTYXR1cmRheSBuaWdodCBDQkMgYnJvYWRjYXN0cyBvcmlnaW5hbGx5IGFpcmVkIG9uIHJhZGlvIGluIDE5MzEuIEluIDE5NTIgdGhleSBkZWJ1dGVkIG9uIHRlbGV2aXNpb24gYW5kIGNvbnRpbnVlIHRvIHVuaXRlIChhbmQgZGl2aWRlKSB0aGUgbmF0aW9uIGVhY2ggd2Vlay4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly9meWltdXNpYy5jYS93cC1jb250ZW50L3VwbG9hZHMvMjAwOC8wNi9ob2NrZXktbmlnaHQtaW4tY2FuYWRhLnRodW1ibmFpbC5qcGciCgl9LAoJewoJInRpdGxlIjoiRWgiLAoJImRlc2NyaXB0aW9uIjoiQSBjaGllZmx5IENhbmFkaWFuIGludGVycm9nYXRpdmUgdXR0ZXJhbmNlLCB1c3VhbGx5IGV4cHJlc3Npbmcgc3VycHJpc2Ugb3IgZG91YnQgb3Igc2Vla2luZyBjb25maXJtYXRpb24uIiwKCSJpbWFnZUhyZWYiOm51bGwKCX0sCgl7CgkidGl0bGUiOiJIb3VzaW5nIiwKCSJkZXNjcmlwdGlvbiI6Ildhcm1lciB0aGFuIHlvdSBtaWdodCB0aGluay4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly9pY29ucy5pY29uYXJjaGl2ZS5jb20vaWNvbnMvaWNvbnNob2NrL2FsYXNrYS8yNTYvSWdsb28taWNvbi5wbmciCgl9LAoJewoJInRpdGxlIjoiUHVibGljIFNoYW1lIiwKCSJkZXNjcmlwdGlvbiI6IiBTYWRseSBpdCdzIHRydWUuIiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vc3RhdGljLmd1aW0uY28udWsvc3lzLWltYWdlcy9NdXNpYy9QaXgvc2l0ZV9mdXJuaXR1cmUvMjAwNy8wNC8xOS9hdnJpbF9sYXZpZ25lLmpwZyIKCX0sCgl7CgkidGl0bGUiOm51bGwsCgkiZGVzY3JpcHRpb24iOm51bGwsCgkiaW1hZ2VIcmVmIjpudWxsCgl9LAoJewoJInRpdGxlIjoiU3BhY2UgUHJvZ3JhbSIsCgkiZGVzY3JpcHRpb24iOiJDYW5hZGEgaG9wZXMgdG8gc29vbiBsYXVuY2ggYSBtYW4gdG8gdGhlIG1vb24uIiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vZmlsZXMudHVyYm9zcXVpZC5jb20vUHJldmlldy9Db250ZW50XzIwMDlfMDdfMTRfXzEwXzI1XzE1L3RyZWJ1Y2hldGEuanBnZGYzZjNiZjQtOTM1ZC00MGZmLTg0YjItNmNlNzE4YTMyN2E5TGFyZ2VyLmpwZyIKCX0sCgl7CgkidGl0bGUiOiJNZWVzZSIsCgkiZGVzY3JpcHRpb24iOiJBIG1vb3NlIGlzIGEgY29tbW9uIHNpZ2h0IGluIENhbmFkYS4gVGFsbCBhbmQgbWFqZXN0aWMsIHRoZXkgcmVwcmVzZW50IG1hbnkgb2YgdGhlIHZhbHVlcyB3aGljaCBDYW5hZGlhbnMgaW1hZ2luZSB0aGF0IHRoZXkgcG9zc2Vzcy4gVGhleSBncm93IHVwIHRvIDIuNyBtZXRyZXMgbG9uZyBhbmQgY2FuIHdlaWdoIG92ZXIgNzAwIGtnLiBUaGV5IHN3aW0gYXQgMTAga20vaC4gTW9vc2UgYW50bGVycyB3ZWlnaCByb3VnaGx5IDIwIGtnLiBUaGUgcGx1cmFsIG9mIG1vb3NlIGlzIGFjdHVhbGx5ICdtZWVzZScsIGRlc3BpdGUgd2hhdCBtb3N0IGRpY3Rpb25hcmllcywgZW5jeWNsb3BlZGlhcywgYW5kIGV4cGVydHMgd2lsbCB0ZWxsIHlvdS4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly9jYXJvbGRlY2tlcndpbGRsaWZlYXJ0c3R1ZGlvLm5ldC93cC1jb250ZW50L3VwbG9hZHMvMjAxMS8wNC9JTUdfMjQxOCUyMG1hamVzdGljJTIwbW9vc2UlMjAxJTIwY29weSUyMChTbWFsbCktOTZ4OTYuanBnIgoJfSwKCXsKCSJ0aXRsZSI6Ikdlb2dyYXBoeSIsCgkiZGVzY3JpcHRpb24iOiJJdCdzIHJlYWxseSBiaWcuIiwKCSJpbWFnZUhyZWYiOm51bGwKCX0sCgl7CgkidGl0bGUiOiJLaXR0ZW5zLi4uIiwKCSJkZXNjcmlwdGlvbiI6IslhcmUgaWxsZWdhbC4gQ2F0cyBhcmUgZmluZS4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly93d3cuZG9uZWdhbGhpbWFsYXlhbnMuY29tL2ltYWdlcy9UaGF0JTIwZmlzaCUyMHdhcyUyMHRoaXMlMjBiaWcuanBnIgoJfSwKCXsKCSJ0aXRsZSI6Ik1vdW50aWVzIiwKCSJkZXNjcmlwdGlvbiI6IlRoZXkgYXJlIHRoZSBsYXcuIFRoZXkgYXJlIGFsc28gQ2FuYWRhJ3MgZm9yZWlnbiBlc3Bpb25hZ2Ugc2VydmljZS4gU3VidGxlLiIsCgkiaW1hZ2VIcmVmIjoiaHR0cDovLzMuYnAuYmxvZ3Nwb3QuY29tL19fbW9reGJUbXVKTS9Sbld1SjZjRTljSS9BQUFBQUFBQUFUdy82ejNtM3c5SkRpVS9zNDAwLzAxOTg0M18zMS5qcGciCgl9LAoJewoJInRpdGxlIjoiTGFuZ3VhZ2UiLAoJImRlc2NyaXB0aW9uIjoiTm91cyBwYXJsb25zIHRvdXMgbGVzIGxhbmd1ZXMgaW1wb3J0YW50cy4iLAoJImltYWdlSHJlZiI6bnVsbAoJfQpdCn0=

 ZXdvaWRHbDBiR1VpT2lKQlltOTFkQ0JEWVc1aFpHRWlMQW9pY205M2N5STZXd29KZXdvSkluUnBkR3hsSWpvaVFtVmhkbVZ5Y3lJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT2lKQ1pXRjJaWEp6SUdGeVpTQnpaV052Ym1RZ2IyNXNlU0IwYnlCb2RXMWhibk1nYVc0Z2RHaGxhWElnWVdKcGJHbDBlU0IwYnlCdFlXNXBjSFZzWVhSbElHRnVaQ0JqYUdGdVoyVWdkR2hsYVhJZ1pXNTJhWEp2Ym0xbGJuUXVJRlJvWlhrZ1kyRnVJRzFsWVhOMWNtVWdkWEFnZEc4Z01TNHpJRzFsZEhKbGN5QnNiMjVuTGlCQklHZHliM1Z3SUc5bUlHSmxZWFpsY25NZ2FYTWdZMkZzYkdWa0lHRWdZMjlzYjI1NUlpd0tDU0pwYldGblpVaHlaV1lpT2lKb2RIUndPaTh2ZFhCc2IyRmtMbmRwYTJsdFpXUnBZUzV2Y21jdmQybHJhWEJsWkdsaEwyTnZiVzF2Ym5NdmRHaDFiV0l2Tmk4MllpOUJiV1Z5YVdOaGJsOUNaV0YyWlhJdWFuQm5Mekl5TUhCNExVRnRaWEpwWTJGdVgwSmxZWFpsY2k1cWNHY2lDZ2w5TEFvSmV3b0pJblJwZEd4bElqb2lSbXhoWnlJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT201MWJHd3NDZ2tpYVcxaFoyVkljbVZtSWpvaWFIUjBjRG92TDJsdFlXZGxjeTVtYVc1a2FXTnZibk11WTI5dEwyWnBiR1Z6TDJsamIyNXpMelkyTWk5M2IzSnNaRjltYkdGbkx6RXlPQzltYkdGblgyOW1YMk5oYm1Ga1lTNXdibWNpQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pVkhKaGJuTndiM0owWVhScGIyNGlMQW9KSW1SbGMyTnlhWEIwYVc5dUlqb2lTWFFnYVhNZ1lTQjNaV3hzSUd0dWIzZHVJR1poWTNRZ2RHaGhkQ0J3YjJ4aGNpQmlaV0Z5Y3lCaGNtVWdkR2hsSUcxaGFXNGdiVzlrWlNCdlppQjBjbUZ1YzNCdmNuUmhkR2x2YmlCcGJpQkRZVzVoWkdFdUlGUm9aWGtnWTI5dWMzVnRaU0JtWVhJZ2JHVnpjeUJuWVhNZ1lXNWtJR2hoZG1VZ2RHaGxJR0ZrWkdWa0lHSmxibVZtYVhRZ2IyWWdZbVZwYm1jZ1pHbG1abWxqZFd4MElIUnZJSE4wWldGc0xpSXNDZ2tpYVcxaFoyVkljbVZtSWpvaWFIUjBjRG92THpFdVluQXVZbXh2WjNOd2IzUXVZMjl0TDE5V1dsWlBiVmxXYlRZNFVTOVRUV3Q2V25wclIxaExTUzlCUVVGQlFVRkJRVUZFVVM5Vk9EbHRhV0ZEYTJONWJ5OXpOREF3TDNSb1pWOW5iMnhrWlc1ZlkyOXRjR0Z6YzE5emRHbHNiQzVxY0djaUNnbDlMQW9KZXdvSkluUnBkR3hsSWpvaVNHOWphMlY1SUU1cFoyaDBJR2x1SUVOaGJtRmtZU0lzQ2draVpHVnpZM0pwY0hScGIyNGlPaUpVYUdWelpTQlRZWFIxY21SaGVTQnVhV2RvZENCRFFrTWdZbkp2WVdSallYTjBjeUJ2Y21sbmFXNWhiR3g1SUdGcGNtVmtJRzl1SUhKaFpHbHZJR2x1SURFNU16RXVJRWx1SURFNU5USWdkR2hsZVNCa1pXSjFkR1ZrSUc5dUlIUmxiR1YyYVhOcGIyNGdZVzVrSUdOdmJuUnBiblZsSUhSdklIVnVhWFJsSUNoaGJtUWdaR2wyYVdSbEtTQjBhR1VnYm1GMGFXOXVJR1ZoWTJnZ2QyVmxheTRpTEFvSkltbHRZV2RsU0hKbFppSTZJbWgwZEhBNkx5OW1lV2x0ZFhOcFl5NWpZUzkzY0MxamIyNTBaVzUwTDNWd2JHOWhaSE12TWpBd09DOHdOaTlvYjJOclpYa3RibWxuYUhRdGFXNHRZMkZ1WVdSaExuUm9kVzFpYm1GcGJDNXFjR2NpQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pUldnaUxBb0pJbVJsYzJOeWFYQjBhVzl1SWpvaVFTQmphR2xsWm14NUlFTmhibUZrYVdGdUlHbHVkR1Z5Y205bllYUnBkbVVnZFhSMFpYSmhibU5sTENCMWMzVmhiR3g1SUdWNGNISmxjM05wYm1jZ2MzVnljSEpwYzJVZ2IzSWdaRzkxWW5RZ2IzSWdjMlZsYTJsdVp5QmpiMjVtYVhKdFlYUnBiMjR1SWl3S0NTSnBiV0ZuWlVoeVpXWWlPbTUxYkd3S0NYMHNDZ2w3Q2draWRHbDBiR1VpT2lKSWIzVnphVzVuSWl3S0NTSmtaWE5qY21sd2RHbHZiaUk2SWxkaGNtMWxjaUIwYUdGdUlIbHZkU0J0YVdkb2RDQjBhR2x1YXk0aUxBb0pJbWx0WVdkbFNISmxaaUk2SW1oMGRIQTZMeTlwWTI5dWN5NXBZMjl1WVhKamFHbDJaUzVqYjIwdmFXTnZibk12YVdOdmJuTm9iMk5yTDJGc1lYTnJZUzh5TlRZdlNXZHNiMjh0YVdOdmJpNXdibWNpQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pVUhWaWJHbGpJRk5vWVcxbElpd0tDU0prWlhOamNtbHdkR2x2YmlJNklpQlRZV1JzZVNCcGRDZHpJSFJ5ZFdVdUlpd0tDU0pwYldGblpVaHlaV1lpT2lKb2RIUndPaTh2YzNSaGRHbGpMbWQxYVcwdVkyOHVkV3N2YzNsekxXbHRZV2RsY3k5TmRYTnBZeTlRYVhndmMybDBaVjltZFhKdWFYUjFjbVV2TWpBd055OHdOQzh4T1M5aGRuSnBiRjlzWVhacFoyNWxMbXB3WnlJS0NYMHNDZ2w3Q2draWRHbDBiR1VpT201MWJHd3NDZ2tpWkdWelkzSnBjSFJwYjI0aU9tNTFiR3dzQ2draWFXMWhaMlZJY21WbUlqcHVkV3hzQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pVTNCaFkyVWdVSEp2WjNKaGJTSXNDZ2tpWkdWelkzSnBjSFJwYjI0aU9pSkRZVzVoWkdFZ2FHOXdaWE1nZEc4Z2MyOXZiaUJzWVhWdVkyZ2dZU0J0WVc0Z2RHOGdkR2hsSUcxdmIyNHVJaXdLQ1NKcGJXRm5aVWh5WldZaU9pSm9kSFJ3T2k4dlptbHNaWE11ZEhWeVltOXpjWFZwWkM1amIyMHZVSEpsZG1sbGR5OURiMjUwWlc1MFh6SXdNRGxmTURkZk1UUmZYekV3WHpJMVh6RTFMM1J5WldKMVkyaGxkR0V1YW5CblpHWXpaak5pWmpRdE9UTTFaQzAwTUdabUxUZzBZakl0Tm1ObE56RTRZVE15TjJFNVRHRnlaMlZ5TG1wd1p5SUtDWDBzQ2dsN0Nna2lkR2wwYkdVaU9pSk5aV1Z6WlNJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT2lKQklHMXZiM05sSUdseklHRWdZMjl0Ylc5dUlITnBaMmgwSUdsdUlFTmhibUZrWVM0Z1ZHRnNiQ0JoYm1RZ2JXRnFaWE4wYVdNc0lIUm9aWGtnY21Wd2NtVnpaVzUwSUcxaGJua2diMllnZEdobElIWmhiSFZsY3lCM2FHbGphQ0JEWVc1aFpHbGhibk1nYVcxaFoybHVaU0IwYUdGMElIUm9aWGtnY0c5emMyVnpjeTRnVkdobGVTQm5jbTkzSUhWd0lIUnZJREl1TnlCdFpYUnlaWE1nYkc5dVp5QmhibVFnWTJGdUlIZGxhV2RvSUc5MlpYSWdOekF3SUd0bkxpQlVhR1Y1SUhOM2FXMGdZWFFnTVRBZ2EyMHZhQzRnVFc5dmMyVWdZVzUwYkdWeWN5QjNaV2xuYUNCeWIzVm5hR3g1SURJd0lHdG5MaUJVYUdVZ2NHeDFjbUZzSUc5bUlHMXZiM05sSUdseklHRmpkSFZoYkd4NUlDZHRaV1Z6WlNjc0lHUmxjM0JwZEdVZ2QyaGhkQ0J0YjNOMElHUnBZM1JwYjI1aGNtbGxjeXdnWlc1amVXTnNiM0JsWkdsaGN5d2dZVzVrSUdWNGNHVnlkSE1nZDJsc2JDQjBaV3hzSUhsdmRTNGlMQW9KSW1sdFlXZGxTSEpsWmlJNkltaDBkSEE2THk5allYSnZiR1JsWTJ0bGNuZHBiR1JzYVdabFlYSjBjM1IxWkdsdkxtNWxkQzkzY0MxamIyNTBaVzUwTDNWd2JHOWhaSE12TWpBeE1TOHdOQzlKVFVkZk1qUXhPQ1V5TUcxaGFtVnpkR2xqSlRJd2JXOXZjMlVsTWpBeEpUSXdZMjl3ZVNVeU1DaFRiV0ZzYkNrdE9UWjRPVFl1YW5Cbklnb0pmU3dLQ1hzS0NTSjBhWFJzWlNJNklrZGxiMmR5WVhCb2VTSXNDZ2tpWkdWelkzSnBjSFJwYjI0aU9pSkpkQ2R6SUhKbFlXeHNlU0JpYVdjdUlpd0tDU0pwYldGblpVaHlaV1lpT201MWJHd0tDWDBzQ2dsN0Nna2lkR2wwYkdVaU9pSkxhWFIwWlc1ekxpNHVJaXdLQ1NKa1pYTmpjbWx3ZEdsdmJpSTZJc2xoY21VZ2FXeHNaV2RoYkM0Z1EyRjBjeUJoY21VZ1ptbHVaUzRpTEFvSkltbHRZV2RsU0hKbFppSTZJbWgwZEhBNkx5OTNkM2N1Wkc5dVpXZGhiR2hwYldGc1lYbGhibk11WTI5dEwybHRZV2RsY3k5VWFHRjBKVEl3Wm1semFDVXlNSGRoY3lVeU1IUm9hWE1sTWpCaWFXY3VhbkJuSWdvSmZTd0tDWHNLQ1NKMGFYUnNaU0k2SWsxdmRXNTBhV1Z6SWl3S0NTSmtaWE5qY21sd2RHbHZiaUk2SWxSb1pYa2dZWEpsSUhSb1pTQnNZWGN1SUZSb1pYa2dZWEpsSUdGc2MyOGdRMkZ1WVdSaEozTWdabTl5WldsbmJpQmxjM0JwYjI1aFoyVWdjMlZ5ZG1salpTNGdVM1ZpZEd4bExpSXNDZ2tpYVcxaFoyVkljbVZtSWpvaWFIUjBjRG92THpNdVluQXVZbXh2WjNOd2IzUXVZMjl0TDE5ZmJXOXJlR0pVYlhWS1RTOVNibGQxU2paalJUbGpTUzlCUVVGQlFVRkJRVUZVZHk4MmVqTnRNM2M1U2tScFZTOXpOREF3THpBeE9UZzBNMTh6TVM1cWNHY2lDZ2w5TEFvSmV3b0pJblJwZEd4bElqb2lUR0Z1WjNWaFoyVWlMQW9KSW1SbGMyTnlhWEIwYVc5dUlqb2lUbTkxY3lCd1lYSnNiMjV6SUhSdmRYTWdiR1Z6SUd4aGJtZDFaWE1nYVcxd2IzSjBZVzUwY3k0aUxBb0pJbWx0WVdkbFNISmxaaUk2Ym5Wc2JBb0pmUXBkQ24wPQ==
 
from local

 ewoidGl0bGUiOiJBYm91dCBDYW5hZGEiLAoicm93cyI6WwoJewoJInRpdGxlIjoiQmVhdmVycyIsCgkiZGVzY3JpcHRpb24iOiJCZWF2ZXJzIGFyZSBzZWNvbmQgb25seSB0byBodW1hbnMgaW4gdGhlaXIgYWJpbGl0eSB0byBtYW5pcHVsYXRlIGFuZCBjaGFuZ2UgdGhlaXIgZW52aXJvbm1lbnQuIFRoZXkgY2FuIG1lYXN1cmUgdXAgdG8gMS4zIG1ldHJlcyBsb25nLiBBIGdyb3VwIG9mIGJlYXZlcnMgaXMgY2FsbGVkIGEgY29sb255IiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vdXBsb2FkLndpa2ltZWRpYS5vcmcvd2lraXBlZGlhL2NvbW1vbnMvdGh1bWIvNi82Yi9BbWVyaWNhbl9CZWF2ZXIuanBnLzIyMHB4LUFtZXJpY2FuX0JlYXZlci5qcGciCgl9LAoJewoJInRpdGxlIjoiRmxhZyIsCgkiZGVzY3JpcHRpb24iOm51bGwsCgkiaW1hZ2VIcmVmIjoiaHR0cDovL2ltYWdlcy5maW5kaWNvbnMuY29tL2ZpbGVzL2ljb25zLzY2Mi93b3JsZF9mbGFnLzEyOC9mbGFnX29mX2NhbmFkYS5wbmciCgl9LAoJewoJInRpdGxlIjoiVHJhbnNwb3J0YXRpb24iLAoJImRlc2NyaXB0aW9uIjoiSXQgaXMgYSB3ZWxsIGtub3duIGZhY3QgdGhhdCBwb2xhciBiZWFycyBhcmUgdGhlIG1haW4gbW9kZSBvZiB0cmFuc3BvcnRhdGlvbiBpbiBDYW5hZGEuIFRoZXkgY29uc3VtZSBmYXIgbGVzcyBnYXMgYW5kIGhhdmUgdGhlIGFkZGVkIGJlbmVmaXQgb2YgYmVpbmcgZGlmZmljdWx0IHRvIHN0ZWFsLiIsCgkiaW1hZ2VIcmVmIjoiaHR0cDovLzEuYnAuYmxvZ3Nwb3QuY29tL19WWlZPbVlWbTY4US9TTWt6WnprR1hLSS9BQUFBQUFBQUFEUS9VODltaWFDa2N5by9zNDAwL3RoZV9nb2xkZW5fY29tcGFzc19zdGlsbC5qcGciCgl9LAoJewoJInRpdGxlIjoiSG9ja2V5IE5pZ2h0IGluIENhbmFkYSIsCgkiZGVzY3JpcHRpb24iOiJUaGVzZSBTYXR1cmRheSBuaWdodCBDQkMgYnJvYWRjYXN0cyBvcmlnaW5hbGx5IGFpcmVkIG9uIHJhZGlvIGluIDE5MzEuIEluIDE5NTIgdGhleSBkZWJ1dGVkIG9uIHRlbGV2aXNpb24gYW5kIGNvbnRpbnVlIHRvIHVuaXRlIChhbmQgZGl2aWRlKSB0aGUgbmF0aW9uIGVhY2ggd2Vlay4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly9meWltdXNpYy5jYS93cC1jb250ZW50L3VwbG9hZHMvMjAwOC8wNi9ob2NrZXktbmlnaHQtaW4tY2FuYWRhLnRodW1ibmFpbC5qcGciCgl9LAoJewoJInRpdGxlIjoiRWgiLAoJImRlc2NyaXB0aW9uIjoiQSBjaGllZmx5IENhbmFkaWFuIGludGVycm9nYXRpdmUgdXR0ZXJhbmNlLCB1c3VhbGx5IGV4cHJlc3Npbmcgc3VycHJpc2Ugb3IgZG91YnQgb3Igc2Vla2luZyBjb25maXJtYXRpb24uIiwKCSJpbWFnZUhyZWYiOm51bGwKCX0sCgl7CgkidGl0bGUiOiJIb3VzaW5nIiwKCSJkZXNjcmlwdGlvbiI6Ildhcm1lciB0aGFuIHlvdSBtaWdodCB0aGluay4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly9pY29ucy5pY29uYXJjaGl2ZS5jb20vaWNvbnMvaWNvbnNob2NrL2FsYXNrYS8yNTYvSWdsb28taWNvbi5wbmciCgl9LAoJewoJInRpdGxlIjoiUHVibGljIFNoYW1lIiwKCSJkZXNjcmlwdGlvbiI6IiBTYWRseSBpdCdzIHRydWUuIiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vc3RhdGljLmd1aW0uY28udWsvc3lzLWltYWdlcy9NdXNpYy9QaXgvc2l0ZV9mdXJuaXR1cmUvMjAwNy8wNC8xOS9hdnJpbF9sYXZpZ25lLmpwZyIKCX0sCgl7CgkidGl0bGUiOm51bGwsCgkiZGVzY3JpcHRpb24iOm51bGwsCgkiaW1hZ2VIcmVmIjpudWxsCgl9LAoJewoJInRpdGxlIjoiU3BhY2UgUHJvZ3JhbSIsCgkiZGVzY3JpcHRpb24iOiJDYW5hZGEgaG9wZXMgdG8gc29vbiBsYXVuY2ggYSBtYW4gdG8gdGhlIG1vb24uIiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vZmlsZXMudHVyYm9zcXVpZC5jb20vUHJldmlldy9Db250ZW50XzIwMDlfMDdfMTRfXzEwXzI1XzE1L3RyZWJ1Y2hldGEuanBnZGYzZjNiZjQtOTM1ZC00MGZmLTg0YjItNmNlNzE4YTMyN2E5TGFyZ2VyLmpwZyIKCX0sCgl7CgkidGl0bGUiOiJNZWVzZSIsCgkiZGVzY3JpcHRpb24iOiJBIG1vb3NlIGlzIGEgY29tbW9uIHNpZ2h0IGluIENhbmFkYS4gVGFsbCBhbmQgbWFqZXN0aWMsIHRoZXkgcmVwcmVzZW50IG1hbnkgb2YgdGhlIHZhbHVlcyB3aGljaCBDYW5hZGlhbnMgaW1hZ2luZSB0aGF0IHRoZXkgcG9zc2Vzcy4gVGhleSBncm93IHVwIHRvIDIuNyBtZXRyZXMgbG9uZyBhbmQgY2FuIHdlaWdoIG92ZXIgNzAwIGtnLiBUaGV5IHN3aW0gYXQgMTAga20vaC4gTW9vc2UgYW50bGVycyB3ZWlnaCByb3VnaGx5IDIwIGtnLiBUaGUgcGx1cmFsIG9mIG1vb3NlIGlzIGFjdHVhbGx5ICdtZWVzZScsIGRlc3BpdGUgd2hhdCBtb3N0IGRpY3Rpb25hcmllcywgZW5jeWNsb3BlZGlhcywgYW5kIGV4cGVydHMgd2lsbCB0ZWxsIHlvdS4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly9jYXJvbGRlY2tlcndpbGRsaWZlYXJ0c3R1ZGlvLm5ldC93cC1jb250ZW50L3VwbG9hZHMvMjAxMS8wNC9JTUdfMjQxOCUyMG1hamVzdGljJTIwbW9vc2UlMjAxJTIwY29weSUyMChTbWFsbCktOTZ4OTYuanBnIgoJfSwKCXsKCSJ0aXRsZSI6Ikdlb2dyYXBoeSIsCgkiZGVzY3JpcHRpb24iOiJJdCdzIHJlYWxseSBiaWcuIiwKCSJpbWFnZUhyZWYiOm51bGwKCX0sCgl7CgkidGl0bGUiOiJLaXR0ZW5zLi4uIiwKCSJkZXNjcmlwdGlvbiI6IsOJYXJlIGlsbGVnYWwuIENhdHMgYXJlIGZpbmUuIiwKCSJpbWFnZUhyZWYiOiJodHRwOi8vd3d3LmRvbmVnYWxoaW1hbGF5YW5zLmNvbS9pbWFnZXMvVGhhdCUyMGZpc2glMjB3YXMlMjB0aGlzJTIwYmlnLmpwZyIKCX0sCgl7CgkidGl0bGUiOiJNb3VudGllcyIsCgkiZGVzY3JpcHRpb24iOiJUaGV5IGFyZSB0aGUgbGF3LiBUaGV5IGFyZSBhbHNvIENhbmFkYSdzIGZvcmVpZ24gZXNwaW9uYWdlIHNlcnZpY2UuIFN1YnRsZS4iLAoJImltYWdlSHJlZiI6Imh0dHA6Ly8zLmJwLmJsb2dzcG90LmNvbS9fX21va3hiVG11Sk0vUm5XdUo2Y0U5Y0kvQUFBQUFBQUFBVHcvNnozbTN3OUpEaVUvczQwMC8wMTk4NDNfMzEuanBnIgoJfSwKCXsKCSJ0aXRsZSI6Ikxhbmd1YWdlIiwKCSJkZXNjcmlwdGlvbiI6Ik5vdXMgcGFybG9ucyB0b3VzIGxlcyBsYW5ndWVzIGltcG9ydGFudHMuIiwKCSJpbWFnZUhyZWYiOm51bGwKCX0KXQp9
 
 po data.base64EncodedData().base64EncodedString()
 "ZXdvaWRHbDBiR1VpT2lKQlltOTFkQ0JEWVc1aFpHRWlMQW9pY205M2N5STZXd29KZXdvSkluUnBkR3hsSWpvaVFtVmhkbVZ5Y3lJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT2lKQ1pXRjJaWEp6SUdGeVpTQnpaV052Ym1RZ2IyNXNlU0IwYnlCb2RXMWhibk1nYVc0Z2RHaGxhWElnWVdKcGJHbDBlU0IwYnlCdFlXNXBjSFZzWVhSbElHRnVaQ0JqYUdGdVoyVWdkR2hsYVhJZ1pXNTJhWEp2Ym0xbGJuUXVJRlJvWlhrZ1kyRnVJRzFsWVhOMWNtVWdkWEFnZEc4Z01TNHpJRzFsZEhKbGN5QnNiMjVuTGlCQklHZHliM1Z3SUc5bUlHSmxZWFpsY25NZ2FYTWdZMkZzYkdWa0lHRWdZMjlzYjI1NUlpd0tDU0pwYldGblpVaHlaV1lpT2lKb2RIUndPaTh2ZFhCc2IyRmtMbmRwYTJsdFpXUnBZUzV2Y21jdmQybHJhWEJsWkdsaEwyTnZiVzF2Ym5NdmRHaDFiV0l2Tmk4MllpOUJiV1Z5YVdOaGJsOUNaV0YyWlhJdWFuQm5Mekl5TUhCNExVRnRaWEpwWTJGdVgwSmxZWFpsY2k1cWNHY2lDZ2w5TEFvSmV3b0pJblJwZEd4bElqb2lSbXhoWnlJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT201MWJHd3NDZ2tpYVcxaFoyVkljbVZtSWpvaWFIUjBjRG92TDJsdFlXZGxjeTVtYVc1a2FXTnZibk11WTI5dEwyWnBiR1Z6TDJsamIyNXpMelkyTWk5M2IzSnNaRjltYkdGbkx6RXlPQzltYkdGblgyOW1YMk5oYm1Ga1lTNXdibWNpQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pVkhKaGJuTndiM0owWVhScGIyNGlMQW9KSW1SbGMyTnlhWEIwYVc5dUlqb2lTWFFnYVhNZ1lTQjNaV3hzSUd0dWIzZHVJR1poWTNRZ2RHaGhkQ0J3YjJ4aGNpQmlaV0Z5Y3lCaGNtVWdkR2hsSUcxaGFXNGdiVzlrWlNCdlppQjBjbUZ1YzNCdmNuUmhkR2x2YmlCcGJpQkRZVzVoWkdFdUlGUm9aWGtnWTI5dWMzVnRaU0JtWVhJZ2JHVnpjeUJuWVhNZ1lXNWtJR2hoZG1VZ2RHaGxJR0ZrWkdWa0lHSmxibVZtYVhRZ2IyWWdZbVZwYm1jZ1pHbG1abWxqZFd4MElIUnZJSE4wWldGc0xpSXNDZ2tpYVcxaFoyVkljbVZtSWpvaWFIUjBjRG92THpFdVluQXVZbXh2WjNOd2IzUXVZMjl0TDE5V1dsWlBiVmxXYlRZNFVTOVRUV3Q2V25wclIxaExTUzlCUVVGQlFVRkJRVUZFVVM5Vk9EbHRhV0ZEYTJONWJ5OXpOREF3TDNSb1pWOW5iMnhrWlc1ZlkyOXRjR0Z6YzE5emRHbHNiQzVxY0djaUNnbDlMQW9KZXdvSkluUnBkR3hsSWpvaVNHOWphMlY1SUU1cFoyaDBJR2x1SUVOaGJtRmtZU0lzQ2draVpHVnpZM0pwY0hScGIyNGlPaUpVYUdWelpTQlRZWFIxY21SaGVTQnVhV2RvZENCRFFrTWdZbkp2WVdSallYTjBjeUJ2Y21sbmFXNWhiR3g1SUdGcGNtVmtJRzl1SUhKaFpHbHZJR2x1SURFNU16RXVJRWx1SURFNU5USWdkR2hsZVNCa1pXSjFkR1ZrSUc5dUlIUmxiR1YyYVhOcGIyNGdZVzVrSUdOdmJuUnBiblZsSUhSdklIVnVhWFJsSUNoaGJtUWdaR2wyYVdSbEtTQjBhR1VnYm1GMGFXOXVJR1ZoWTJnZ2QyVmxheTRpTEFvSkltbHRZV2RsU0hKbFppSTZJbWgwZEhBNkx5OW1lV2x0ZFhOcFl5NWpZUzkzY0MxamIyNTBaVzUwTDNWd2JHOWhaSE12TWpBd09DOHdOaTlvYjJOclpYa3RibWxuYUhRdGFXNHRZMkZ1WVdSaExuUm9kVzFpYm1GcGJDNXFjR2NpQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pUldnaUxBb0pJbVJsYzJOeWFYQjBhVzl1SWpvaVFTQmphR2xsWm14NUlFTmhibUZrYVdGdUlHbHVkR1Z5Y205bllYUnBkbVVnZFhSMFpYSmhibU5sTENCMWMzVmhiR3g1SUdWNGNISmxjM05wYm1jZ2MzVnljSEpwYzJVZ2IzSWdaRzkxWW5RZ2IzSWdjMlZsYTJsdVp5QmpiMjVtYVhKdFlYUnBiMjR1SWl3S0NTSnBiV0ZuWlVoeVpXWWlPbTUxYkd3S0NYMHNDZ2w3Q2draWRHbDBiR1VpT2lKSWIzVnphVzVuSWl3S0NTSmtaWE5qY21sd2RHbHZiaUk2SWxkaGNtMWxjaUIwYUdGdUlIbHZkU0J0YVdkb2RDQjBhR2x1YXk0aUxBb0pJbWx0WVdkbFNISmxaaUk2SW1oMGRIQTZMeTlwWTI5dWN5NXBZMjl1WVhKamFHbDJaUzVqYjIwdmFXTnZibk12YVdOdmJuTm9iMk5yTDJGc1lYTnJZUzh5TlRZdlNXZHNiMjh0YVdOdmJpNXdibWNpQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pVUhWaWJHbGpJRk5vWVcxbElpd0tDU0prWlhOamNtbHdkR2x2YmlJNklpQlRZV1JzZVNCcGRDZHpJSFJ5ZFdVdUlpd0tDU0pwYldGblpVaHlaV1lpT2lKb2RIUndPaTh2YzNSaGRHbGpMbWQxYVcwdVkyOHVkV3N2YzNsekxXbHRZV2RsY3k5TmRYTnBZeTlRYVhndmMybDBaVjltZFhKdWFYUjFjbVV2TWpBd055OHdOQzh4T1M5aGRuSnBiRjlzWVhacFoyNWxMbXB3WnlJS0NYMHNDZ2w3Q2draWRHbDBiR1VpT201MWJHd3NDZ2tpWkdWelkzSnBjSFJwYjI0aU9tNTFiR3dzQ2draWFXMWhaMlZJY21WbUlqcHVkV3hzQ2dsOUxBb0pld29KSW5ScGRHeGxJam9pVTNCaFkyVWdVSEp2WjNKaGJTSXNDZ2tpWkdWelkzSnBjSFJwYjI0aU9pSkRZVzVoWkdFZ2FHOXdaWE1nZEc4Z2MyOXZiaUJzWVhWdVkyZ2dZU0J0WVc0Z2RHOGdkR2hsSUcxdmIyNHVJaXdLQ1NKcGJXRm5aVWh5WldZaU9pSm9kSFJ3T2k4dlptbHNaWE11ZEhWeVltOXpjWFZwWkM1amIyMHZVSEpsZG1sbGR5OURiMjUwWlc1MFh6SXdNRGxmTURkZk1UUmZYekV3WHpJMVh6RTFMM1J5WldKMVkyaGxkR0V1YW5CblpHWXpaak5pWmpRdE9UTTFaQzAwTUdabUxUZzBZakl0Tm1ObE56RTRZVE15TjJFNVRHRnlaMlZ5TG1wd1p5SUtDWDBzQ2dsN0Nna2lkR2wwYkdVaU9pSk5aV1Z6WlNJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT2lKQklHMXZiM05sSUdseklHRWdZMjl0Ylc5dUlITnBaMmgwSUdsdUlFTmhibUZrWVM0Z1ZHRnNiQ0JoYm1RZ2JXRnFaWE4wYVdNc0lIUm9aWGtnY21Wd2NtVnpaVzUwSUcxaGJua2diMllnZEdobElIWmhiSFZsY3lCM2FHbGphQ0JEWVc1aFpHbGhibk1nYVcxaFoybHVaU0IwYUdGMElIUm9aWGtnY0c5emMyVnpjeTRnVkdobGVTQm5jbTkzSUhWd0lIUnZJREl1TnlCdFpYUnlaWE1nYkc5dVp5QmhibVFnWTJGdUlIZGxhV2RvSUc5MlpYSWdOekF3SUd0bkxpQlVhR1Y1SUhOM2FXMGdZWFFnTVRBZ2EyMHZhQzRnVFc5dmMyVWdZVzUwYkdWeWN5QjNaV2xuYUNCeWIzVm5hR3g1SURJd0lHdG5MaUJVYUdVZ2NHeDFjbUZzSUc5bUlHMXZiM05sSUdseklHRmpkSFZoYkd4NUlDZHRaV1Z6WlNjc0lHUmxjM0JwZEdVZ2QyaGhkQ0J0YjNOMElHUnBZM1JwYjI1aGNtbGxjeXdnWlc1amVXTnNiM0JsWkdsaGN5d2dZVzVrSUdWNGNHVnlkSE1nZDJsc2JDQjBaV3hzSUhsdmRTNGlMQW9KSW1sdFlXZGxTSEpsWmlJNkltaDBkSEE2THk5allYSnZiR1JsWTJ0bGNuZHBiR1JzYVdabFlYSjBjM1IxWkdsdkxtNWxkQzkzY0MxamIyNTBaVzUwTDNWd2JHOWhaSE12TWpBeE1TOHdOQzlKVFVkZk1qUXhPQ1V5TUcxaGFtVnpkR2xqSlRJd2JXOXZjMlVsTWpBeEpUSXdZMjl3ZVNVeU1DaFRiV0ZzYkNrdE9UWjRPVFl1YW5Cbklnb0pmU3dLQ1hzS0NTSjBhWFJzWlNJNklrZGxiMmR5WVhCb2VTSXNDZ2tpWkdWelkzSnBjSFJwYjI0aU9pSkpkQ2R6SUhKbFlXeHNlU0JpYVdjdUlpd0tDU0pwYldGblpVaHlaV1lpT201MWJHd0tDWDBzQ2dsN0Nna2lkR2wwYkdVaU9pSkxhWFIwWlc1ekxpNHVJaXdLQ1NKa1pYTmpjbWx3ZEdsdmJpSTZJc09KWVhKbElHbHNiR1ZuWVd3dUlFTmhkSE1nWVhKbElHWnBibVV1SWl3S0NTSnBiV0ZuWlVoeVpXWWlPaUpvZEhSd09pOHZkM2QzTG1SdmJtVm5ZV3hvYVcxaGJHRjVZVzV6TG1OdmJTOXBiV0ZuWlhNdlZHaGhkQ1V5TUdacGMyZ2xNakIzWVhNbE1qQjBhR2x6SlRJd1ltbG5MbXB3WnlJS0NYMHNDZ2w3Q2draWRHbDBiR1VpT2lKTmIzVnVkR2xsY3lJc0Nna2laR1Z6WTNKcGNIUnBiMjRpT2lKVWFHVjVJR0Z5WlNCMGFHVWdiR0YzTGlCVWFHVjVJR0Z5WlNCaGJITnZJRU5oYm1Ga1lTZHpJR1p2Y21WcFoyNGdaWE53YVc5dVlXZGxJSE5sY25acFkyVXVJRk4xWW5Sc1pTNGlMQW9KSW1sdFlXZGxTSEpsWmlJNkltaDBkSEE2THk4ekxtSndMbUpzYjJkemNHOTBMbU52YlM5ZlgyMXZhM2hpVkcxMVNrMHZVbTVYZFVvMlkwVTVZMGt2UVVGQlFVRkJRVUZCVkhjdk5ub3piVE4zT1VwRWFWVXZjelF3TUM4d01UazRORE5mTXpFdWFuQm5JZ29KZlN3S0NYc0tDU0owYVhSc1pTSTZJa3hoYm1kMVlXZGxJaXdLQ1NKa1pYTmpjbWx3ZEdsdmJpSTZJazV2ZFhNZ2NHRnliRzl1Y3lCMGIzVnpJR3hsY3lCc1lXNW5kV1Z6SUdsdGNHOXlkR0Z1ZEhNdUlpd0tDU0pwYldGblpVaHlaV1lpT201MWJHd0tDWDBLWFFwOQ=="
*/

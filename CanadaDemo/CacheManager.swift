//
//  CacheManager.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 26/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import Foundation

class CacheManager{
    
    static var imageDictionary = [String:Data]()
    
    static func saveImageData(_ url:String, _ data:Data){
        
        // Save image data to the  dictionary
        imageDictionary[url] = data
    }
    
    static func retrieveImageData(_ url:String)->Data?{
        // Attemp to retriev value for url key passed in
        return imageDictionary[url]
    }
}

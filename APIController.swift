//
//  APIController.swift
//  TrainTrax
//
//  Created by Jake on 4/7/16.
//  Copyright © 2016 JakeSiegers. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController{
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    func searchItunesFor(searchTerm: String) {
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            //let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
            let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music&entity=album"
            let url = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            
            print(urlPath);
            
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                print("Task completed")
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    print(error!.localizedDescription)
                }
                
                var jsonResult = NSDictionary();
                do{
                    jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }catch{
                    
                }
                
                if let results: NSArray = jsonResult["results"] as? NSArray {
                    print("Delegate thing?");
                    self.delegate.didReceiveAPIResults(results)
                }
                
            })
            
            // The task is just an object with all these properties set
            // In order to actually make the web request, we need to "resume"
            task.resume()
        }
    }

}

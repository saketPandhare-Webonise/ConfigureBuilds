//
//  ViewController.swift
//  GSDemo
//
//  Created by Saket.Webonise Pandhare on 12/12/17.
//  Copyright © 2017 Saket.Webonise Pandhare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelPointingUrl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBaseUrl()
        exampleAPI1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getBaseUrl() {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASEURL")
        labelPointingUrl.text = baseURL as! String?
    }
    
    func exampleAPI() {
        let URL: NSURL = NSURL(string: "https://itunes.apple.com/lookup?id=909253")!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL as URL)
        request.httpMethod = "GET"
        // Convert POST string parameters to data using UTF8 Encoding
//        let postParams = "api_key=APIKEY&email=example@example.com&password=password"
//        let postData = postParams.data(using: .utf8)
        //request.httpBody = "requestPara" /// This fucntion is used to send request parameters
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print("ASynchronous\(jsonResult)")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
    
    /// This is APi call using NSURL session with URL Session configuration
    /// By using nsurl session we can keep progress of download of any file fron server for e.g music file 
    /// we can also pause,resume and cancel download
    
    func exampleAPI1() {
        let URL = NSURL(string: "https://itunes.apple.com/lookup?id=909253")!
        let requestURL: NSMutableURLRequest = NSMutableURLRequest(url: URL as URL)
        requestURL.httpMethod = "GET"
        
        
        // Convert POST string parameters to data using UTF8 Encoding
        //        let postParams = "api_key=APIKEY&email=example@example.com&password=password"
        //        let postData = postParams.data(using: .utf8)
        //request.httpBody = "requestPara" /// This fucntion is used to send request parameters
        
        /// session configuratin is used to store data regarding request info like header value,
        /// cellular access , timeout interval, caching policy 
        /// we can make a common class an use it through out the app
        let sessionConfiguration = URLSessionConfiguration.default
        
        ///Returns a session configuration that uses no persistent storage for caches, cookies, or credentials.
       // let sessionConfiguration = URLSessionConfiguration.ephemeral
        
        sessionConfiguration.allowsCellularAccess = false
        sessionConfiguration.timeoutIntervalForRequest = 30
        
        
        let session =  URLSession(configuration: sessionConfiguration)
        
        
        /// Below session is used to download any fie when app is in background mode 
        ///You must not create more than one session for a background configuration, because the system uses the configuration‘s identifier to associate tasks with the session.
        /// If a background task completes when the app isn’t running, the app will be relaunched in the background. You’ll need to handle this event from your app delegate.
        
     //   let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "bgConfiguration"))
        
        
        session.dataTask(with: requestURL as URLRequest) {(data, response, error) -> Void in
            if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
                print("Json data has \(String(describing: jsonData))")
            }
        }.resume()
    }
}


//
//  Network.swift
//
//
//  Created by Nick on 3/15/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import Foundation
import UIKit

public typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkingProtocol: class {
    associatedtype EndPoint: EndPointType
  
    //default call
    func request(ep: EndPoint, completion:@escaping NetworkCompletion)
}


class DataNetWorking<EndPoint: EndPointType>: NetworkingProtocol {
    internal func request(ep: EndPoint, completion:@escaping NetworkCompletion) {
        URLSession.shared.dataTask(with: ep.baseURL, completionHandler: { data, res, err in
            
            guard let httpResponse = res as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.handleError("Connection Fail!")
                return
            }
            
            DispatchQueue.main.async {
                completion(data, res, err)
            }
            
        }).resume()
        
    
    }
    //MARK:- PRIVATE METHODS
    //handle error with alertviewcontroll
    fileprivate func handleError(_ msg: String) {
        let alertVC = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(ok)
        
        if var top = UIApplication.shared.keyWindow?.rootViewController {
            while let presentView = top.presentedViewController {
                top = presentView
            }
            top.present(alertVC, animated: true, completion: nil)
        }
    }
    
   
}

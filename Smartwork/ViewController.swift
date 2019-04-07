//
//  ViewController.swift
//  Smartwork
//
//  Created by Craig Newcomb on 3/30/19.
//  Copyright © 2019 Craig Newcomb. All rights reserved.
//

import UIKit
import Alamofire
import ChameleonFramework
import SwiftyJSON

class ViewController: UIViewController {
    
    var nanoleafLocalURL = "http://192.168.1.2:16021/api/v1"
    // I'm asserting these since it's where my specific nanoleaf is on my local network-- how to generalize so it will work with anyone, since nanoleaf may not be at 192.168.1.2 ?
    var nanoleafAuthToken = "WToVvS5pEknhQPt83OEpP16Nq0MlincK"
    // this shouldn't be hard coded here, as it will be changed any time you initialize/reinitiate contact with the nanoleaf. I'm doing it to save time for now since I already got my token
    
    
    @IBOutlet weak var helperText: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var boxes: [BoxView]!
    
    private let networkingClient = NetworkingClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func executeRequest(_ sender: Any) {
        guard let urlToExecute = URL(string: nanoleafLocalURL + "/new") else { return }
                
        networkingClient.execute(method: .post, urlToExecute, params: nil) { (json, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let json = json {
                self.nanoleafAuthToken = json[0]["auth_token"] as! String
                print(json.description)
                print(self.nanoleafAuthToken)
            }
        }
    }
    
    @IBAction func getInfo(_ sender: Any) {
        // if nanoleafAuthToken is empty, don't do .get request
        if nanoleafAuthToken.isEmpty {
            helperText.text = "No Token"
        } else {
            guard let fullURL = URL(string: nanoleafLocalURL + "/" + nanoleafAuthToken) else { return }
            
            networkingClient.execute(method: .get, fullURL, params: nil) { (json, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let json = json {
                    print(json.description)
                }
            }
        }
    }
    
    @IBAction func purple(_ sender: Any) {
        
        let hueParams = ["hue" : ["value": 297]]
        // might need to do validation on this to make sure it will create a color, value needs to be between 0 and 360
        
        if nanoleafAuthToken.isEmpty {
            helperText.text = "No Token"
        } else {
            guard let fullURL = URL(string: nanoleafLocalURL + "/" + nanoleafAuthToken + "/state") else { return }
            
            networkingClient.execute(method: .put, fullURL, params: hueParams) { (json, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let json = json {
                    print(json.description)
                }
            }
        }
        
    }
    
        
}
    


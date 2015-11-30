//
//  ViewController.swift
//  What Is The Weather
//
//  Created by Isaac Granillo on 11/30/15.
//  Copyright © 2015 Isaac Granillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var cityTextField: UITextField!
    

    @IBOutlet var resultLabel: UILabel!
    
   
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        
        let attemptUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptUrl {
        

        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            
                if let urlContent = data {
                
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                    if websiteArray.count > 1 {
                        
                        wasSuccessful = true
                    
                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                        if weatherArray.count > 1 {
                        
                            let weatherSummary =  weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                                self.resultLabel.text = weatherSummary
                                
                            
                            })
                        
                        }
                    }
                
                }
                
                if wasSuccessful == false {
                    self.resultLabel.text = "Couldn't find weather, please try again!"
                    
                }
            }
        
            task.resume()
        
        }
        
        else {
            self.resultLabel.text = "Couldn't find weather, please try again!"
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true) //closes keyboard
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true //closes keyboard also when we touch return
        
    }


}









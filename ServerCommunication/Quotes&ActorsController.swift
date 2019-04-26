//
//  Quotes&ActorsController.swift
//  ServerCommunication
//
//  Created by praveen Kumar on 26/04/19.
//  Copyright © 2019 praveen Kumar. All rights reserved.
//

import UIKit

class Quotes_ActorsController: UIViewController {
    
    //Declaring Global Variables
    var request : URLRequest!
    var dataTask : URLSessionDataTask!
    var quotes_ActorsSelected : Bool!
    @IBOutlet weak var quotes_ActorsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    var labels = [UILabel]()
    var label : UILabel!
    @IBOutlet weak var viewInScrollView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Adding Delegates and necessary things
        quotes_ActorsSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        quotes_ActorsSegmentedControl.addTarget(self, action: #selector(segmentedControl(segmentedControl:)), for: UIControl.Event.valueChanged)
        quotes_ActorsSelected = false
        sliderValueLabel.text = String(Int(slider.value))
        slider.addTarget(self, action: #selector(sliderChange(_:)), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func segmentedControl(segmentedControl : UISegmentedControl) {
        quotes_ActorsSelected = true
    }
    
    @objc func sliderChange(_ slider : UISlider) {
        sliderValueLabel.text = String(Int(slider.value))
    }
    
    @IBAction func onGetPress(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        if(quotes_ActorsSelected) {
            
            print("GET button pressed")
            print("Slider Value : \(Int(slider.value))")
            print("Quotes or Actors: \(quotes_ActorsSegmentedControl.titleForSegment(at: quotes_ActorsSegmentedControl.selectedSegmentIndex)!)")
            
            request = URLRequest(url: URL(string: "https://www.brninfotech.com/tws/Quotes.php")!)
            request.httpMethod = "POST"
            
            if(quotes_ActorsSegmentedControl.titleForSegment(at: quotes_ActorsSegmentedControl.selectedSegmentIndex)! == "Quotes") {
                
                if(Int(slider.value) == 1) {
                    
                    let dataToSend = "type=quote&quantity=1"
                    request.httpBody = dataToSend.data(using: String.Encoding.utf8)
                    
                    dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        //print(data!)
                        
                        do {
                            let convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
                            
                            print(convertedData)
                            
                            DispatchQueue.main.async {
                                
                                if(self.labels.count > 0) {
                                    for lbl in self.labels {
                                        lbl.removeFromSuperview()
                                    }
                                    self.labels.removeAll()
                                }
                                
                                self.activityIndicator.stopAnimating()
                                var pointY = 30
                                for str in convertedData {
                                    self.label = UILabel(frame: CGRect(x: 10, y: pointY, width: 370, height: 100))
                                    self.label.text = "--> "+str
                                    self.label.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
                                    self.label.numberOfLines = (str.count/2)
                                    self.viewInScrollView.addSubview(self.label)
                                    self.labels.append(self.label)
                                    pointY += 60
                                }
                            }
                        } catch {
                            print("something error")
                        }
                    })
                    
                    dataTask.resume()
                }
                
                if(Int(slider.value) > 1) {
                    let dataToSend = "type=quotes&quantity=\(Int(slider.value))"
                    request.httpBody = dataToSend.data(using: String.Encoding.utf8)
                    
                    dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        print(data!)
                        
                        do {
                            let convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
                            
                            var n = 1
                            for s in convertedData {
                                print(String(n)+"."+s)
                                n += 1
                            }
                            
                            DispatchQueue.main.async {
                                
                                if(self.labels.count > 0) {
                                    for lbl in self.labels {
                                        lbl.removeFromSuperview()
                                    }
                                    self.labels.removeAll()
                                }
                                
                                self.activityIndicator.stopAnimating()
                                
                                var pointY = 30
                                var no = 1
                                for str in convertedData {
                                    print(str.count)
                                    self.label = UILabel(frame: CGRect(x: 10, y: pointY, width: 370, height: 100))
                                    self.label.text = String(no)+"."+str
                                    self.label.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
                                    self.label.numberOfLines = 7
                                    self.viewInScrollView.addSubview(self.label)
                                    self.labels.append(self.label)
                                    pointY += 80
                                    no += 1
                                }
                            }
                        } catch {
                            print("something error")
                        }
                    })
                    
                    dataTask.resume()
                }
                
                
            }
            
            if(quotes_ActorsSegmentedControl.titleForSegment(at: quotes_ActorsSegmentedControl.selectedSegmentIndex)! == "Actors") {
                
                if(Int(slider.value) == 1) {
                    let dataToSend = "type=actor&quantity=1"
                    request.httpBody = dataToSend.data(using: String.Encoding.utf8)
                    
                    dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        
                        do {
                            let convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
                            
                            var n = 1
                            for s in convertedData {
                                print(String(n)+"."+s)
                                n += 1
                            }
                            
                            DispatchQueue.main.async {
                                
                                if(self.labels.count > 0) {
                                    for lbl in self.labels {
                                        lbl.removeFromSuperview()
                                    }
                                    self.labels.removeAll()
                                }
                                
                                self.activityIndicator.stopAnimating()
                                
                                var pointY = 30
                                for str in convertedData {
                                    print(str.count)
                                    self.label = UILabel(frame: CGRect(x: 10, y: pointY, width: 370, height: 100))
                                    self.label.text = "👨🏻‍🦱"+str
                                    self.label.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
                                    self.viewInScrollView.addSubview(self.label)
                                    self.labels.append(self.label)
                                    pointY += 150
                                }
                            }
                            
                        } catch {
                            print("something error")
                        }
                    })
                    
                    dataTask.resume()
                }
                
                if(Int(slider.value) > 1) {
                    let dataToSend = "type=actors&quantity=\(Int(slider.value))"
                    request.httpBody = dataToSend.data(using: String.Encoding.utf8)
                    
                    dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        
                        do {
                            let convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
                            
                            var n = 1
                            for s in convertedData {
                                print(String(n)+"."+s)
                                n += 1
                            }
                            
                            DispatchQueue.main.async {
                                
                                if(self.labels.count > 0) {
                                    for lbl in self.labels {
                                        lbl.removeFromSuperview()
                                    }
                                    self.labels.removeAll()
                                }
                                
                                self.activityIndicator.stopAnimating()
                                
                                var pointY = 30
                                var no = 1
                                for str in convertedData {
                                    print(str.count)
                                    self.label = UILabel(frame: CGRect(x: 10, y: pointY, width: 370, height: 50))
                                    self.label.text = String(no)+"."+str
                                    self.label.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
                                    self.viewInScrollView.addSubview(self.label)
                                    self.labels.append(self.label)
                                    pointY += 60
                                    no += 1
                                }
                            }
                            
                        } catch {
                            print("something error")
                        }
                    })
                    
                    dataTask.resume()
                }
            }
            
            
            
        } else if(quotes_ActorsSelected == false) {
            print("Select Quotes or Actors from segemnted control")
        }
        
    }
    
}

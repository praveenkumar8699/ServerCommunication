//
//  ViewController.swift
//  ServerCommunication
//
//  Created by praveen Kumar on 25/04/19.
//  Copyright © 2019 praveen Kumar. All rights reserved.
//

import UIKit

class TempConverterController: UIViewController,UITextFieldDelegate {
    
    //Declaring Global Variables
    @IBOutlet weak var tempTextField: UITextField!
    @IBOutlet weak var tempSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tempLabel: UILabel!
    var request : URLRequest!
    var dataTask : URLSessionDataTask!
    var conversionTypeSelected : Bool!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Delegates and necessary things
        tempTextField.delegate = self
        tempSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        tempSegmentedControl.addTarget(self, action: #selector(segmentedControl(segmentedControl:)), for: .valueChanged)
        conversionTypeSelected = false
    }
    
    //Highlighting Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        textField.layer.borderWidth = 5
        textField.layer.cornerRadius = 5
        
    }
    
    //Removing Highlights Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = .none
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 0
        
    }
    
    //Boolean for segemented control
    @objc func segmentedControl(segmentedControl : UISegmentedControl) {
        conversionTypeSelected = true
    }
    
    //on Click of Convert
    @IBAction func onConvertPress(_ sender: UIButton) {
        
        
        
        if(tempTextField.hasText && conversionTypeSelected) {// if textfield has data and segment is selected
            
            activityIndicator.startAnimating()
            
            print("convert button pressed")
            print("Data in text Field : \(tempTextField.text!)")
            print("Conversion type : \(tempSegmentedControl.titleForSegment(at: tempSegmentedControl.selectedSegmentIndex)!)")
            
            request = URLRequest(url: URL(string: "https://www.brninfotech.com/tws/TempConverter.php")!)
            request.httpMethod = "POST"
            let dataToSend = "convertType=\(tempSegmentedControl.titleForSegment(at: tempSegmentedControl.selectedSegmentIndex)!)&temp=\(tempTextField.text!)"
            request.httpBody = dataToSend.data(using: String.Encoding.utf8)
            
            dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                print(data!)
                
                do {
                    let convertedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    print(convertedData)
                    
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tempLabel.textAlignment = .center
                        self.tempLabel.text =  "\(convertedData)"
                        self.tempLabel.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
                        
                    }
                } catch {
                    print("something error")
                }
            })
            
            dataTask.resume()
            
        } else if(tempTextField.hasText == false) {//prompt user to enter 
            print("Enter data in the text field")
        } else if(conversionTypeSelected == false) {
            print("Select conversion type from segmented control")
        }
        
    }
    

}


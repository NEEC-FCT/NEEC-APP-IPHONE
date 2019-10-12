//
//  Register.swift
//  Example
//
//  Created by NEEC on 12/10/2019.
//  Copyright © 2019 Ezequiel Scaruli. All rights reserved.
//

import Foundation
import UIKit



class Register: UIViewController  {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var passConfirmText: UITextField!
    
    
    @IBAction func registerClicked(_ sender: Any) {
        
        
        
        
        let key = UIDevice.current.identifierForVendor?.uuidString
        print(key!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://neecapp.neec-fct.com/Register.php")! as URL)
        request.httpMethod = "POST"
        let postString = "email=\(emailText.text!)&password=\(passText.text!)&IMEI=\(key ?? "123")&hex=\(key ?? "123")"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                print( json["success"]!)
                DispatchQueue.main.async {
                    if(  json["success"] as! Int == 1){
                        UserDefaults.standard.set( key, forKey: "IMEI")
                        let alert = UIAlertController(title: "Sucesso", message: "Aguarde para ser aprovado", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
                        
                        self.present(alert, animated: true)
                    }
                    else{
                        let alert = UIAlertController(title: "Erro" , message: "Algo de errado aconteceu", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        
                        self.present(alert, animated: true)
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.hideKeyboardWhenTappedAround() 
        
     
    }
    
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

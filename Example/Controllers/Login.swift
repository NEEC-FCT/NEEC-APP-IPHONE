//
//  Login.swift
//  Example
//
//  Created by NEEC on 12/10/2019.
//  Copyright © 2019 Ezequiel Scaruli. All rights reserved.
//

import Foundation
import UIKit

class Login: UIViewController  {


    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        
        if(emailText.text!.count < 1 || passText.text!.count < 1){
            let alert = UIAlertController(title: "Erro" , message:  "Os campos tem de estar preenchidos", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            
            self.present(alert, animated: true)
        }
        else{
        
        let key = UserDefaults.standard.string(forKey: "IMEI") ?? "571FB4F2-CD06-4678-96EC-B6F376F24B07"
        print(key)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://neecapp.neec-fct.com/LoginV2.php")! as URL)
        request.httpMethod = "POST"
        let postString = "email=\(emailText.text!)&password=\(passText.text!)&IMEI=\(key ?? "123")"
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
                        
                        UserDefaults.standard.set( json["token"] as! String , forKey: "token")
                        UserDefaults.standard.set( json["cargo"] as! String , forKey: "cargo")
                        UserDefaults.standard.set( json["nome"] as! String , forKey: "nome")
                        UserDefaults.standard.set( self.emailText.text!, forKey: "email")
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "Menu")
                        self.present(balanceViewController, animated: true, completion: nil)
                        
                    }
                    else{
                        let alert = UIAlertController(title: "Erro" , message:  json["mensagem"] as! String, preferredStyle: .alert)
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
       //checka se ja fez login
        let name = UserDefaults.standard.string(forKey: "token") ?? " "
        if(name.count > 5){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "Menu")
            self.present(balanceViewController, animated: true, completion: nil)
        }

    }
    
 }

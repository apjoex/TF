//
//  CreateAccountViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 8/2/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btn: RoundedButton!
    @IBOutlet weak var label: UILabel!
    
    var isSigningIn = false
    
    var callback : ((String) -> Void)?
    
    var enteredName : String{
        return name?.text ?? ""
    }
    
    var enteredEmail : String {
        return email?.text ?? ""
    }
    
    var enteredPassword: String {
        return password?.text ?? ""
    }
    
    var rootRef : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        container.layer.cornerRadius = 10
        
        rootRef = FIRDatabase.database().reference()
        
    }

    
    @IBAction func showSignIn(_ sender: UIButton) {
        if(isSigningIn){
            //Sign in screen
            label.text = "Set up profile"
            btn.setTitle("Create", for: .normal)
            name.isHidden = false;
            sender.setTitle("Sign in", for: .normal)
            isSigningIn = false
        }else{
            //Creat account screen
            label.text = "Sign in"
            btn.setTitle("Sign in", for: .normal)
            name.isHidden = true;
            sender.setTitle("Create account", for: .normal)
            isSigningIn = true
        }
       
    }
    
    @IBAction func proceed(_ sender: Any) {
        
        password.resignFirstResponder()
        
        if isSigningIn {
            
            //Sign in account in Firebase
            
            if !enteredEmail.isEmpty, !enteredPassword.isEmpty {
                
                self.btn.isEnabled = false
                self.btn.setTitle("Signing in...", for: .normal)
                
                FIRAuth.auth()?.signIn(withEmail: enteredEmail, password: enteredPassword, completion: { (user: FIRUser?, error: Error?) in
                
                    if(error == nil){
                        print("User id: \(String(describing: user?.email))")
                        self.callback?("Signed in")
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        
                        self.btn.isEnabled = true
                        self.btn.setTitle("Sign in", for: .normal)
                        
                        print("Error: \(String(describing: error?.localizedDescription))")
                        
                        let alert = UIAlertController(title: "Whoops!", message: error?.localizedDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                            alert.dismiss(animated: true, completion: nil)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        
                    }
                })
            }
            
        }else{
            
              //Create account in Firebase
            
            if !enteredEmail.isEmpty, !enteredPassword.isEmpty, !enteredName.isEmpty {
                
                btn.isEnabled = false
                btn.setTitle("Creating...", for: .normal)
                
                FIRAuth.auth()!.createUser(withEmail: enteredEmail, password: enteredPassword, completion: { (user: FIRUser?, error: Error?) in
                    if error != nil {
                        
                        self.btn.isEnabled = true
                        self.btn.setTitle("Create", for: .normal)
                        
                        let alert = UIAlertController(title: "Whoops!", message: error?.localizedDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                            alert.dismiss(animated: true, completion: nil)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        
                        print("Error: \(String(describing: error?.localizedDescription))")
                    }else{
                        
                        let userData = UserData(uid: user!.uid, name: self.enteredName, email: self.enteredEmail)
                        
                        self.rootRef.child("users/\(user!.uid)").setValue(userData.dict)
                        
                        print("User: \(String(describing: user!.uid))")
                        self.callback?("Hi")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            
            }

        }
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case name:
            print("This is for name")
            email.becomeFirstResponder()
            return true
        case email:
            print("This is for email")
            password.becomeFirstResponder()
            return true
        case password:
            password.resignFirstResponder()
            return true
        default:
            print("Default")
            return false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}

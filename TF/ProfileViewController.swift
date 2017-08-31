//
//  ProfileViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 7/25/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var activeProfileView: UIView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var playerStatus: UILabel!
    @IBOutlet var navBar: UINavigationItem!
    
    @IBOutlet var editBtn: UIBarButtonItem!
    @IBOutlet var settingsBtn: UIBarButtonItem!
    
    
    var user : UserData? = nil {
        didSet{
            if(user != nil){
                updateUI(user)
                activeProfileView.alpha = 1.0
                print("Entered user details : \(user!.uid)")
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.rightBarButtonItems?.removeAll()
        navBar.rightBarButtonItems?.append(settingsBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(_ user: UserData?){
        
        profileName.text = user?.name.uppercased()
        playerStatus.text = "Rookie"
        
        navBar.rightBarButtonItems?.removeAll()
        navBar.rightBarButtonItems?.append(settingsBtn)
        navBar.rightBarButtonItems?.append(editBtn)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateAccountModal" {
            let newVC = segue.destination as? CreateAccountViewController
            newVC?.callback = { userData in
                self.user = userData
            }
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Edit profile", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Profile photo", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.changePhoto()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Name", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            //self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func changePhoto(){
    
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    
    }
    
    
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func printMessage(string: String){
        print(string)
    }
    
    func photoLibrary()
    {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     //   self.printMessage(string: "Picker code reach here")
        print(info)
        self.dismiss(animated: true, completion: nil)
    }
    

}

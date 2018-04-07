//
//  ViewController.swift
//  MiviTest
//
//  Created by Moriarty on 06/04/18.
//  Copyright © 2018 Ramdhas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,JsonHandlerDelegate {

    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    let jsonHandler = JsonHandler()
    var userDataAttributes : NSDictionary = [:]
    var services : NSDictionary = [:]
    var subscriptions : NSDictionary = [:]
    var products : NSDictionary = [:]
    
    var isLoginSuccessfulCalled = false
    var isErrorHandlerCalled = false
    var isLoginInputHasEmpty = false
    var isJsonParseSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Set Custom Placeholder color for the textfield */
        setTextfieldPlaceHolderColor()
        
        /* Setup Json Handler delegate */
        jsonHandler.delegate = self
        jsonHandler.fetchDataFromJsonFile()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    /* Submit action: Process email_Id and Contact number */
    @IBAction func submitAction(_ sender: Any) {
        let email_ID = getEmailID()
        let contactNo = getContactNumber()
        guard (emailID.text != "") && (contactNumber.text != "") else {
            isLoginInputHasEmpty = true
            return
        }
        
        if email_ID==emailID.text && contactNo==contactNumber.text {
            isLoginSuccessfulCalled=true
            performSegue(withIdentifier: kLoginToHome, sender: self)
        } else {
            isErrorHandlerCalled = true
            let alertController = UIAlertController(title: kAlert, message: kCredentialsMismatch, preferredStyle: .alert)
            let okAction = UIAlertAction(title: kOK, style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    /* Get email_id from collection.json*/
    func getEmailID() -> String {
        let attributes = userDataAttributes.value(forKey: kAttributes) as? NSDictionary
        return attributes?.value(forKey: kEmail) as! String
    }

    /* Get contact number from collection.json*/
    func getContactNumber() -> String {
        let attributes = userDataAttributes.value(forKey: kAttributes) as? NSDictionary
        return attributes?.value(forKey: kContactNumber) as! String
    }


    /* Delegate method for json handler */
    func didCompleteRequest(result: NSDictionary, message: String) {
        if message == kSuccess {
            isJsonParseSuccess = true;
            userDataAttributes = result.value(forKey: kData) as! NSDictionary
            let included = result.value(forKey: kIncluded) as! NSArray
            services = included[0] as! NSDictionary
            subscriptions = included[1] as! NSDictionary
            products = included[2] as! NSDictionary
        } else {
            let alertController = UIAlertController(title: kAlert, message: kParseFailed, preferredStyle: .alert)
            let okAction = UIAlertAction(title: kOK, style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    /* Pass data to userinfo Viewcontroller */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userInfoVC = segue.destination as? UserInfoViewController
        userInfoVC?.services = services.value(forKey: kAttributes) as! NSDictionary
        userInfoVC?.subscriptions = subscriptions.value(forKey: kAttributes) as! NSDictionary
        userInfoVC?.products = products.value(forKey: kAttributes) as! NSDictionary
    }
    
    
    /*Set Custom Placeholder color for the textfield */
    func setTextfieldPlaceHolderColor() -> Void {
        emailID.attributedPlaceholder = NSAttributedString(string: kEnterEmailID,
                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        contactNumber.attributedPlaceholder = NSAttributedString(string: kEnterContactNumber,
                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }
    
    /* Dismiss keyboard on click return */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


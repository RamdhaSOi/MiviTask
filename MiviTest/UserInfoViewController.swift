//
//  UserInfoViewController.swift
//  MiviTest
//
//  Created by Moriarty on 06/04/18.
//  Copyright © 2018 Ramdhas. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var services : NSDictionary = [:]
    var subscriptions : NSDictionary = [:]
    var products : NSDictionary = [:]
    var userInformation : NSDictionary = [:]
    
    @IBOutlet weak var userInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformation = subscriptions.copy() as! NSDictionary
        
        // Do any additional setup after loading the view.
    }

    /* Number of rows in section*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInformation.count
    }
    
    /* Cell for row at indexpath */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = userInfoTableView.dequeueReusableCell(withIdentifier: kInfoTabelCellID) as UITableViewCell!
        let userInfoKeys = userInformation.allKeys as NSArray
        let key = userInfoKeys[indexPath.row] as! String
        let value = userInformation.value(forKey: key) as AnyObject
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = String(describing: value)
        return cell
    }
    
    /* Back button action */
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /* Information Section action */
    @IBAction func informationSectionAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            userInformation = subscriptions.copy() as! NSDictionary
            break;
        case 1:
            userInformation = products.copy() as! NSDictionary
            break;
        case 2:
            userInformation = services.copy() as! NSDictionary
            break;
        default:
            break;
        }
        userInfoTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

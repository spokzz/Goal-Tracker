//
//  MenuVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/11/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var sideViewUserProfileImage: customizeUIImageView!
    @IBOutlet weak var sideViewUserNameLabel: UILabel!
    @IBOutlet weak var sideViewTableView: UITableView!
    
    @IBOutlet weak var imageViewLeadConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewTrailConstraint: NSLayoutConstraint!
    
    //VIEW DID LOAD:
    override func viewDidLoad() {
        super.viewDidLoad()

        sideViewTableView.delegate = self
        sideViewTableView.dataSource = self
        
        //Rear VC width:
        self.revealViewController().rearViewRevealWidth = self.view.frame.width / 2
        
        //Image view and table view width:
        self.imageViewLeadConstraint.constant = (self.view.frame.width / 4) - 35
        self.tableViewTrailConstraint.constant = (self.view.frame.width / 4) - 8
    }

    //VIEW WILL APPEAR:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSideViewUI()
    }
    
    //IT WILL UPDATE THE SIDE VIEW PROFILE IMAGE AND USERNAME
    func updateSideViewUI() {
        
        if let profileImage = UserDefaults.standard.data(forKey: "userProfileImage") {
            sideViewUserProfileImage.image = UIImage(data: profileImage)
        }
        
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            sideViewUserNameLabel.text = userName
        }
        
    }


}

//TABLE VIEW:
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    //NUMBER OF ROWS:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getSideViewButtonLabel().count
    }
    
    //CELL FOR EACH ROW:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "sideViewCell", for: indexPath) as? SideViewCell else {return UITableViewCell()}
        cell.customizeView(buttonInfo: DataService.instance.getSideViewButtonLabel()[indexPath.row])
        return cell
    }
    
    //ROW IS SELECTED:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell: SideViewCell = tableView.cellForRow(at: indexPath) as! SideViewCell
        
        if cell.title.text! == "Home" {

            guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "homeVC") as? HomeVC else {return }
            self.revealViewController().pushFrontViewController(homeVC, animated: true)
        }
        else if cell.title.text! == "History" {
            
            guard let historyVC = storyboard?.instantiateViewController(withIdentifier: "historyVC") as? HistoryVC else {return }
            self.revealViewController().pushFrontViewController(historyVC, animated: true)
        }
        
        else if cell.title.text! == "Help" {
            
            guard let helpVC = storyboard?.instantiateViewController(withIdentifier: "helpVC") as? HelpVC else {return }
          // let newFrontVC = UINavigationController.init(rootViewController: helpVC)
            self.revealViewController().pushFrontViewController(helpVC, animated: true)
        }
        
        else if cell.title.text! == "My Profile" {
            
            guard let myProfileVC = storyboard?.instantiateViewController(withIdentifier: "myProfileVC") as? MyProfileVC else {return }
            self.revealViewController().pushFrontViewController(myProfileVC, animated: true)
        }
        
}
}

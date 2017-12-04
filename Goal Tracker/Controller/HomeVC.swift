//
//  ViewController.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/2/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var startingView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
    }

    @IBAction func goalButtonPressed(_ sender: UIButton) {
        
       guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return }
        present(createGoalVC, animated: true, completion: nil)
        
    }
    


}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as? HomeCell else {return UITableViewCell()}
        cell.customizeView(goalDescription: "Do programming 8 hours a day.", goalType: "Short Term")
        return cell
    }
    
}
























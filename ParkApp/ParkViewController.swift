//
//  ParkViewController.swift
//  ParkApp
//
//  Created by ntt on 2017/09/13.
//  Copyright © 2017年 nttresonant. All rights reserved.
//

import UIKit
import NCMB

class ParkViewController: UIViewController, UITableViewDataSource {
    
    var titleArray = ["公園名", "所在地", "所要時間", "遊具の種類"]
    var okArray = ["自転車", "水泳", "期待度"]


    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var parkInfoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkInfoTableView.dataSource = self
        
        let parkInfoNib = UINib(nibName: "ParkInfoTableViewCell", bundle: Bundle.main)
        let okNib = UINib(nibName: "OKTableViewCell", bundle: Bundle.main)
        
        parkInfoTableView.register(parkInfoNib, forCellReuseIdentifier: "ParkInfoCell")
        parkInfoTableView.register(okNib, forCellReuseIdentifier: "OKCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count + okArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parkInfoCell = tableView.dequeueReusableCell(withIdentifier: "ParkInfoCell") as! ParkInfoTableViewCell
        
        let okCell = tableView.dequeueReusableCell(withIdentifier: "OKCell") as! OKTableViewCell
        
        if indexPath.row < 4 {
            parkInfoCell.titleLabel.text = titleArray[indexPath.row]
            // parkInfoCell.contentTextField.text =
            
            return parkInfoCell
        } else {
            okCell.titleLabel.text = okArray[indexPath.row - titleArray.count]
            return okCell
        }
    }
    


}

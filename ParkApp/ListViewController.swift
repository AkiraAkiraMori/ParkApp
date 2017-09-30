//
//  ViewController.swift
//  ParkApp
//
//  Created by ntt on 2017/09/13.
//  Copyright © 2017年 nttresonant. All rights reserved.
//

import UIKit
import NCMB

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memoArray = [NCMBObject]()
    
    @IBOutlet var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTableView.dataSource = self
        memoTableView.delegate = self
        
        
        memoTableView.tableFooterView = UIView()

        //TableViewの背景に画像を設定
//        super.viewDidLoad()
//        let image = UIImage(named: "weather.png")
//        let imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView.frame.width, self.tableView.frame.height))
//        imageView.image = image
//        self.tableView.backgroundView = imageView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = memoArray[indexPath.row].object(forKey: "parkName") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toAdd", sender: nil)
        
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender:Any?) {

        //次の画面の取得（Add）
     if segue.identifier == "toAdd" {
            let parklViewController = segue.destination as! ParkViewController
        
        //受け渡し
        if let selectedIndex = memoTableView.indexPathForSelectedRow {
            parklViewController.toObject = memoArray[selectedIndex.row]
        }
        
        
        
        }
        
    }
    
    func loadData() {
        
        let query = NCMBQuery(className: "Park")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
                
            } else {
                self.memoArray = result as! [NCMBObject]
                self.memoTableView.reloadData()
                
            }
        })
        
    }

     @IBAction func back() {
       //戻るコード
       self.dismiss(animated: true, completion: nil)
        
    }

}


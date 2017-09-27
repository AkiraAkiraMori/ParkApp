//
//  ParkViewController.swift
//  ParkApp
//
//  Created by ntt on 2017/09/13.
//  Copyright © 2017年 nttresonant. All rights reserved.
//

import UIKit
import NCMB

class ParkViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate {
    
    var titleArray = ["公園名", "所在地", "所要時間", "遊具の種類", "自転車", "水遊び", "期待度", "滞在時間", "自分の満足度", "子供の満足度"]
    var okArray = ["感想"]


    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var parkInfoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkInfoTableView.dataSource = self
        parkInfoTableView.delegate = self
        
        let parkInfoNib = UINib(nibName: "ParkInfoTableViewCell", bundle: Bundle.main)
        let okNib = UINib(nibName: "OKTableViewCell", bundle: Bundle.main)
        
        parkInfoTableView.register(parkInfoNib, forCellReuseIdentifier: "ParkInfoCell")
        parkInfoTableView.register(okNib, forCellReuseIdentifier: "OKCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 10 {
            return 55
        } else {
            return 155
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count + okArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parkInfoCell = tableView.dequeueReusableCell(withIdentifier: "ParkInfoCell") as! ParkInfoTableViewCell
        
        let okCell = tableView.dequeueReusableCell(withIdentifier: "OKCell") as! OKTableViewCell
        
        if indexPath.row < 10 {
            parkInfoCell.titleLabel.text = titleArray[indexPath.row]
            // parkInfoCell.contentTextField.text =
            
            return parkInfoCell
        }
        
        else {
            okCell.titleLabel.text = okArray[indexPath.row - titleArray.count]
            return okCell
        }
    }

    
//画像登録
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
//        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
//        let resizedImage = selectedImage.scale(byFactor: 0.4)
    
//        picker.dismiss(animated: true, completion: nil)
    
//        let data = UIImagePNGRepresentation(resizedImage!)
//        let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: data) as! NCMBFile
//        file.saveInBackground( { (error) in
//            if error != nil {
//                print(error)
//            } else {
//                self.userImageView.image = selectedImage
//            }
//        }) { (progress) in
//            print(progress)
//        }
//    }

    
//カメラ起動、アルバム起動
    
    @IBAction func selectImage() {
        let actionController = UIAlertController(title: "画像の選択", message: "選択して下さい",
                                                 preferredStyle: . actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //　カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
                
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではカメラは使用できません")
            }
        }
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            // アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではフォトライブラリは使用できません")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionController.dismiss(animated: true, completion: nil)
        }
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        self.present(actionController, animated: true, completion: nil)
        
    }

}

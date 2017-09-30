//
//  ParkViewController.swift
//  ParkApp
//
//  Created by ntt on 2017/09/13.
//  Copyright © 2017年 nttresonant. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class ParkViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITextFieldDelegate {
    
    var titleArray = ["公園名", "所在地", "所要時間", "遊具の種類", "自転車", "水遊び", "期待度", "滞在時間", "自分の満足度", "子供の満足度"]
    var okArray = ["感想"]
    
    var toObject: NCMBObject?

    //入力項目文宣言する
    
    var parkName: String?
    
    var place: String?

    var time: String?
    
    var playGround: String?
    
    var bicycle: String?

    var swimming: String?

    var expectations: String?
    
    var stay: String?
    
    var mySatisfaction: String?
    
    var childSatisfaction: String?
    
    var impressions: String?


    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userImageView2: UIImageView!
    
    @IBOutlet var parkInfoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        parkInfoTableView.dataSource = self
        parkInfoTableView.delegate = self
        
        let parkInfoNib = UINib(nibName: "ParkInfoTableViewCell", bundle: Bundle.main)
        let okNib = UINib(nibName: "OKTableViewCell", bundle: Bundle.main)
        
        parkInfoTableView.register(parkInfoNib, forCellReuseIdentifier: "ParkInfoCell")
        parkInfoTableView.register(okNib, forCellReuseIdentifier: "OKCell")
    
    
        //TableViewの背景に画像を設定
        super.viewDidLoad()
        let image = UIImage(named: "diamond_upholstery_@2X.png")
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: self.parkInfoTableView.frame.width, height: self.parkInfoTableView.frame.height))
        imageView.image = image
        self.parkInfoTableView.backgroundView = imageView
    
    }

//登録画像の表示
//    override func viewWillAppear(_ animated: Bool) {
//        let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: nil) as! NCMBFile
//        file.getDataInBackground { (data, error) in
//            if error != nil {
//                print(error)
//
//            } else {
//                if data != nil {
//                    let image = UIImage(data: data!)
//                    self.userImageView.image = image
//                }
                
//            }
            
            
//        }
        
//    }

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
        
        print(toObject)
        
        if indexPath.row < 10 {
            parkInfoCell.titleLabel.text = titleArray[indexPath.row]
            parkInfoCell.contentTextField.delegate = self
            
            parkInfoCell.contentTextField.tag = indexPath.row
 
  //受け渡されたデータをアプリ上に表示する
            
            if indexPath.row == 0 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "parkName") as? String
            
            } else if indexPath.row == 1 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "place") as? String
                
            } else if indexPath.row == 2 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "time") as? String
                
            } else if indexPath.row == 3 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "playGround") as? String
                
            } else if indexPath.row == 4 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "bicycle") as? String
                
            } else if indexPath.row == 5 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "swimming") as? String
                
            } else if indexPath.row == 6 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "expectations") as? String
                
            } else if indexPath.row == 7 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "stay") as? String
                
            } else if indexPath.row == 8 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "mySatisfaction") as? String
                
            } else if indexPath.row == 9 {
                parkInfoCell.contentTextField.text = toObject?.object(forKey: "childSatisfaction") as? String
                
            }
            
            return parkInfoCell
        }
        
        else {
            okCell.titleLabel.text = okArray[indexPath.row - titleArray.count]
            okCell.contentTextField.delegate = self
            okCell.contentTextField.tag = 10
            if indexPath.row == 10 {
                okCell.contentTextField.text = toObject?.object(forKey: "impressions") as? String
            }
            
            return okCell
        }
    }

    
//画像登録
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
        let resizedImage = selectedImage.scale(byFactor: 0.4)
    
        picker.dismiss(animated: true, completion: nil)
    
        let data = UIImagePNGRepresentation(resizedImage!)
        
        
        let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: data) as! NCMBFile
        file.saveInBackground( { (error) in
            if error != nil {
                print(error)
            } else {
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
    }

    
//カメラ起動、アルバム起動
    
    
    @IBAction func selectImage() {
        let actionController = UIAlertController(title: "写真の選択", message: "選択して下さい",
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
        let albumAction = UIAlertAction(title: "アルバム", style: .default) { (action) in
            // アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではアルバムは使用できません")
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
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            parkName = textField.text
            
        } else if textField.tag == 1 {
            place = textField.text
            
        } else if textField.tag == 2 {
            time = textField.text
            
        } else if textField.tag == 3 {
            playGround = textField.text
            
        } else if textField.tag == 4 {
            bicycle = textField.text
            
        } else if textField.tag == 5 {
            swimming = textField.text
            
        } else if textField.tag == 6 {
            expectations = textField.text
            
        } else if textField.tag == 7 {
            stay = textField.text
            
        } else if textField.tag == 8 {
            mySatisfaction = textField.text
            
        } else if textField.tag == 9 {
            childSatisfaction = textField.text
            
        } else if textField.tag == 10 {
            impressions = textField.text
            
        }
        
        print(textField.text)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField.text)
        
//        if textField.tag == 0 {
//            parkName = textField.text
//            
//        } else if textField.tag == 1 {
//            place = textField.text
//
//        } else if textField.tag == 2 {
//            time = textField.text
//            
//        } else if textField.tag == 3 {
//            playGround = textField.text
//            
//        } else if textField.tag == 4 {
//            bicycle = textField.text
//            
//        } else if textField.tag == 5 {
//            swimming = textField.text
//            
//        } else if textField.tag == 6 {
//            expectations = textField.text
//            
//        } else if textField.tag == 7 {
//            stay = textField.text
//            
//        } else if textField.tag == 8 {
//            mySatisfaction = textField.text
//
//        } else if textField.tag == 9 {
//            childSatisfaction = textField.text
//            
//        } else if textField.tag == 10 {
//            impressions = textField.text
//            
//        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // キーボードを消す
        
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func save() {
        
        let object = NCMBObject(className: "Park")
        object?.setObject(parkName, forKey: "parkName")
        object?.setObject(place, forKey: "place")
        object?.setObject(time, forKey: "time")
        object?.setObject(playGround, forKey: "playGround")
        object?.setObject(bicycle, forKey: "bicycle")
        object?.setObject(swimming, forKey: "swimming")
        object?.setObject(expectations, forKey: "expectations")
        object?.setObject(stay, forKey: "stay")
        object?.setObject(mySatisfaction, forKey: "mySatisfaction")
        object?.setObject(childSatisfaction, forKey: "childSatisfaction")
        object?.setObject(impressions, forKey: "impressions")
        
        /*let nameCell = parkInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(nameCell.contentTextField.text, forKey: "parkName")
        
        let placeCell = parkInfoTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(placeCell.contentTextField.text, forKey: "place")

        let timeCell = parkInfoTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(timeCell.contentTextField.text, forKey: "time")
        
        let playGroundCell = parkInfoTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(playGroundCell.contentTextField.text, forKey: "playGround")
        
        let bicycleCell = parkInfoTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(bicycleCell.contentTextField.text, forKey: "bicycle")
        
        let swimmingCell = parkInfoTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(swimmingCell.contentTextField.text, forKey: "swimming")
        
        let expectationsCell = parkInfoTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(expectationsCell.contentTextField.text, forKey: "expectations")

        let stayCell = parkInfoTableView.cellForRow(at: IndexPath(row: 7, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(stayCell.contentTextField.text, forKey: "stay")

        let mySatisfactionCell = parkInfoTableView.cellForRow(at: IndexPath(row: 8, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(mySatisfactionCell.contentTextField.text, forKey: "mySatisfaction")

        let childSatisfactionCell = parkInfoTableView.cellForRow(at: IndexPath(row: 9, section: 0)) as! ParkInfoTableViewCell
        object?.setObject(childSatisfactionCell.contentTextField.text, forKey: "childSatisfaction")

        let impressionsCell = parkInfoTableView.cellForRow(at: IndexPath(row: 10, section: 0)) as! OKTableViewCell
        object?.setObject(impressionsCell.contentTextView.text, forKey: "impressions")*/

        object?.saveInBackground({ (error)in
            if error != nil {
                print(error)
            
            } else {
                self.navigationController?.popViewController(animated: true)
                
            }
            
        })
        
    }
    
}

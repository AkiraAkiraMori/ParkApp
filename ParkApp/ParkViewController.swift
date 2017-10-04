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
import SVProgressHUD

class ParkViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITextFieldDelegate {
    
    var titleArray = ["名称", "所在地", "所要時間", "遊具の種類", "自転車", "水遊び", "期待度", "滞在時間", "自分の満足度", "子供の満足度"]
    var okArray = ["感想"]
    
    var toObject: NCMBObject?
    
    var park: Park!
    
    var isImage1Updated: Bool = false
    var isImage2Updated: Bool = false

    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userImageView2: UIImageView!
    
    @IBOutlet var parkInfoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        park = Park()
        park.parkName = toObject?.object(forKey: "parkName") as? String
        park?.place = toObject?.object(forKey: "place") as? String
        park?.time = toObject?.object(forKey: "time") as? String
        park?.playGround = toObject?.object(forKey: "playGround") as? String
        park?.bicycle = toObject?.object(forKey: "bicycle") as? String
        park?.swimming = toObject?.object(forKey: "swimming") as? String
        park?.expectations = toObject?.object(forKey: "expectations") as? String
        park?.stay = toObject?.object(forKey: "stay") as? String
        park?.mySatisfaction = toObject?.object(forKey: "mySatisfaction") as? String
        park?.childSatisfaction = toObject?.object(forKey: "childSatisfaction") as? String
        park?.impressions = toObject?.object(forKey: "impressions") as? String
        
        parkInfoTableView.dataSource = self
        parkInfoTableView.delegate = self
        
        let parkInfoNib = UINib(nibName: "ParkInfoTableViewCell", bundle: Bundle.main)
        let okNib = UINib(nibName: "OKTableViewCell", bundle: Bundle.main)
        
        parkInfoTableView.register(parkInfoNib, forCellReuseIdentifier: "ParkInfoCell")
        parkInfoTableView.register(okNib, forCellReuseIdentifier: "OKCell")
    
    
        //TableViewの背景に画像を設定
        let image = UIImage(named: "diamond_upholstery_@2X.png")
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: self.parkInfoTableView.frame.width, height: self.parkInfoTableView.frame.height))
        imageView.image = image
        self.parkInfoTableView.backgroundView = imageView
        
        // すでに登録されているものを選択した場合
        if toObject != nil {
            
            let fileName1 = toObject!.objectId + "1"
            
            let fileName2 = toObject!.objectId + "2"
            
            // 画像を読み込み
            let file = NCMBFile.file(withName: fileName1, data: nil) as! NCMBFile
            file.getDataInBackground({ (data, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    let image = UIImage(data: data!)
                    self.userImageView.image = image
                }
            })
            
            let file2 = NCMBFile.file(withName: fileName2, data: nil) as! NCMBFile
            file2.getDataInBackground({ (data, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    let image = UIImage(data: data!)
                    self.userImageView2.image = image
                }
            })

        }
    
    }

        //登録画像の表示①
        override func viewWillAppear(_ animated: Bool) {
        let file = NCMBFile.file(withName: Date().description, data: nil) as! NCMBFile
            SVProgressHUD.show(withStatus: "ロード中...")
        file.getDataInBackground { (data, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                print(error)
            } else {
                if data != nil {
                    let image = UIImage(data: data!)
                    self.userImageView.image = image
                }
            }
            
        }

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
        
        if picker.restorationIdentifier ==  "1" {
            isImage1Updated = true
            userImageView.image = resizedImage
        } else {
            isImage2Updated = true
            userImageView2.image = resizedImage
        }
        
        
        
    
        picker.dismiss(animated: true, completion: nil)
    }

    
//カメラ起動、アルバム起動
    
    @IBAction func selectImage(button: UIButton) {
        let actionController = UIAlertController(title: "写真の選択", message: "選択して下さい",
                                                 preferredStyle: . actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            
            //　カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
                
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                
                if button.tag == 1 {
                    // 左のボタンだったら
                    picker.restorationIdentifier = "1"
                } else {
                    picker.restorationIdentifier = "2"
                }
                
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
                
                if button.tag == 1 {
                    // 左のボタンだったら
                    picker.restorationIdentifier = "1"
                } else {
                    picker.restorationIdentifier = "2"
                }
                
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
            park.parkName = textField.text ?? ""
            
        } else if textField.tag == 1 {
            park.place = textField.text
            
        } else if textField.tag == 2 {
            park.time = textField.text
            
        } else if textField.tag == 3 {
            park.playGround = textField.text
            
        } else if textField.tag == 4 {
            park.bicycle = textField.text
            
        } else if textField.tag == 5 {
            park.swimming = textField.text
            
        } else if textField.tag == 6 {
            park.expectations = textField.text
            
        } else if textField.tag == 7 {
            park.stay = textField.text
            
        } else if textField.tag == 8 {
            park.mySatisfaction = textField.text
            
        } else if textField.tag == 9 {
            park.childSatisfaction = textField.text
            
        } else if textField.tag == 10 {
            park.impressions = textField.text
            
        }
        
        print(textField.text)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // キーボードを消す
        
        textField.resignFirstResponder()
        return true
        
    }
 
    //登録ボタン
    @IBAction func save() {
        
        if (park.parkName?.characters.count)! > 0 {
            
            
            // parkNameの検索
            let query = NCMBQuery(className: "Park")
            query?.whereKey("parkName", equalTo: park.parkName!)
            query?.findObjectsInBackground({ (result, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    if (result?.count)! > 0 {
                        let object = result?.first as! NCMBObject
                        object.setObject(self.park.parkName, forKey: "parkName")
                        object.setObject(self.park.place, forKey: "place")
                        object.setObject(self.park.time, forKey: "time")
                        object.setObject(self.park.playGround, forKey: "playGround")
                        object.setObject(self.park.bicycle, forKey: "bicycle")
                        object.setObject(self.park.swimming, forKey: "swimming")
                        object.setObject(self.park.expectations, forKey: "expectations")
                        object.setObject(self.park.stay, forKey: "stay")
                        object.setObject(self.park.mySatisfaction, forKey: "mySatisfaction")
                        object.setObject(self.park.childSatisfaction, forKey: "childSatisfaction")
                        object.setObject(self.park.impressions, forKey: "impressions")
                        
                        
                        object.saveInBackground({ (error) in
                            if error != nil {
                                print(error)
                                
                            } else {
                                
                                if self.isImage1Updated == true {
                                    
                                    let image1 = self.userImageView.image
                                    
                                    let fileName = object.objectId + "1"
                                    
                                    let data = UIImagePNGRepresentation(image1!)
                                    
                                    let file = NCMBFile.file(withName: fileName, data: data) as! NCMBFile
                                    file.saveInBackground( { (error) in
                                        if error != nil {
                                            print(error)
                                        } else {
                                            self.isImage1Updated = false
                                        }
                                    }) { (progress) in
                                        print(progress)
                                    }
                                }
                                
                                if self.isImage2Updated == true {
                                    
                                    let image2 = self.userImageView2.image
                                    
                                    let fileName = object.objectId + "2"
                                    
                                    let data = UIImagePNGRepresentation(image2!)
                                    
                                    let file = NCMBFile.file(withName: fileName, data: data) as! NCMBFile
                                    file.saveInBackground( { (error) in
                                        if error != nil {
                                            print(error)
                                        } else {
                                            self.isImage2Updated = false
                                        }
                                    }) { (progress) in
                                        print(progress)
                                    }
                                }
                               
                                self.navigationController?.popViewController(animated: true)
                                
                            }
                            
                        })
                    } else {
                        // 登録済み出なければ新規登録
                        let object = NCMBObject(className: "Park")
                        object?.setObject(self.park.parkName, forKey: "parkName")
                        object?.setObject(self.park.place, forKey: "place")
                        object?.setObject(self.park.time, forKey: "time")
                        object?.setObject(self.park.playGround, forKey: "playGround")
                        object?.setObject(self.park.bicycle, forKey: "bicycle")
                        object?.setObject(self.park.swimming, forKey: "swimming")
                        object?.setObject(self.park.expectations, forKey: "expectations")
                        object?.setObject(self.park.stay, forKey: "stay")
                        object?.setObject(self.park.mySatisfaction, forKey: "mySatisfaction")
                        object?.setObject(self.park.childSatisfaction, forKey: "childSatisfaction")
                        object?.setObject(self.park.impressions, forKey: "impressions")
                        
                        
                        object?.saveInBackground({ (error) in
                            if error != nil {
                                print(error)
                                
                            } else {
                                
                                if self.isImage1Updated == true {
                                    
                                    let image1 = self.userImageView.image
                                    
                                    let fileName = (object?.objectId)! + "1"
                                    
                                    let data = UIImagePNGRepresentation(image1!)
                                    
                                    let file = NCMBFile.file(withName: fileName, data: data) as! NCMBFile
                                    file.saveInBackground( { (error) in
                                        if error != nil {
                                            print(error)
                                        } else {
                                            self.isImage1Updated = false
                                        }
                                    }) { (progress) in
                                        print(progress)
                                    }
                                }
                                
                                if self.isImage2Updated == true {
                                    
                                    let image2 = self.userImageView2.image
                                    
                                    let fileName = (object?.objectId)! + "2"
                                    
                                    let data = UIImagePNGRepresentation(image2!)
                                    
                                    let file = NCMBFile.file(withName: fileName, data: data) as! NCMBFile
                                    file.saveInBackground( { (error) in
                                        if error != nil {
                                            print(error)
                                        } else {
                                            self.isImage2Updated = false
                                        }
                                    }) { (progress) in
                                        print(progress)
                                    }
                                }
                                
                                
                                self.navigationController?.popViewController(animated: true)
                                
                            }
                            
                        })
                    }
                }
            })
            
        } else {
            let alert = UIAlertController(title: "未入力", message: "公園名を入力してください", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func back() {
        //戻るコード
        self.navigationController?.popViewController(animated: true)
    }
}

//削除ボタン
//    @IBAction func delete() {
//
//        selectedMemo.deleteInBackground{ (error) in
//            if error != nil {
//                SVProgressHUD.showError(withStatus: error?.localizedDescription)
//
//            } else {
//削除成功
//                let alertController = UIAlertController(title: "削除完了", message: "メモの削除が完了しました。メモ一覧に戻ります。", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default, handler: {(action) in
//                    self.navigationController?.popViewController(animated: true)
//                })
//                alertController.addAction(action)
//                self.present(alertController, animated: true, completion: nil)
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//    }


//過去の遺産

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



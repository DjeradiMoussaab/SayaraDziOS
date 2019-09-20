//
//  AccueilController.swift
//  SayaraDz
//
//  Created by Mac on 3/4/19.
//  Copyright © 2019 mossab. All rights reserved.
//
import SideMenu
import UIKit

class MarquesSuiviesCell: UICollectionViewCell  {
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}

class NouveautesCell: UICollectionViewCell  {
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}


class AccueilController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var marquesSuiviesCollectionView: UICollectionView!
    @IBOutlet weak var nouveautesCollectionView: UICollectionView!
    
    var versionsJSON: Array<VersionSuivie>?
    let versionImagesCache = NSCache<AnyObject, AnyObject>.init()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        nouveautesCollectionView.delegate = self
        nouveautesCollectionView.dataSource = self
        marquesSuiviesCollectionView.delegate = self
        marquesSuiviesCollectionView.dataSource = self
        self.initView()
        self.getAllVersionsSuivies()
    }
    
    func initView() {
        navBar.menuButton.setBackgroundImage(UIImage(named: "menu"), for: UIControlState.normal)
        navBar.menuButton.addTarget(self, action: #selector(AccueilController.ShowMenu(_:)), for: .touchUpInside)
        navBar.title.text = "Accueil"
    }
    
    @objc func ShowMenu(_ sender: UIButton) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! UISideMenuNavigationController
        menu.sideMenuManager!.menuPresentMode = .menuSlideIn
        menu.leftSide = true
        menu.menuWidth = UIScreen.main.bounds.width * 0.8
        menu.sideMenuManager.menuFadeStatusBar = false
        present(menu, animated: true, completion: nil)
    }
    
    var items = ["New Release !", "Old", "Used", "Good"]
    var names = ["SKODA fabia", "SEAT ibiza", "AUDI Q3", "PORSCHE 911"]
    var descriptions = ["So many things are waiting for you", "Haha this is a good one my friend", "take it or leave it offre", "it's not a porsche it's a proschaaaa"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ( versionsJSON != nil ) {
            return (versionsJSON?.count)!
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        if (collectionView.tag == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarquesSuiviesCell", for: indexPath as IndexPath) as! MarquesSuiviesCell
            if (versionsJSON?[indexPath.row].couleurs.count != 0 ) {
                if(versionsJSON?[indexPath.row].couleurs[0].CheminImage != nil) {
                    let urlString = URL(string: (versionsJSON?[indexPath.row].couleurs[0].CheminImage)!)
                    if let imageFromCache = versionImagesCache.object(forKey: urlString as AnyObject) as? UIImage {
                        cell.carImage.image = imageFromCache
                    } else {
                        var savedData: Data?
                        DispatchQueue.global(qos: .background).async {
                            if let data = try? Data(contentsOf: urlString!) {
                                savedData = data
                                let imageToCache = UIImage(data: data)
                                self.versionImagesCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                            }
                            DispatchQueue.main.async {
                                cell.carImage.image = UIImage(data: savedData!)
                            }
                        }
                    }
                }
            }
            cell.noteLabel.text = versionsJSON?[indexPath.row].modele.marque.NomMarque
            cell.descriptionLabel.text = "A partir de : \(versionsJSON?[indexPath.row].lignetarif.Prix ?? 0)"
            cell.carName.text = versionsJSON?[indexPath.row].NomVersion
            cell.nameView.layer.borderWidth = CGFloat(1)
            cell.nameView.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
            cell.layer.borderWidth = CGFloat(1)
            cell.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
            cell.layer.cornerRadius = 5.0
            return cell
        } else {
            let nouveautesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NouveautesCell", for: indexPath as IndexPath) as! NouveautesCell
            nouveautesCell.noteLabel.text = items[indexPath.row]
            nouveautesCell.descriptionLabel.text = descriptions[indexPath.row]
            nouveautesCell.carImage.image = UIImage(named: "arona")
            nouveautesCell.carName.text = names[indexPath.row]
            nouveautesCell.nameView.layer.borderWidth = CGFloat(1)
            nouveautesCell.nameView.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
            nouveautesCell.layer.borderWidth = CGFloat(1)
            nouveautesCell.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
            nouveautesCell.layer.cornerRadius = 5.0
            return nouveautesCell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(indexPath.item)!")
    }
    

    func getAllVersionsSuivies() {
        let defaults = UserDefaults.standard
        var idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")!
        idAutomobiliste = "380466752766558"
        VersionService.sharedInstance.getAllversionsSuivies(idAutomobiliste: idAutomobiliste, onSuccess: { data in
            let decoder = JSONDecoder()
            self.versionsJSON = try? decoder.decode(Array<VersionSuivie>.self, from: data)
            DispatchQueue.main.async {
                self.marquesSuiviesCollectionView.reloadData()
                print(self.versionsJSON?.count)
            }
        }, onFailure: { error in
            print(error)
        })
    }


}

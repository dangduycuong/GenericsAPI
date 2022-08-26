//
//  DicrectionVC.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/4/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import WebKit

class DataModel {
    var name: String?
}

class DicrectionVC: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.lineHeightMultiple = 1.25
            let attributes = [
                NSAttributedString.Key.font: UIFont(name: "PlayfairDisplay-Italic", size: 20)!,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let attributedPlaceholder = NSAttributedString(string: "Nhập tên bài thơ", attributes: attributes)
            textField.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var stringTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadSpinner.layer.cornerRadius = loadSpinner.frame.width / 2
        loadAddress()
        if(stringTitle.isEmpty){
            self.title = "V-Smart"
        } else {
            self.title = stringTitle
        }
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        
    }
    
//    func getLocation(){
//        self.showLoading()
//        VLocation.sharedInstance.getCurrentLocation { (currentLocation) in
//            self.hideLoading()
//            if let location = currentLocation {
//                self.latitude = String.init(describing: location.coordinate.latitude)
//                self.longitude = String.init(describing: location.coordinate.longitude)
//                print(self.latitude, self.longitude)
//            } else {
//                self.showAlertController(title: VTLocalizedString.localized(key: "Thông báo"), message: VTLocalizedString.localized(key: "Không thể lấy được vị trí, thử lại?"), cancelAction: nil, okAction: {
//                    self.getLocation()
//                })
//            }
//        }
//    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
        loadSpinner.isHidden = false
        loadSpinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")
        loadSpinner.stopAnimating()
        loadSpinner.isHidden = true
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("didFailLoadWithError")
        loadSpinner.stopAnimating()
        loadSpinner.isHidden = true
    }
    
    func loadAddress() {
        guard self.latitude != nil && self.longitude != nil else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn xoá", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "KHÔNG", style: .default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "CÓ", style: .default, handler: { (alertAction) in
                // do something
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let latitude = self.latitude!
        let longitude = self.longitude!
        let url = """
        https://www.google.com/maps/dir//\(latitude),\(longitude)/@\(latitude),\(longitude)z/data=!4m2!4m1!3e0
        """
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        print("Sucessfully")
    }
    
    
    @IBAction func onClickedReload(_ sender: Any) {
        loadAddress()
    }
    
    // MARK: Actions
    @IBAction func onClickedDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


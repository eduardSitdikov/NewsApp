//
//  OneNewsViewController.swift
//  NewsApp
//
//  Created by Eduard on 27/07/2019.
//  Copyright © 2019 Eduard. All rights reserved.
//

import UIKit
import SafariServices

class OneNewsViewController: UIViewController {

    var index: Int = 0
    var article: Article!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var loading: UIImageView!
    @IBOutlet weak var openSafari: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitle.text = article.title
        labelDescription.text = article.description
        
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage){
                if let date = try? Data(contentsOf: url){
                    self.imageView.image = UIImage(data: date)
                }
            }
        }
        if URL(string: article.url) == nil{
            openSafari.isEnabled = false
        }
    }
    
    @IBAction func pushOpenAction(_ sender: Any) {
        if let url = URL(string: article.url){
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

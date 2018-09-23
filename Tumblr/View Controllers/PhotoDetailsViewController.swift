//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by yijin Wang on 9/23/18.
//  Copyright © 2018 Yijin Wang. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
           photoImageView.af_setImage(withURL: url)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

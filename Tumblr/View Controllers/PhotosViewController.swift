//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by yijin Wang on 9/10/18.
//  Copyright © 2018 Yijin Wang. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var postOutlet: UITableView!
   
    var posts: [[String: Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.photoView.af_setImage(withURL: url!)
        }
        
        return cell
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        postOutlet.delegate = self
        postOutlet.dataSource = self
        postOutlet.rowHeight = 333
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.postOutlet.reloadData()
            }
        }
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        let cell = sender as! UITableViewCell
        if let indexPath = postOutlet.indexPath(for: cell){
            let post = posts[indexPath.row]
            var photos = post["photos"] as! [[String: Any]]
            let photo = photos [0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
        
            vc.url = url
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

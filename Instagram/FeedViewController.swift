//
//  FeedViewController.swift
//  Instagram
//
//  Created by user168934 on 4/25/20.
//  Copyright © 2020 user168934. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
       var posts = [PFObject]()
       
       override func viewDidLoad() {
           super.viewDidLoad()
          
           tableView.delegate = self
           tableView.dataSource = self
           
       }

       
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           let query = PFQuery(className: "Posts")
           query.includeKey("author")
           query.limit = 20
           
           query.findObjectsInBackground { (posts, error) in
               if posts != nil {
                   self.posts = posts!
                       self.tableView.reloadData()
               }
           }
       }
           
           
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        
        
    return cell
    
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

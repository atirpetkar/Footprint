//
//  FeedTableVC.swift
//  Footprint
//
//  Created by Atir Petkar on 5/1/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit
import Firebase

class FeedTableVC: UITableViewController {

    
    
    var posts = [Post]()
    
    //store the image in cache for the current session and not download from internet if it exists in the cache
    static var imageCache = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //whenever any new post is added to posts, the below code runs EVERYTIME, unlike viewDidLoad, which runs only once because we have an observer for ".value"
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock:{ snapshot in
           print(snapshot.value)
          
            
            //whenever new data comes in, first empty out the existing posts array
            self.posts = []
            
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    //each snap has values of type dictionary
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        
       
    }

   

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        
        let post = posts[indexPath.row]
      //  print(post.postDescription)
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            
            cell.request?.cancel()
            
            var img: UIImage?
            
            //since post image url is not optional
            let url = post.imageUrl
            //place it in the image cache
            img = FeedTableVC.imageCache.objectForKey(url) as? UIImage
            
            
            
            cell.configureCell(post, img: img)
            return cell
        } else {
            return PostCell()
        }

        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

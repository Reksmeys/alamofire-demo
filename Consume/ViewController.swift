//
//  ViewController.swift
//  Consume
//
//  Created by រស្មី on 28/10/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    var posts = [Posts]()
    let service = Service()
    
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refresh = UIRefreshControl()
        
        service.fetchPosts(endPoint: "https://jsonplaceholder.typicode.com/photos")
        
        postTableView.dataSource = self
        postTableView.delegate = self
        
        service.completionHandler { posts, status, message in
            if status {
                guard let _posts = posts else { return }
                self.posts = _posts
                self.postTableView.reloadData()
            }
            
        }
        
        refresh.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        
        postTableView.refreshControl = refresh
       
    }
    
    @objc func didRefresh(_ sender: Any){
        DispatchQueue.main.async {
            self.service.fetchPosts(endPoint: "https://jsonplaceholder.typicode.com/photos")
            
            self.postTableView.reloadData()
            self.postTableView.refreshControl?.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post")
        cell?.textLabel?.text = posts[indexPath.row].title
//        cell?.imageView?.loadFrom(URLAddress: posts[indexPath.row].thumbnailUrl!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(posts[indexPath.row].id!)
        let readVC = storyboard?.instantiateViewController(withIdentifier: "Read") as! ReadVC
        readVC.albumTitle = posts[indexPath.row].title
        readVC.urlImage = posts[indexPath.row].thumbnailUrl
        readVC.welcomeMessage = "\(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!) \(posts[indexPath.row].title!)"
        
        navigationController?.pushViewController(readVC, animated: true)
    }
    
    
    
    


}


extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}


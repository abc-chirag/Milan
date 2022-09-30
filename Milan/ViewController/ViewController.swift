//
//  ViewController.swift
//  Milan
//
//  Created by mac on 14/10/21.
//

import UIKit
import AVKit

class ViewController: UIViewController, PlayVideoDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var tblPost: UITableView!
    
    //MARK:- Properties
    var viewModel = PostViewModel()
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- Functions
    private func setupUI(){
        setupTableView()
        callApi()
    }
    
    private func setupTableView() {
        tblPost.delegate = self
        tblPost.dataSource = self
        tblPost.register(PostCell.nib, forCellReuseIdentifier: PostCell.identifier)
        tblPost.reloadData()
    }
    
    private func callApi() {
        viewModel.getAllData { (success, error) in
            if success {
                print("success")
                DispatchQueue.main.async {
                    self.tblPost.reloadData()
                }
                
            } else {
                print(error)
            }
        }
    }
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

//MARK:- UITableViewDelegate,UITableViewDataSource
extension ViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell else{return UITableViewCell()}
        
        cell.config(index: viewModel.arrResult[indexPath.row])
        cell.delegate = self
        cell.setupPager()

        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 95
//    }
    
}


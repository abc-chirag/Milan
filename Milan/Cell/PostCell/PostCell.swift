//
//  PostCell.swift
//  Milan
//
//  Created by mac on 14/10/21.
//

import UIKit
import SDWebImage
import FSPagerView


protocol PlayVideoDelegate {
    func playVideo(url: URL)
}


class PostCell: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    //    @IBOutlet weak var clvPostList: UICollectionView!
    @IBOutlet weak var lblLikesCount: UILabel!
    @IBOutlet weak var lblCommants: UILabel!
    
    @IBOutlet weak var viewPagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- Properties
    var post:Posts!
    var arrTotalPost = [String]()
    var delegate: PlayVideoDelegate!
    
    //MARK:- LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK:- Functions
    func config(index: Posts){
        
        if let name = index.user?.name ,
           let profile = index.user?.profile,
           let images = index.images,
           let videos = index.videos,
           let likes = index.likes,
           let commants = index.comments {
            lblUserName.text = name
            imgUserProfile.sd_setImage(with: URL(string: profile), placeholderImage: UIImage(named: "ic_noData") )
            
            post = index
            arrTotalPost.append(contentsOf: images)
            arrTotalPost.append(contentsOf: videos)
            lblLikesCount.text = "\(likes) Likes"
            lblCommants.text = commants.joined(separator:"- \n")
        }
        
    }
    
    private func setupUI() {
        imgUserProfile.layer.cornerRadius = (imgUserProfile.frame.height) / 2
        //        setupCollctionView()
        setupPager()
    }
    
    //    private func setupCollctionView() {
    //        clvPostList.delegate = self
    //        clvPostList.dataSource = self
    //        clvPostList.register(PostListCell.nib, forCellWithReuseIdentifier: PostListCell.identifier)
    //        clvPostList.reloadData()
    //    }
    
    
    func setupPager() {
        
        self.pageControl.numberOfPages = self.arrTotalPost.count
        viewPagerView.register(PostListCell.nib, forCellWithReuseIdentifier: PostListCell.identifier)
        viewPagerView.itemSize = FSPagerView.automaticSize
        let transform = CGAffineTransform(scaleX: 0, y: 0)
        self.viewPagerView.itemSize = self.viewPagerView.frame.size.applying(transform)
        self.viewPagerView.decelerationDistance = FSPagerView.automaticDistance
        viewPagerView.isInfinite = false
        viewPagerView.dataSource = self
        viewPagerView.delegate = self
    }
}

////MARK:- UICollectionViewDataSource,UICollectionViewDelegate
//extension PostCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        self.arrTotalPost.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostListCell.identifier, for: indexPath) as? PostListCell else{
//            return UICollectionViewCell()
//        }
//
//        cell.config(index: self.arrTotalPost[indexPath.row])
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = UIScreen.main.bounds.width
//        let height = self.clvPostList.frame.height
//        return CGSize(width: width, height: height)
//    }
//}

//MARK: - FSPagerViewDataSource, FSPagerViewDelegate
extension PostCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arrTotalPost.count
    }
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: PostListCell.identifier, at: index) as! PostListCell
        cell.config(index: self.arrTotalPost[index])
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        
        
        if !self.arrTotalPost[index].isEmpty{
            let url = URL(string: self.arrTotalPost[index])
            if url!.containsVideo {
                delegate.playVideo(url: url!)
            }
            
        }
        
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}

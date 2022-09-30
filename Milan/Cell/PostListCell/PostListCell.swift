//
//  PostListCell.swift
//  Milan
//
//  Created by mac on 14/10/21.
//

import UIKit
import SDWebImage
import AVKit
import FSPagerView

class PostListCell: FSPagerViewCell {
    
    @IBOutlet weak var imgpost: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func config(index: String) {
        
        if !index.isEmpty {
            let url = URL(string: index)
            
            if url!.containsImage == true {
                imgpost.sd_setImage(with: URL(string: index), placeholderImage: UIImage(named: "ic_noData") )
                btnPlay.isHidden = true
            } else {
                getThumbnailImageFromVideoUrl(url: url!) { (image) in
                    self.imgpost.image = image
                }
                btnPlay.isHidden = false
            }
        }
    }

    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbNailImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
}

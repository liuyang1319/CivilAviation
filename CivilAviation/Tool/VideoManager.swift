//
//  VideoManager.swift
//  SchoolChat_Parent_iOS
//
//  Created by Meteorshower on 2019/12/12.
//  Copyright © 2019 liuyang. All rights reserved.
//

import UIKit
import AVKit

class VideoManager: NSObject {
    
    private static let manager = VideoManager()
    @objc var url: String?
    private var videoPlayerItem: AVPlayerItem?
    private var videoPlayerVC: AVPlayerViewController = AVPlayerViewController.init()
    
    deinit {
        removeObserver()
    }
    
    static func share() -> VideoManager {
        return manager
    }
    
    override init() {
        super.init()
        initPlayer()
    }
    
    private func initPlayer() {
        videoPlayerVC.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        videoPlayerVC.videoGravity = .resizeAspectFill
    }
   
    private func loadVideo(url: URL) {
        videoPlayerItem = AVPlayerItem(url: url as URL)
        videoPlayerVC.player = AVPlayer.init(playerItem: videoPlayerItem)
        
        addObserver()
        UIApplication.shared.keyWindow?.rootViewController?.present(videoPlayerVC, animated: true, completion: nil)
    }
    
    func starPlayer(urlStr: String?) {
        if (urlStr?.count ?? 0) == 0 {
            return
        }
        
        url = urlStr?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlStr
        
        let urlobject = URL.init(string: url!)
        if urlobject == nil {
            return
        }
        
        loadVideo(url: urlobject!)
    }
    
    func pausePlay() {
        videoPlayerVC.player?.pause()
    }
    
    func stopPlay() {
        videoPlayerVC.player?.pause()
        videoPlayerVC.player?.seek(to: CMTime.init(value: 0, timescale: 1))
    }
    
    func addObserver() {
        // 监听status属性进行播放
        videoPlayerItem?.addObserver(self,
                                     forKeyPath: "status",
                                     options: .new,
                                     context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let object = object as? AVPlayerItem  else { return }
        guard let keyPath = keyPath else { return }
        if keyPath == "status" {
            if object.status == .readyToPlay { //当资源准备好播放，那么开始播放视频
                videoPlayerVC.player?.play()
            } else if object.status == .failed || object.status == .unknown {
                videoPlayerVC.player?.pause()
            }
        }
    }
    
    func removeObserver() {
        videoPlayerItem?.removeObserver(self, forKeyPath: "status")
    }
    
    func getVideoThumbnail(url: String?, fileType: String?, originObj: AnyObject?, compareObj: AnyObject?, callback: @escaping(_ image: UIImage?, _ compareObj: AnyObject?) -> ()) {
        guard (url?.count ?? 0) > 0 && (fileType?.count ?? 0) > 0  &&  fileType == "mp4" else {
            callback(nil, nil)
            return
        }
        
        //异步获取网络视频
        DispatchQueue.global().async {
            let url = url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url!
            //获取网络视频
            let videoURL = NSURL(string: url)!
            let avAsset = AVURLAsset(url: videoURL as URL)
            
            //生成视频截图
            let generator = AVAssetImageGenerator(asset: avAsset)
            generator.appliesPreferredTrackTransform = true
            let time = CMTimeMakeWithSeconds(0.0,preferredTimescale: 600)
            var actualTime: CMTime = CMTimeMake(value: 0,timescale: 0)
            let imageRef: CGImage?
            do {
                imageRef = try generator.copyCGImage(at: time, actualTime: &actualTime)
            } catch {
                callback(nil, nil)
                return
            }
            let frameImage = UIImage(cgImage: imageRef!)
            
            callback(frameImage, compareObj ?? nil)
        }
    }
}

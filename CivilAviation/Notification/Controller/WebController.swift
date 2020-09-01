//
//  WebController.swift
//  LipstickMachine
//
//  Created by easyto on 2019/3/4.
//  Copyright © 2019年 easyto. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class WebController: BaseController, WKUIDelegate, WKNavigationDelegate {

    @objc var url: String?
    @objc var naviTitle: String?
    private var webView: WKWebView?
    private var videoPlayerItem: AVPlayerItem?
    private var videoPlayerVC: AVPlayerViewController = AVPlayerViewController.init()
    private let appStoreLinkErrorCode = 102
    private let videoLinkErrorCode = 204
    
    deinit {
        removeObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if webView == nil {
            return
        }
        webView?.load(URLRequest.init(url: URL.init(string: "about:blank")!))
        CBToast.hiddenToastAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = naviTitle ?? ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(hex: 0x333333)]
        let frame = tableView.frame
        tableView.removeFromSuperview()
//        edgesForExtendedLayout = .bottom
        setWebview(frame: frame)
        setVideoPlayer(frame: frame)
        loadData()
    }
    
    func setWebview(frame: CGRect) {
        let config = WKWebViewConfiguration.init()
        config.allowsInlineMediaPlayback = true
        webView = WKWebView.init(frame: frame, configuration: config)
        webView!.uiDelegate = self
        webView!.navigationDelegate = self
        view.addSubview(webView!)
        
        webView!.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.right()?.offset()(0)
            make?.top.offset()(StatusBarAndNavHeight)
            make?.bottom.offset()(-TabbarSafeBottomMargin)
        }
    }
    
    func setVideoPlayer(frame: CGRect) {
        let height = kScreenHeight - TabbarSafeBottomMargin - StatusBarAndNavHeight
        videoPlayerVC.view.frame = frame
        videoPlayerVC.view.frame.size = CGSize(width: frame.width, height: height)
        self.addChild(videoPlayerVC)
        view.addSubview(videoPlayerVC.view)
    }

    func loadData() {
        if (url?.count ?? 0) == 0 {
            return
        }
        
        url = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        let urlobject = URL.init(string: url!)
        if urlobject == nil {
            return
        }
        
        if (url?.contains(".mp4"))! {
            loadVideo(url: urlobject!)
        } else {
            loadWebView(url: urlobject!)
        }
        print("url: %s", url ?? "")
    }
    
    func loadWebView(url: URL) {
        let request = URLRequest.init(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30
        )
        webView!.load(request)
        view.bringSubviewToFront(webView!)
    }
    
    func loadVideo(url: URL) {
        videoPlayerItem = AVPlayerItem(url: url as URL)
        videoPlayerVC.player = AVPlayer.init(playerItem: videoPlayerItem)
        view.bringSubviewToFront(videoPlayerVC.view)
        addObserver()
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
    
    // MARK: webview delegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let url = webView.url?.absoluteString ?? ""
        if url.count == 0 {
            return
        }
        
        if url == "about:blank" {
            return
        }
        
        CBToast.showToastAction()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        CBToast.hiddenToastAction()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 当网页内部链接跳转时
        if (error as NSError).domain == "NSURLErrorDomain" &&
            (error as NSError).code == NSURLErrorCancelled {
            return
        }
        
        // 当网页包含appstore链接或当链接是视频路径时（不影响视频正常播放）
        if (error as NSError).domain == "WebKitErrorDomain" &&
            ((error as NSError).code == appStoreLinkErrorCode || (error as NSError).code == videoLinkErrorCode) {
            return
        }
        
        CBToast.hiddenToastAction()
        toast(toast: "加载失败")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.leftBtnClicked()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let description = navigationAction.request.url?.description
        if description == nil {
            decisionHandler(.allow);
            return
        }

        if !description!.hasPrefix("sdk:") {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
    }
    
}

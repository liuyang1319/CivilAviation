//
//  LYPersonalModifyController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalModifyController: BaseController {

    private let kLYPersonalInfoCell = "LYPersonalInfoCell"
    private let kLYPersonalCertificateUploadCell = "LYPersonalCertificateUploadCell"
    
    private let submit = LYPersonalSubmitView.instanceView(type: "LYPersonalSubmitView") as! LYPersonalSubmitView
    private var fontUrl = ""
    private var reverseUrl = ""
    private var holdUrl = ""
    
    var model: LYPersonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "个人信息", English: "Personal information")
        addSubmitView()
        cellArray = [
            kLYPersonalInfoCell,
            kLYPersonalCertificateUploadCell
        ]
    }
    
    override func initTableView() {
        super.initTableView()
        
        tableView.mj_h -= (60 + TabbarSafeBottomMargin)
    }
    
    private func addSubmitView() {
        submit.delegate = self
        view.addSubview(submit)
        submit.mas_makeConstraints { (make) in
            make?.left?.right()?.offset()(0)
            make?.height.offset()(60)
            make?.bottom.offset()(-TabbarSafeBottomMargin)
        }
    }
    
}

extension LYPersonalModifyController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalInfoCell) as! LYPersonalInfoCell
            cell.setValue(model: model)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalCertificateUploadCell) as! LYPersonalCertificateUploadCell
            cell.delegate = self
            return cell
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 500
        default:
            return 50
        }
    }
}

extension LYPersonalModifyController: LYPersonalSubmitViewDelegate, LYPersonalCertificateUploadCellDelegate {
    /// LYPersonalSubmitViewDelegate
    func submitBtnClicked() {
        submitImage()
    }
    
    /// LYPersonalCertificateUploadCellDelegate
    func uploadedImage(url: String, type: CertificateUrlType) {
        switch type {
        case .font:
            fontUrl = url
        case .reverse:
            reverseUrl = url
        case .hold:
            holdUrl = url
        }
    }
}

extension LYPersonalModifyController {
    
    private func isUploaded() -> Bool {
        if fontUrl.count == 0 {
            toast(toast: "请上传证件正面照")
            return false
        }
        
        if reverseUrl.count == 0 {
            toast(toast: "请上传证件反面照")
            return false
        }
        
        if holdUrl.count == 0 {
            toast(toast: "请上传手持证件照")
            return false
        }
        
        return true
    }
    
    private func submitImage() {
        if !isUploaded() {
            return
        }
        
        LYPersonViewModel.userInfoUpload(fontUrl: fontUrl, reverseUrl: reverseUrl, holdUrl: holdUrl) { (error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.toast(toast: "上传成功")
            self.popController()
        }
    }
}

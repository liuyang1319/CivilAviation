//
//  LYPersonalCertificateUploadCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

enum CertificateUrlType: Int {
    case font = 0
    case reverse
    case hold
}

protocol LYPersonalCertificateUploadCellDelegate {
    func uploadedImage(url: String, type: CertificateUrlType)
}

class LYPersonalCertificateUploadCell: BaseCell {

    private let kBtnTag = 1231108
    private let imagePicker = UIImagePickerController()
    private var selectBtn: UIButton?
    
    @IBOutlet weak var front: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var hold: UIButton!
    
    var delegate: LYPersonalCertificateUploadCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePicker.delegate = self
        
        front.layer.borderWidth = 1
        front.layer.borderColor = NavigationBackgroundColor.cgColor
        
        back.layer.borderWidth = 1
        back.layer.borderColor = NavigationBackgroundColor.cgColor
        
        hold.layer.borderWidth = 1
        hold.layer.borderColor = NavigationBackgroundColor.cgColor
    }
    
    func setValue(model: LYPersonModel) {
        front.kf.setImage(with: URL(string: model.frontUrl), for: .normal)
        back.kf.setImage(with: URL(string: model.reverseUrl), for: .normal)
        hold.kf.setImage(with: URL(string: model.holdUrl), for: .normal)
    }

    @IBAction private func btnClicked(_ sender: UIButton) {
        selectBtn = sender
        permission()
    }
    
}

extension LYPersonalCertificateUploadCell {
    
    private func permission() {
        LYPermissionTool.cameraPermission { (result) in
            if !result {
                self.alert()
                return
            }
            
            self.openAlbum()
        }
    }
    
    private func alert() {
        let alert = UIAlertController.init(
            title: "温馨提示",
            message: "请您设置允许该应用访问您的相机\n设置>隐私>相机",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction.init(
            title: "取消",
            style: .cancel,
            handler: nil
        )
        let confirm = UIAlertAction.init(
            title: "确定",
            style: .default) { (action) in
                let url = NSURL.init(string: UIApplication.openSettingsURLString)! as URL
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(
                        url,
                        options: [:],
                        completionHandler: nil
                    )
                } else {
                    UIApplication.shared.openURL(url)
                }
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(controller: alert)
    }
    
    private func openAlbum() {
        let sheet = UIAlertController.init(
            title: "请选择相册或者相机",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let cancel = UIAlertAction.init(
            title: "取消",
            style: .cancel,
            handler: nil
        )
        let library = UIAlertAction.init(
            title: "相册",
            style: .default) { (action) in
                self.imagePicker.sourceType = .photoLibrary
                self.present(controller: self.imagePicker)
        }
        let camera = UIAlertAction.init(
            title: "拍照",
            style: .default) { (action) in
                if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                    CBToast.showToastAction(message: "不能使用相机")
                    return
                }
                
                self.imagePicker.sourceType = .camera
                self.present(controller: self.imagePicker)
        }
        
        sheet.addAction(library)
        sheet.addAction(camera)
        sheet.addAction(cancel)
        
        present(controller: sheet)
    }
    
    private func present(controller: UIViewController) {
        Tool.getCurrentVC()?.present(controller, animated: true, completion: nil)
    }
}

extension LYPersonalCertificateUploadCell:
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if selectBtn == nil {
            return
        }
        
        let image = info[UIImagePickerController.InfoKey.originalImage]
        if image == nil {
            return
        }

        let tag = self.selectBtn!.tag - self.kBtnTag
        DispatchQueue.global().async {
            self.upload(image: image as! UIImage, type: CertificateUrlType.init(rawValue: tag)!)
        }
    }
}

extension LYPersonalCertificateUploadCell {
    func upload(image: UIImage, type: CertificateUrlType) {
        LYPersonViewModel.upload(image: image) { (url, error) in
            if error != nil {
                CBToast.showToastAction(message: (error! as NSError).domain as NSString)
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.uploadedImage(url: url ?? "", type: type)
                self.selectBtn!.setBackgroundImage(image, for: .normal)
            }
        }
    }
}

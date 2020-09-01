//
//  LYExperienceTrainCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYExperienceTrainCell: BaseCell {

    @IBOutlet weak var certificateNo: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var certificate: UILabel!
    
    private var model: LYTrainModel?
    private let galleryView: GalleryView = GalleryView.init(frame: kScreenBounds)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        certificate.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(lookupCertificate)))
    }

    func setValue(model: LYTrainModel) {
        certificateNo.text = model.certNo
        content.text = model.trainContents
        company.text = model.trainingCompany
        duration.text = model.beginDate + "至" + model.endDate
        setCertificateText(fileUrl: model.fileUrl)
    }
    
    private func setCertificateText(fileUrl: String) {
        if fileUrl.count == 0 {
            certificate.text = "无"
            return
        }
        
        let rang = fileUrl.range(of: "/")
        if rang == nil {
            certificate.text = "无"
            return
        }
        
        let location = fileUrl.distance(from: fileUrl.startIndex, to: rang!.upperBound)
        let subStr = fileUrl.suffix(fileUrl.count - location)
        certificate.text = String(subStr)
    }
    
    @objc private func lookupCertificate() {
        if (model?.fileUrl ?? "").count == 0 {
            return
        }
        
        UIImageView.init().kf.setImage(
            with: URL.init(string: model!.fileUrl),
            placeholder: nil,
            options: [.transition(.fade(0.2))],
            progressBlock: nil) { (image, error, type, url) in
              if error == nil {
                    self.galleryView.images = [image!]
                }
        }
        
        let window = UIApplication.shared.delegate!.window!
        window?.addSubview(galleryView)
    }
}

//
//  LYLicenseModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/9.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYLicenseModel: BaseModel {

    var licenseNo = "" //执照编号
    var nationality = "" //国籍
    var dishonesty = "" //失信行为记录
    var name = "" //姓名
    var headUrl = "" //头像
    var licenseTypes: [LYLicenseTypeModel] = []
    var licenseQrCode = "" //二维码
}

class LYLicenseTypeModel: BaseModel {
    var licenseTypeName = "" //执照专业
    var validDate = "" //获得时间
    var englishLevel = "" //英语等级
}

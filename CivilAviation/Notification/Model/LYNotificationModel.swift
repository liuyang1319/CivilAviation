//
//  LYNotificationModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/11.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYNotificationModel: BaseModel {

    var ID = "" //主键
    var MSG_TYPE = "" //消息类型
    var STATUS = "" //是否已读，Y:已读，N:未读
    var TITLE = "" //消息标题
    var CONTENT = "" //内容
    var MSG_FILE = "" //附件
    var SEND_DATE = "" //日期
}

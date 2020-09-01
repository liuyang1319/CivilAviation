//
//  LYExaminationPlanModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/10.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYExaminationPlanModel: BaseModel {
    
    var id = "" //主键
    var beginDate = "" //报名开始时间
    var endDate = "" //报名结束时间
    var quota = 0 //名额
    var planName = "" //考试计划名称
    var status = "" //状态
    var items = "" //报名模块
    var canApply = 0 //0 可报名 1 不可报名
    
}

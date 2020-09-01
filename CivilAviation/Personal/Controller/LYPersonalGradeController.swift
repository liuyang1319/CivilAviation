//
//  LYPersonalGradeController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalGradeController: BaseController {

    private let kLYPersonalGradeCell = "LYPersonalGradeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "我的成绩", English: "My Grade")
        cellArray = [
            kLYPersonalGradeCell
        ]
        
        getData()
    }
    
    override func getData() {
        LYPersonViewModel.getExams { (datas, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.dataArray = datas
            self.tableView.reloadData()
        }
    }

}

extension LYPersonalGradeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalGradeCell) as! LYPersonalGradeCell
        if dataArray.count > indexPath.row {
            cell.setValue(model: dataArray[indexPath.row] as! LYExamModel)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

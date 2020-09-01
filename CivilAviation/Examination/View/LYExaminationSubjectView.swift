//
//  LYExaminationSubjectView.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/19.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

protocol LYExaminationSubjectViewDelegate {
    func subject(id: String, major: String, items: [String])
}

class LYExaminationSubjectView: BaseView {

    @IBOutlet weak var title: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let kLYExaminationSubjectCell = "LYExaminationSubjectCell"
    private let pickView = PickView.instanceView()
    private var data: [String : Any] = [:]
    private var keys: [String] = []
    private var selectIndex = 0
    
    var delegate: LYExaminationSubjectViewDelegate?
    var id = ""

    static func instance() -> LYExaminationSubjectView {
        let myView = Bundle.main.loadNibNamed("LYExaminationSubjectView", owner: nil, options: nil)?.first as! LYExaminationSubjectView
        myView.setTableView()
        
        myView.pickView.delegate = myView
        return myView
    }

    @IBAction func titleBtnClicked(_ sender: Any) {
        pickView.appear()
    }
    
    @IBAction func dismissBtnClicked() {
        disappear()
    }
    
    @IBAction func submitBtnClicked() {
        let selectIds = getSelectIds()
        if selectIds.isEmpty {
            CBToast.showToastAction(message: "请选择")
            return
        }
        
        delegate?.subject(id: id, major: getMajor(), items: selectIds)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = BackColor.cgColor
        
        tableView.register(
            UINib.init(nibName: kLYExaminationSubjectCell, bundle: nil),
            forCellReuseIdentifier: kLYExaminationSubjectCell
        )
    }
    
    override func appear() {
        tableView.reloadData()
        super.appear()
    }
    
}

extension LYExaminationSubjectView {
    func setData(datas: [String : Any]) {
        self.data = datas
        keys = Array(datas.keys)
        title.setTitle(keys.first, for: .normal)
        tableView.reloadData()
        pickView.setData(data: keys)
    }
    
    private func getKey(section: Int) -> String {
        if keys.count <= section {
            return ""
        }
        
        return keys[section]
    }
    
    private func getDatas(key: String) -> [[String : String]] {
        let tmp = data[key]
        if !(tmp is [String : Any]) {
            return []
        }
        
        let items = (tmp as! [String : Any])["items"]
        if !(items is [[String : String]]) {
            return []
        }
        
        return items as! [[String : String]]
    }
    
    private func getDatas() -> [[String : String]] {
        return getDatas(key: getKey(section: selectIndex))
    }
    
    private func getMajor() -> String {
        if keys.count <= selectIndex {
            return ""
        }
        
        let tmp = data[keys[selectIndex]]
        if !(tmp is [String : Any]) {
            return ""
        }
        
        let items = (tmp as! [String : Any])["value"]
        if !(items is String) {
            return ""
        }
        
        return items as! String
    }
    
    private func getSelectIds() -> [String] {
        let selected = tableView.indexPathsForSelectedRows
        if selected?.isEmpty ?? true {
            return []
        }
        
        var items: [String] = []
        
        for indexPath in selected! {
            let data = getDatas()
            if data.count <= indexPath.row {
                break
            }
            
            let item = getDatas()[indexPath.row]
            items.append(item["id"]!)
        }
        
        return items
    }
    
}

extension LYExaminationSubjectView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDatas().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYExaminationSubjectCell) as! LYExaminationSubjectCell
        let data = getDatas()
        if data.count > indexPath.row {
            cell.setValue(dic: data[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension LYExaminationSubjectView: PickViewDelegate {
    /// PickViewDelegate
    func pickDidSelected(selectedIndex: Int, selectedTitle: String) {
        self.selectIndex = selectedIndex
        title.setTitle(keys[selectedIndex], for: .normal)
        tableView.reloadData()
    }
    
    
}

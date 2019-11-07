//
//  RecordListViewController.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/11/6.
//  Copyright © 2019 刘恒. All rights reserved.
//

import UIKit

let RecordBGColor = UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0)
class RecordListViewController: UITableViewController {

    lazy var listVM = TotalDataViewModel()
    
    private var vcStatus : Int = 1  //1全部 2精简
    private var arrRandomColor : [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TimeFomatChange.getAppointDayString(0, "MM月dd日")
        view.backgroundColor = RecordBGColor
        let leftBtn = {()->UIButton in
            let b = UIButton(type: .custom)
            b.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
            b.setImage(UIImage(named: "返回"), for: .normal)
            return b
        }()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        let rightBtn = {()->UIButton in
            let b = UIButton(type: .custom)
            b.addTarget(self, action: #selector(self.statusChange), for: .touchUpInside)
            b.setImage(UIImage(named: "精简"), for: .normal)
            return b
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        listVM.fetchTotalData {[weak self] in
            guard let `self` = self else{return}
            for _ in 0..<self.listVM.arrDate.count {
                self.arrRandomColor.append(UIColor(red: CGFloat.random(in: 0...255) / 255, green: CGFloat.random(in: 0...255) / 255, blue: CGFloat.random(in: 0...255) / 255, alpha: 1.0))
            }
            
            self.tableView.reloadData()
        }
        
        tableView.register(UINib(nibName:RecordListHeaderViewId,bundle:nil), forHeaderFooterViewReuseIdentifier: RecordListHeaderViewId)
        tableView.register(UINib(nibName:RecordListCellId,bundle:nil) , forCellReuseIdentifier:RecordListCellId)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = .none
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func statusChange() {
        var btn : UIButton
        if vcStatus == 1 {
            btn = {()->UIButton in
                let b = UIButton(type: .custom)
                b.addTarget(self, action: #selector(self.statusChange), for: .touchUpInside)
                b.setImage(UIImage(named: "精简"), for: .normal)
                return b
            }()
            vcStatus = 2
        }else{
            btn = {()->UIButton in
                let b = UIButton(type: .custom)
                b.addTarget(self, action: #selector(self.statusChange), for: .touchUpInside)
                b.setImage(UIImage(named: "全部"), for: .normal)
                return b
            }()
            vcStatus = 1
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        tableView.reloadData()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listVM.arrDate.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vcStatus == 1 {
            return listVM.arrSequence[section].count
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecordListHeaderViewId) as? RecordListHeaderView
        headView?.data = listVM.arrDate[section]
        headView?.randomColor = arrRandomColor[section]
        return headView!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecordListCell? = tableView.dequeueReusableCell(withIdentifier: RecordListCellId) as? RecordListCell
        cell?.randomColor = arrRandomColor[indexPath.section]
        cell?.data = listVM.arrSequence[indexPath.section][indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

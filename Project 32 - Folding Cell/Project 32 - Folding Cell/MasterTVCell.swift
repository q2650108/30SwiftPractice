//
//  MasterTVCell.swift
//  Project 32 - Folding Cell
//
//  Created by SHUN on 2/22/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MasterTVCell: UITableViewCell {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet var detailTableView : UITableView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    public func createDetailTable(){
        
        detailTableView.dataSource = self
        
    }
    
    
    public func animate(){
        
        
        let index = IndexPath(row: 2 , section: 0)
        
        let cell = detailTableView.cellForRow(at: index) as! DetailTVCell

        let viewBackground = cell.viewBackground!
        
//        viewBackground.layer.isDoubleSided = false
        
        viewBackground.layer.anchorPoint = CGPoint(x:0.5, y:0)
        viewBackground.frame.origin.y = viewBackground.frame.origin.y - viewBackground.frame.height / 2
        
        
        var fromTrans = CATransform3DIdentity;
        //设定视觉焦点，分母越大表示视图离我们的距离越远，数值大有什么好处呢，你会发现翻转效果就不会产生你讨厌的侧边幅度过大的问题。
        fromTrans.m34 = -1.0 / 600.0
        fromTrans = CATransform3DRotate(fromTrans, CGFloat(0.degreesToRadians), 1, 0, 0)//沿 X 轴旋转180度
        
        var toTrans = CATransform3DIdentity;
        toTrans.m34 = -1.0 / 700.0
        toTrans = CATransform3DRotate(toTrans, CGFloat(179.degreesToRadians) , 1, 0, 0)
        
        
        
        let basicAnimate = CABasicAnimation(keyPath: "transform")
        basicAnimate.fromValue = NSValue(caTransform3D: fromTrans)
        basicAnimate.toValue = NSValue(caTransform3D: toTrans)
        
        basicAnimate.duration = 5
        basicAnimate.fillMode = kCAFillModeForwards
        basicAnimate.isRemovedOnCompletion = false
        viewBackground.layer.add(basicAnimate, forKey: nil)
        
    }
    
}



extension MasterTVCell : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTVCell
        
        
        if indexPath.row == 0 {
            cell.viewBackground.backgroundColor = UIColor.red
        }else if indexPath.row == 1{
            cell.viewBackground.backgroundColor = UIColor.blue
        }else{
            cell.viewBackground.backgroundColor = UIColor.orange
        }
        
        cell.labelContent.text = "Row - \(indexPath.row)"
        
        
        return cell
    }
    
    
}




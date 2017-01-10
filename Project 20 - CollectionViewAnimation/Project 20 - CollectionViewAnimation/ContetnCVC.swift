//
//  ContetnCVC.swift
//  Project 20 - CollectionViewAnimation
//
//  Created by SHUN on 1/10/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit



class ContetnCVC: UICollectionViewController  {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private let _margin : CGFloat = 10.0
    
    private let _spacing : CGFloat = 5.0
    
    private let _perCellNumm : CGFloat = 3.0
    
    private let reuseIdentifier = "cell"
    
    private let imageList = [ "image_1" , "image_2" , "image_3" , "image_4" , "image_5" , "image_6" ]
    
    private var _currentScrollDirection : UICollectionViewScrollDirection = .horizontal
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    var margin : CGFloat {
        get {
            return _margin
        }
    }
    
    var spacing : CGFloat {
        get {
            return _spacing
        }
    }
    
    var perCellNumm : CGFloat {
        get {
            return _perCellNumm
        }
    }
    
    var currentScrollDirection : UICollectionViewScrollDirection {
        get {
            return _currentScrollDirection
        }
        set {
            _currentScrollDirection = newValue
        }
    }
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var buttonChangeScrollDirection: UIBarButtonItem!
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func handleScrollDirection(_ sender: UIBarButtonItem) {
        
        if self.currentScrollDirection == .horizontal {
            self.currentScrollDirection = .vertical
            buttonChangeScrollDirection.title = "Horizontal"
        }else {
            self.currentScrollDirection = .horizontal
            buttonChangeScrollDirection.title = "Vertical"
        }
        
        let flowLayout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = self.currentScrollDirection
        
        self.collectionView?.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValue()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        self.collectionView?.delegate = self
        
        //                       let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        //                flow.scrollDirection
        
        
    }
    
    
    
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    /// <#Description#>
    ///
    /// - Parameter collectionView: <#collectionView description#>
    /// - Returns: <#return value description#>
    func getMinSize( _ collectionView : UICollectionView ) -> CGSize {
        var size : CGSize = CGSize()
        if currentScrollDirection == .horizontal {
            var minSide = ( collectionView.frame.height
                - ( self.navigationController?.navigationBar.frame.height ?? 0 )
                - UIApplication.shared.statusBarFrame.height
                - margin * 2
                - spacing * (perCellNumm - 1) )
//            minSide =  minSide - (  spacing * 4 )
            minSide =   minSide  / perCellNumm
            size = CGSize(width: minSide , height: minSide  )
        }else {
            let minSide = ( collectionView.frame.width - margin * 2 - spacing * (perCellNumm - 1) ) / perCellNumm
            size = CGSize(width: minSide , height: minSide )
        }
        return size
        
    }
    
    
    //==============================//
    // MARK:      UICollectionViewDataSource
    //=============================//
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageList.count * 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ContentCVCell
        
        cell.imageViewContent.image = UIImage(named: imageList[indexPath.row % 5])
        
        cell.labelTitle.text = "Image_\(indexPath.row)"
        
        return cell
    }
    
    //==============================//
    // MARK:      UICollectionViewDelegate
    //=============================//
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print( collectionView.cellForItem(at: indexPath)?.frame.height)
    }
    
}

//==============================//
// MARK:      UICollectionViewDelegateFlowLayout
//=============================//

extension ContetnCVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        print("collectionView: \(collectionView)")
        //        print("collectionViewLayout: \(collectionViewLayout)")
        //        print("=======")
        return getMinSize(collectionView)
    }
    
    /// Margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //print("insetForSectionAt")
        
        return UIEdgeInsets(top: margin , left: margin, bottom: margin, right: margin)
    }
    
    /// For Line
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumLineSpacingForSectionAt")
        return spacing
    }
    
    /// For Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        print("minimumInteritemSpacingForSectionAt")
        
        return spacing
    }
}

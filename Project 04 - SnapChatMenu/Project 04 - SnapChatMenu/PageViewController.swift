//
//  PageViewController.swift
//  Project 04 - SnapChatMenu
//
//  Created by SHUN on 10/18/16.
//  Copyright © 2016 kinpomis. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var vcContainer : [UIViewController]?
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        dataSource = self
        
        vcContainer = [ newVC("AVCaptureViewController") , newVC("ViewController") , newVC("MenuViewController")  ]
   
        if let firstVC = vcContainer?.first {
            setViewControllers([firstVC],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func newVC(vcName: String?) -> UIViewController {
        // if nil
        guard let vc = vcName else{
            return UIViewController()
        }
        
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(vc)
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
}

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let vcs =  vcContainer else {
            return nil
        }
        
        guard let viewControllerIndex = vcs.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard vcs.count > previousIndex else {
            return nil
        }
        
        return vcs[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let vcs =  vcContainer else {
            return nil
        }
        
        guard let viewControllerIndex = vcs.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let vcsCount = vcs.count
        
        guard vcsCount != nextIndex else {
            return nil
        }
        
        guard vcsCount > nextIndex else {
            return nil
        }
        
        print(nextIndex)
        
        return vcs[nextIndex]
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let vcs =  vcContainer else {
            return 0
        }
        return vcs.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {

        guard let vcs =  vcContainer else {
            return 0
        }
        
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = vcs.indexOf(firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }
    
}

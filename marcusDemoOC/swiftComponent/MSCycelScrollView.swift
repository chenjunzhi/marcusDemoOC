//
//  MSCycelScrollView.swift
//  marcusDemoOC
//
//  Created by marcus on 15/9/8.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable class MSCycelScrollView: UIView, UIScrollViewDelegate {
    
    // MARK: Publick Properties
    /// Use auto layout or not, set true if use auto layout for MMCycelScrollView
    @IBInspectable var isUseLayoutConstraints : Bool = false {
        didSet {
            if isUseLayoutConstraints != oldValue {
                if isUseLayoutConstraints {
                    anchorView.setTranslatesAutoresizingMaskIntoConstraints(false)
                    scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
                    contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
                    controlView.setTranslatesAutoresizingMaskIntoConstraints(false)
                    self.addConstraints(selfConstraints)
                } else {
                    anchorView.setTranslatesAutoresizingMaskIntoConstraints(true)
                    scrollView.setTranslatesAutoresizingMaskIntoConstraints(true)
                    contentView.setTranslatesAutoresizingMaskIntoConstraints(true)
                    controlView.setTranslatesAutoresizingMaskIntoConstraints(true)
                    self.removeConstraints(selfConstraints)
                }
            }
        }
    }
    /// Auto scroll images when MMCycelScrollView be added to superview, default false
    @IBInspectable var autoScroll : Bool = false {
        didSet {
            if autoScroll {
                if !autoRunTimer.valid {
                    autoRunTimer = NSTimer.scheduledTimerWithTimeInterval(autoScrollInterval, target: self, selector: "handleTimer", userInfo: nil, repeats: true)
                }
            } else {
                autoRunTimer.invalidate()
            }
        }
    }
    /// Auto scroll timeInterval,  TimeInterval between scroll a page and next, default 2.
    @IBInspectable var autoScrollInterval : NSTimeInterval = 2
    /// PageContoler normal color
    @IBInspectable var pageControlColor : UIColor = UIColor(colorCode: 0xCCCCCC) {
        didSet {
            controlView.pageIndicatorTintColor = pageControlColor
        }
    }
    /// PageContoler selected color, default white.
    @IBInspectable var pageControlTintColor : UIColor = UIColor.whiteColor() {
        didSet {
            controlView.currentPageIndicatorTintColor = pageControlTintColor
        }
    }
    /// how many page of MMCycelScrollView
    var pageNumbers : NSInteger = 0 {
        didSet {
            controlView.numberOfPages = pageNumbers
            controlView.hidden = pageNumbers <= 1
        }
    }
    /// current page for view
    var currentPage : NSInteger = 0 {
        didSet {
            if currentPage >= pageNumbers {
                currentPage = 0
            } else if currentPage < 0 {
                currentPage = max(pageNumbers-1, 0)
            }
            reloadViews()
        }
    }
    /// data source block for page view of each page
    var viewOfPageBlock : ((index : NSInteger) -> UIView)? {
        didSet {
            if viewOfPageBlock != nil {
                reloadData()
            }
        }
    }
    /// call back block for did click a page
    var pageClickCallBackBlock : ((index : NSInteger) -> ())?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.privateInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.privateInit()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    dynamic internal override func prepareForInterfaceBuilder() {
    }
    
    deinit {
        if autoRunTimer.valid {
            autoRunTimer.invalidate()
        }
    }
    
    override var frame : CGRect {
        didSet {
            scrollView.frame = CGRect(origin: CGPointZero, size: frame.size)
            scrollView.contentSize = CGSize(3*frame.width, frame.height)
            scrollView.contentOffset = CGPoint(frame.width, 0)
            contentView.frame = CGRect(origin: CGPointZero, size: CGSize(3*frame.width, frame.height))
            controlView.frame = CGRect(0, frame.height - 30, frame.width, 30)
            for index in 0..<currentViews.count {
                let view = currentViews[index]
                view.frame = CGRect(index*frame.width, 0, frame.width, frame.height)
            }
        }
    }
    
    // MARK: - private
    private let anchorView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let controlView = UIPageControl()
    private var selfConstraints : [AnyObject] = []
    
    private var currentViews : [UIView] = []
    private var cViewConstraints : [NSLayoutConstraint] = []
    
    private var autoRunTimer = NSTimer()
    
    private func privateInit() {
        initAnchor()
        initScroll()
        initControl()
        initConstraints()
    }
    
    private func initAnchor() {
        anchorView.backgroundColor = UIColor.clearColor()
        self.addSubview(anchorView)
    }
    
    private func initScroll() {
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(3*self.width, self.height)
        scrollView.contentOffset = CGPoint(self.width, 0)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        
        contentView.backgroundColor = UIColor.clearColor()
        contentView.frame = CGRect(origin: CGPointZero, size: CGSize(3*self.width, self.height))
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleClick"))
        scrollView.addSubview(contentView)
    }
    
    private func initControl() {
        controlView.frame = CGRect(0, self.height - 30, self.width, 30)
        controlView.pageIndicatorTintColor = pageControlColor
        controlView.currentPageIndicatorTintColor = pageControlTintColor
        controlView.userInteractionEnabled = false
        self.addSubview(controlView)
    }
    
    private func initConstraints() {
        let views = ["anchor": anchorView, "scroll": scrollView, "content": contentView, "control": controlView]
        let Hanchor = NSLayoutConstraint.constraintsWithVisualFormat("H:|[anchor]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let Vanchor = NSLayoutConstraint.constraintsWithVisualFormat("V:|[anchor]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let Hscroll = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scroll]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let Vscroll = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let Hcontent = NSLayoutConstraint.constraintsWithVisualFormat("H:|[content]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let contentHeight = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: anchorView, attribute: .Width, multiplier: 3.0, constant: 0)
        let Vcontent = NSLayoutConstraint.constraintsWithVisualFormat("V:|[content(anchor)]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let Hcontrol = NSLayoutConstraint.constraintsWithVisualFormat("H:|[control]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        let Vcontrol = NSLayoutConstraint.constraintsWithVisualFormat("V:[control(30)]|", options: NSLayoutFormatOptions.DirectionMask, metrics: nil, views: views)
        
        // MARK: 数组连加不能太长，否则会编辑报错
        selfConstraints += Hanchor + Vanchor
        selfConstraints += Hscroll + Vscroll
        selfConstraints += Hcontent + Vcontent
        selfConstraints += [contentHeight]
        selfConstraints += Hcontrol + Vcontrol
    }
    
    dynamic internal override func willMoveToSuperview(newSuperview: UIView?) {
        if let _ = newSuperview where autoScroll && !autoRunTimer.valid {
            autoRunTimer = NSTimer.scheduledTimerWithTimeInterval(autoScrollInterval, target: self, selector: "handleTimer", userInfo: nil, repeats: true)
        }
    }
    
    private func validIndexFromIndex(index: NSInteger) -> NSInteger {
        if index >= pageNumbers {
            return 0
        } else if index < 0 {
            return max(pageNumbers-1, 0)
        } else {
            return index
        }
    }
    
    private func reloadViews() {
        if pageNumbers <= 0 {
            controlView.currentPage = 0
            return
        }
        
        controlView.currentPage = currentPage
        
        self.removeConstraints(cViewConstraints)
        for view in currentViews {
            view.removeFromSuperview()
        }
        cViewConstraints.removeAll(keepCapacity: true)
        currentViews.removeAll(keepCapacity: true)
        
        if let block = viewOfPageBlock {
            for index in 0...2 {
                let view = block(index: validIndexFromIndex(currentPage+(index-1)))
                view.frame = CGRect(index*self.width, 0, self.width, self.height)
                currentViews.append(view)
                contentView .addSubview(view)
                
                if isUseLayoutConstraints {
                    view.setTranslatesAutoresizingMaskIntoConstraints(false)
                    
                    let left = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: index == 0 ? contentView : currentViews[index-1], attribute: index == 0 ? .Leading : .Trailing, multiplier: 1, constant: 0)
                    let centerY = NSLayoutConstraint(item: contentView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
                    let width = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: anchorView, attribute: .Width, multiplier: 1, constant: 0)
                    let height = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: anchorView, attribute: .Height, multiplier: 1, constant: 0)
                    
                    cViewConstraints += [left, centerY, width, height]
                    self.addConstraints([left, centerY, width, height])
                }
            }
        }
        scrollView.setContentOffset(CGPoint(self.width, 0), animated: false)
    }
    
    dynamic private func handleClick() {
        if let block = pageClickCallBackBlock {
            block(index: currentPage)
        }
    }
    
    dynamic private func handleTimer() {
        scrollView.setContentOffset(CGPoint(self.width*2, 0), animated: true)
    }
    
    dynamic internal func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 {
            currentPage--
        } else if scrollView.contentOffset.x >= 2*self.width {
            currentPage++
        }
    }
    
    dynamic internal func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollView.setContentOffset(CGPoint(self.width, 0), animated: true)
        }
    }
    
    dynamic internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(self.width, 0), animated: true)
    }
    
    // MARK: - Publick Methods
    /**
    reload data and reset view for MMCycelScrollView
    */
    func reloadData() {
        currentPage = 0
    }
    /**
    begain to scroll MMCycelScrollView
    */
    func scrollRun() {
        if !autoRunTimer.valid {
            autoRunTimer = NSTimer.scheduledTimerWithTimeInterval(autoScrollInterval, target: self, selector: "handleTimer", userInfo: nil, repeats: true)
        }
    }
    /**
    end scroll
    */
    func scrollInvalidate() {
        autoRunTimer.invalidate()
    }
    
}

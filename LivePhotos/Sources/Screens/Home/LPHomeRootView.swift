//
//  LPHomeRootView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import SnapKit

final class LPHomeRootView: LPBaseView {
    
    var pagingScrollView: UIScrollView!
    
    let kImageCount = 2
    let kPagePadding: CGFloat = 10
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let scrollViewFrame = frameForPagingScrollView()
        pagingScrollView.frame = scrollViewFrame
        pagingScrollView.contentSize = contentSizeForPagingScrollView()
    }
    
}

// MARK: - Setup

private extension LPHomeRootView {
        
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.4, alpha: 1)
        
        setupScrollView()
        setupActivityIndicator()
    }

    func setupScrollView() {
        let scrollViewFrame = frameForPagingScrollView()
        pagingScrollView = UIScrollView(frame: scrollViewFrame)
        addSubview(pagingScrollView)
        pagingScrollView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.4, alpha: 1)
        pagingScrollView.showsVerticalScrollIndicator = false
        pagingScrollView.showsHorizontalScrollIndicator = false
        pagingScrollView.alwaysBounceVertical = false
        pagingScrollView.isPagingEnabled = true
        pagingScrollView.contentSize = contentSizeForPagingScrollView()
    }
    
    func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

// MARK: - Set methods

extension LPHomeRootView {
        
    func setImages(_ images: [LPLivePhoto]) {
        images.enumerated().forEach { (offset, photo) in
            let page = LPPhotoView.loadViewFromNib()
            configure(page, with: photo, for: offset)
            pagingScrollView.addSubview(page)
        }
    }
    
}

// MARK: - ScrollView Frame & Size

private extension LPHomeRootView {
    
    func frameForPagingScrollView() -> CGRect {
        var frame = UIScreen.main.bounds
        frame.origin.x -= kPagePadding
        frame.size.width += 2 * kPagePadding
        return frame
    }
    
    func contentSizeForPagingScrollView() -> CGSize {
        let bounds = self.pagingScrollView.bounds
        let width: CGFloat = bounds.width * CGFloat(kImageCount)
        return CGSize(width: width, height: bounds.height)
    }
    
}

// MARK: - ScrollView Page Frame & Configuration

private extension LPHomeRootView {
    
    func configure(_ page: LPPhotoView, with photo: LPLivePhoto, for index: Int) {
        page.frame = frameForPage(at: index)
        page.image = UIImage(named: photo.imageUrl)
    }
    
    func frameForPage(at index: Int) -> CGRect {
        let bounds = self.pagingScrollView.bounds
        var pageFrame = bounds
        pageFrame.size.width -= 2 * kPagePadding
        pageFrame.origin.x = bounds.width * CGFloat(index) + kPagePadding
        return pageFrame
    }
    
}

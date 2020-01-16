//
//  LPHomeRootView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import SnapKit
import PhotosUI

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
        pagingScrollView.contentSize.width = contentSizeForPagingScrollView().width
    }
    
}

// MARK: - Setup

private extension LPHomeRootView {
    
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
        
        setupScrollView()
        setupActivityIndicator()
    }

    func setupScrollView() {
        pagingScrollView = UIScrollView()
        addSubview(pagingScrollView)
        pagingScrollView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(-kPagePadding)
            $0.width.equalToSuperview().offset(2 * kPagePadding)
            $0.top.bottom.equalToSuperview()
        }
        pagingScrollView.backgroundColor = backgroundColor
        pagingScrollView.showsVerticalScrollIndicator = false
        pagingScrollView.showsHorizontalScrollIndicator = false
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
        
    func setImages(_ images: [PHLivePhoto]) {
        images.enumerated().forEach { (offset, photo) in
            let page = LPPhotoView.loadViewFromNib()
            pagingScrollView.addSubview(page)
            configure(page, with: photo, for: offset)
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
    
    func configure(_ page: LPPhotoView, with photo: PHLivePhoto, for index: Int) {
        let frame = frameForPage(at: index)
        page.snp.makeConstraints {
            $0.left.equalToSuperview().offset(frame.origin.x)
            $0.width.equalTo(frame.width)
            $0.height.equalTo(pagingScrollView.frameLayoutGuide)
        }
        page.livePhoto = photo
    }
    
    func frameForPage(at index: Int) -> CGRect {
        let bounds = self.pagingScrollView.bounds
        var pageFrame = bounds
        pageFrame.size.width -= 2 * kPagePadding
        pageFrame.origin.x = bounds.width * CGFloat(index) + kPagePadding
        return pageFrame
    }
    
}

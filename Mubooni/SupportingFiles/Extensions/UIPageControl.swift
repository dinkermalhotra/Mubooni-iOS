import UIKit
import Foundation

class CustomPageControl: UIPageControl {
    
    @IBInspectable var currentPageColor: UIColor?
    @IBInspectable var currentPageImage: UIImage?
    @IBInspectable var otherPagesColor: UIColor?
    @IBInspectable var otherPagesImage: UIImage?
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        }
        else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }
    
    private func defaultConfigurationForiOS14AndAbove() {
        if #available(iOS 14.0, *) {
            for index in 0..<numberOfPages {
                let image = index == currentPage ? currentPageImage : otherPagesImage
                setIndicatorImage(image, forPage: index)
            }
            
            // give the same color as "otherPagesImage" color.
            pageIndicatorTintColor = otherPagesColor
            
            // give the same color as "currentPageImage" color.
            currentPageIndicatorTintColor = currentPageColor
            /*
             Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
             */
        }
    }
    
    private func updateDots() {
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        }
        else {
            for (index, subview) in subviews.enumerated() {
                let imageView: UIImageView
                if let existingImageview = getImageView(forSubview: subview) {
                    imageView = existingImageview
                }
                else {
                    imageView = UIImageView(image: otherPagesImage)
                    
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
            }
        }
    }
    
    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        }
        else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView
            
            return view
        }
    }
}

//
//  CropToolBar.swift
//  CropViewController
//
//  Created by Alexsander Khitev on 2/26/17.
//  Copyright © 2017 Alexsander Khitev. All rights reserved.
//

import UIKit

class CropToolBar: UIView {
    
    var doneTextButton: UIButton!
    var doneIconButton: UIButton!
    var cancelTextButton: UIButton!
    var cancelIconButton: UIButton!
    var resetButton: UIButton!
    var clampButton: UIButton!
    var rotateButton: UIButton! {
        return self.rotateCounterclockwiseButton
    }
    // defaults to counterclockwise button for legacy compatibility
    var isReverseContentLayout: Bool = false
    // For languages like Arabic where they natively present content flipped from English
    
    func setup() {
        self.backgroundColor = UIColor(white: CGFloat(0.12), alpha: CGFloat(1.0))
        self.isRotateClockwiseButtonHidden = true
        // On iOS 9, we can use the new layout features to determine whether we're in an 'Arabic' style language mode
        if UIView.resolveClassMethod(#selector(self.userInterfaceLayoutDirectionForSemanticContentAttribute)) {
            self.isReverseContentLayout = (UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft)
        }
        else {
            self.isReverseContentLayout = NSLocale.preferredLanguages[0].hasPrefix("ar")
        }
        // In CocoaPods, strings are stored in a separate bundle from the main one
        var resourceBundle: Bundle? = nil
        var classBundle = Bundle(forClass: self.self)
        var resourceBundleURL: URL? = classBundle.url(forResource: "TOCropViewControllerBundle", withExtension: "bundle")
        if resourceBundleURL != nil {
            resourceBundle = Bundle(url: resourceBundleURL)
        }
        else {
            resourceBundle = classBundle
        }
        self.doneTextButton = UIButton(type: .system)
        self.doneTextButton.setTitle(NSLocalizedStringFromTableInBundle("Done", "TOCropViewControllerLocalizable", resourceBundle, nil), for: .normal)
        self.doneTextButton.setTitleColor(UIColor(red: CGFloat(1.0), green: CGFloat(0.8), blue: CGFloat(0.0), alpha: CGFloat(1.0)), for: .normal)
        self.doneTextButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(17.0))
        self.doneTextButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.doneTextButton)
        self.doneIconButton = UIButton(type: .system)
        self.doneIconButton.setImage(CropToolBar.doneImage(), for: .normal)
        self.doneIconButton.tintColor = UIColor(red: CGFloat(1.0), green: CGFloat(0.8), blue: CGFloat(0.0), alpha: CGFloat(1.0))
        self.doneIconButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.doneIconButton)
        self.cancelTextButton = UIButton(type: .system)
        self.cancelTextButton.setTitle(NSLocalizedStringFromTableInBundle("Cancel", "TOCropViewControllerLocalizable", resourceBundle, nil), for: .normal)
        self.cancelTextButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(17.0))
        self.cancelTextButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.cancelTextButton)
        self.cancelIconButton = UIButton(type: .system)
        self.cancelIconButton.setImage(CropToolBar.cancelImage(), for: .normal)
        self.cancelIconButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.cancelIconButton)
        self.clampButton = UIButton(type: .system)
        self.clampButton.contentMode = .center
        self.clampButton.tintColor = UIColor.white
        self.clampButton.setImage(CropToolBar.clampImage(), for: .normal)
        self.clampButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.clampButton)
        self.rotateCounterclockwiseButton = UIButton(type: .system)
        self.rotateCounterclockwiseButton.contentMode = .center
        self.rotateCounterclockwiseButton.tintColor = UIColor.white
        self.rotateCounterclockwiseButton.setImage(CropToolBar.rotateCCWImage(), for: .normal)
        self.rotateCounterclockwiseButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.rotateCounterclockwiseButton)
        self.resetButton = UIButton(type: .system)
        self.resetButton.contentMode = .center
        self.resetButton.tintColor = UIColor.white
        self.resetButton.isEnabled = false
        self.resetButton.setImage(CropToolBar.resetImage(), for: .normal)
        self.resetButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(self.resetButton)
    }
    
    func buttonTapped(_ button: UIButton) {
        if button == cancelTextButton || button == cancelIconButton {
            if (cancelButtonTapped != nil) {
                cancelButtonTapped?()
            }
        }
        else if button == self.doneTextButton || button == self.doneIconButton {
            if (self.doneButtonTapped != nil) {
                self.doneButtonTapped?()
            }
        }
        else if button == self.resetButton && self.resetButtonTapped {
            self.resetButtonTapped?()
        }
        else if button == self.rotateCounterclockwiseButton && (self.rotateCounterclockwiseButtonTapped != nil) {
            rotateCounterclockwiseButtonTapped?()
        }
        else if button == rotateClockwiseButton && (rotateClockwiseButtonTapped != nil) {
            rotateClockwiseButtonTapped?()
        }
        else if button == self.clampButton && self.clampButtonTapped {
            clampButtonTapped?()
            return
        }
    }
    
    class func doneImage() -> UIImage {
        var doneImage: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions([17, 14], false, 0.0)
        do {
            //// Rectangle Drawing
            var rectanglePath = UIBezierPath()
            rectanglePath.move(to: CGPoint(x: CGFloat(1), y: CGFloat(7)))
            rectanglePath.addLine(to: CGPoint(x: CGFloat(6), y: CGFloat(12)))
            rectanglePath.addLine(to: CGPoint(x: CGFloat(16), y: CGFloat(1)))
            UIColor.white.setStroke()
            rectanglePath.lineWidth = 2
            rectanglePath.stroke()
            doneImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return doneImage!
    }
    
    class func cancelImage() -> UIImage {
        var cancelImage: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions([16, 16], false, 0.0)
        do {
            var bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: CGFloat(15), y: CGFloat(15)))
            bezierPath.addLine(to: CGPoint(x: CGFloat(1), y: CGFloat(1)))
            UIColor.white.setStroke()
            bezierPath.lineWidth = 2
            bezierPath.stroke()
            //// Bezier 2 Drawing
            var bezier2Path = UIBezierPath()
            bezier2Path.move(to: CGPoint(x: CGFloat(1), y: CGFloat(15)))
            bezier2Path.addLine(to: CGPoint(x: CGFloat(15), y: CGFloat(1)))
            UIColor.white.setStroke()
            bezier2Path.lineWidth = 2
            bezier2Path.stroke()
            cancelImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return cancelImage!
    }
    
    class func resetImage() -> UIImage {
        var resetImage: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 22, height: 18), false, 0)
//        UIGraphicsBeginImageContextWithOptions([22, 18], false, 0.0)
        do {
            //// Bezier 2 Drawing
            let bezier2Path = UIBezierPath()
            bezier2Path.move(to: CGPoint(x: CGFloat(22), y: CGFloat(9)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(13), y: CGFloat(18)), controlPoint1: CGPoint(x: CGFloat(22), y: CGFloat(13.97)), controlPoint2: CGPoint(x: CGFloat(17.97), y: CGFloat(18)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(13), y: CGFloat(16)), controlPoint1: CGPoint(x: CGFloat(13), y: CGFloat(17.35)), controlPoint2: CGPoint(x: CGFloat(13), y: CGFloat(16.68)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(20), y: CGFloat(9)), controlPoint1: CGPoint(x: CGFloat(16.87), y: CGFloat(16)), controlPoint2: CGPoint(x: CGFloat(20), y: CGFloat(12.87)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(13), y: CGFloat(2)), controlPoint1: CGPoint(x: CGFloat(20), y: CGFloat(5.13)), controlPoint2: CGPoint(x: CGFloat(16.87), y: CGFloat(2)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(6.55), y: CGFloat(6.27)), controlPoint1: CGPoint(x: CGFloat(10.1), y: CGFloat(2)), controlPoint2: CGPoint(x: CGFloat(7.62), y: CGFloat(3.76)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(6), y: CGFloat(9)), controlPoint1: CGPoint(x: CGFloat(6.2), y: CGFloat(7.11)), controlPoint2: CGPoint(x: CGFloat(6), y: CGFloat(8.03)))
            bezier2Path.addLine(to: CGPoint(x: CGFloat(4), y: CGFloat(9)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(4.65), y: CGFloat(5.63)), controlPoint1: CGPoint(x: CGFloat(4), y: CGFloat(7.81)), controlPoint2: CGPoint(x: CGFloat(4.23), y: CGFloat(6.67)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(7.65), y: CGFloat(1.76)), controlPoint1: CGPoint(x: CGFloat(5.28), y: CGFloat(4.08)), controlPoint2: CGPoint(x: CGFloat(6.32), y: CGFloat(2.74)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(13), y: CGFloat(0)), controlPoint1: CGPoint(x: CGFloat(9.15), y: CGFloat(0.65)), controlPoint2: CGPoint(x: CGFloat(11), y: CGFloat(0)))
            bezier2Path.addCurve(to: CGPoint(x: CGFloat(22), y: CGFloat(9)), controlPoint1: CGPoint(x: CGFloat(17.97), y: CGFloat(0)), controlPoint2: CGPoint(x: CGFloat(22), y: CGFloat(4.03)))
            bezier2Path.close()
            UIColor.white.setFill()
            bezier2Path.fill()
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.move(to: CGPoint(x: CGFloat(5), y: CGFloat(15)))
            polygonPath.addLine(to: CGPoint(x: CGFloat(10), y: CGFloat(9)))
            polygonPath.addLine(to: CGPoint(x: CGFloat(0), y: CGFloat(9)))
            polygonPath.addLine(to: CGPoint(x: CGFloat(5), y: CGFloat(15)))
            polygonPath.close()
            UIColor.white.setFill()
            polygonPath.fill()
            resetImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return resetImage!
    }
    
    class func rotateCCWImage() -> UIImage {
        var rotateImage: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 18, height: 21), false, 0)
//        UIGraphicsBeginImageContextWithOptions([18, 21], false, 0.0)
        do {
            //// Rectangle 2 Drawing
            var rectangle2Path = UIBezierPath(rect: CGRect(x: CGFloat(0), y: CGFloat(9), width: CGFloat(12), height: CGFloat(12)))
            UIColor.white.setFill()
            rectangle2Path.fill()
            //// Rectangle 3 Drawing
            var rectangle3Path = UIBezierPath()
            rectangle3Path.move(to: CGPoint(x: CGFloat(5), y: CGFloat(3)))
            rectangle3Path.addLine(to: CGPoint(x: CGFloat(10), y: CGFloat(6)))
            rectangle3Path.addLine(to: CGPoint(x: CGFloat(10), y: CGFloat(0)))
            rectangle3Path.addLine(to: CGPoint(x: CGFloat(5), y: CGFloat(3)))
            rectangle3Path.close()
            UIColor.white.setFill()
            rectangle3Path.fill()
            //// Bezier Drawing
            var bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: CGFloat(10), y: CGFloat(3)))
            bezierPath.addCurve(to: CGPoint(x: CGFloat(17.5), y: CGFloat(11)), controlPoint1: CGPoint(x: CGFloat(15), y: CGFloat(3)), controlPoint2: CGPoint(x: CGFloat(17.5), y: CGFloat(5.91)))
            UIColor.white.setStroke()
            bezierPath.lineWidth = 1
            bezierPath.stroke()
            rotateImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return rotateImage!
    }
    
    class func rotateCWImage() -> UIImage {
        var rotateCCWImage: UIImage? = self.self.rotateCCWImage()
        UIGraphicsBeginImageContextWithOptions(rotateCCWImage?.size, false, rotateCCWImage?.scale)
        var context: CGContext? = UIGraphicsGetCurrentContext()
        context.translateBy(x: rotateCCWImage?.size?.width, y: rotateCCWImage?.size?.height)
        context.rotate(by: .pi)
        context.draw(in: rotateCCWImage?.cgImage, image: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(rotateCCWImage?.size?.width), height: CGFloat(rotateCCWImage?.size?.height)))
        var rotateCWImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotateCWImage!
    }
    
    class func clampImage() -> UIImage {
        var clampImage: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 22, height: 16), false, 0)

//        UIGraphicsBeginImageContextWithOptions([22, 16], false, 0.0)
        do {
            //// Color Declarations
            var outerBox = UIColor(red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(0.553))
            var innerBox = UIColor(red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(0.773))
            //// Rectangle Drawing
            var rectanglePath = UIBezierPath(rect: CGRect(x: CGFloat(0), y: CGFloat(3), width: CGFloat(13), height: CGFloat(13)))
            UIColor.white.setFill()
            rectanglePath.fill()
            //// Outer
            do {
                //// Top Drawing
                var topPath = UIBezierPath(rect: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(22), height: CGFloat(2)))
                outerBox.setFill()
                topPath.fill()
                //// Side Drawing
                var sidePath = UIBezierPath(rect: CGRect(x: CGFloat(19), y: CGFloat(2), width: CGFloat(3), height: CGFloat(14)))
                outerBox.setFill()
                sidePath.fill()
            }
            //// Rectangle 2 Drawing
            var rectangle2Path = UIBezierPath(rect: CGRect(x: CGFloat(14), y: CGFloat(3), width: CGFloat(4), height: CGFloat(13)))
            innerBox.setFill()
            rectangle2Path.fill()
            clampImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return clampImage!
    }
    /* In horizontal mode, offsets all of the buttons vertically by 20 points. */
    var isStatusBarVisible: Bool = false
    /* The 'Done' buttons to commit the crop. The text button is displayed
     in portrait mode and the icon one, in landscape. */
    private(set) var doneTextButton: UIButton!
    private(set) var doneIconButton: UIButton!
    /* The 'Cancel' buttons to cancel the crop. The text button is displayed
     in portrait mode and the icon one, in landscape. */
    private(set) var cancelTextButton: UIButton!
    private(set) var cancelIconButton: UIButton!
    /* The cropper control buttons */
    private(set) var rotateCounterclockwiseButton: UIButton!
    private(set) var resetButton: UIButton!
    private(set) var clampButton: UIButton!
    private(set) var rotateClockwiseButton: UIButton!
    var rotateButton: UIButton! {
        return self.rotateCounterclockwiseButton
    }
    // Points to `rotateCounterClockwiseButton`
    /* Button feedback handler blocks */
    var cancelButtonTapped: (() -> Void)?//((_: Void) -> Void)?
    var doneButtonTapped: (() -> Void)?
    var rotateCounterclockwiseButtonTapped: (() -> Void)?//((_: Void) -> Void)??
    var rotateClockwiseButtonTapped: (() -> Void)?//((_: Void) -> Void)??
    var clampButtonTapped: (() -> Void)?//((_: Void) -> Void)??
    var resetButtonTapped: (() -> Void)?//((_: Void) -> Void)??
    /* State management for the 'clamp' button */
    var isClampButtonGlowing: Bool {
        get {
            // TODO: add getter implementation
        }
        set(clampButtonGlowing) {
            if self.isClampButtonGlowing == isClampButtonGlowing {
                return
            }
            self.isClampButtonGlowing = isClampButtonGlowing
            if self.isClampButtonGlowing {
                self.clampButton.tintColor = nil
            }
            else {
                self.clampButton.tintColor = UIColor.white
            }
        }
    }
    var clampButtonFrame: CGRect {
        return self.clampButton.frame
    }
    /* Aspect ratio button visibility settings */
    var isClampButtonHidden: Bool {
        get {
            // TODO: add getter implementation
        }
        set(clampButtonHidden) {
            if self.isClampButtonHidden == isClampButtonHidden {
                return
            }
            self.isClampButtonHidden = isClampButtonHidden
            self.setNeedsLayout()
        }
    }
    var isRotateCounterclockwiseButtonHidden: Bool = false
    var isRotateClockwiseButtonHidden: Bool {
        get {
            // TODO: add getter implementation
        }
        set(rotateClockwiseButtonHidden) {
            if self.isRotateClockwiseButtonHidden == isRotateClockwiseButtonHidden {
                return
            }
            self.isRotateClockwiseButtonHidden = isRotateClockwiseButtonHidden
            if self.isRotateClockwiseButtonHidden == false {
                self.rotateClockwiseButton = UIButton(type: .system)
                self.rotateClockwiseButton.contentMode = .center
                self.rotateClockwiseButton.tintColor = UIColor.white
                self.rotateClockwiseButton.setImage(CropToolBar.rotateCWImage(), for: .normal)
                self.rotateClockwiseButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
                self.addSubview(self.rotateClockwiseButton)
            }
            else {
                self.rotateClockwiseButton.removeFromSuperview()
                self.rotateClockwiseButton = nil
            }
            self.setNeedsLayout()
        }
    }
    /* Enable the reset button */
    var isResetButtonEnabled: Bool {
        get {
            return self.resetButton.isEnabled
        }
        set(resetButtonEnabled) {
            self.resetButton.isEnabled = isResetButtonEnabled
        }
    }
    /* Done button frame for popover controllers */
    var doneButtonFrame: CGRect {
        if self.doneIconButton.isHidden == false {
            return self.doneIconButton.frame
        }
        return self.doneTextButton.frame
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var verticalLayout: Bool = (self.bounds.width < self.bounds.height)
        var boundsSize: CGSize = self.bounds.size
        self.cancelIconButton.isHidden = (!verticalLayout)
        self.cancelTextButton.isHidden = (verticalLayout)
        self.doneIconButton.isHidden = (!verticalLayout)
        self.doneTextButton.isHidden = (verticalLayout)
        #if TOCROPTOOLBAR_DEBUG_SHOWING_BUTTONS_CONTAINER_RECT
            var containerView: UIView? = nil
            if containerView == nil {
                containerView = UIView(frame: CGRect.zero)
                containerView?.backgroundColor = UIColor.red
                containerView?.alpha = 0.1
                self.addSubview(containerView)
            }
        #endif
        if verticalLayout == false {
            var insetPadding: CGFloat = 10.0
            // Work out the cancel button frame
            var frame = CGRect.zero
            frame.origin.y = self.isStatusBarVisible ? 20.0 : 0.0
            frame.size.height = 44.0
            frame.size.width = self.cancelTextButton.titleLabel?.text?.size(attributes: [NSFontAttributeName: self.cancelTextButton.titleLabel?.font])?.width + 10
            //If normal layout, place on the left side, else place on the right
            if self.isReverseContentLayout == false {
                frame.origin.x = insetPadding
            }
            else {
                frame.origin.x = boundsSize.width - (frame.size.width + insetPadding)
            }
            self.cancelTextButton.frame = frame
            // Work out the Done button frame
            frame.size.width = self.doneTextButton.titleLabel?.text?.size(attributes: [NSFontAttributeName: self.doneTextButton.titleLabel?.font])?.width + 10
            if self.isReverseContentLayout == false {
                frame.origin.x = boundsSize.width - (frame.size.width + insetPadding)
            }
            else {
                frame.origin.x = insetPadding
            }
            self.doneTextButton.frame = frame
            // Work out the frame between the two buttons where we can layout our action buttons
            var x: CGFloat = self.isReverseContentLayout ? self.doneTextButton.frame.maxX : self.cancelTextButton.frame.maxX
            var width: CGFloat = 0.0
            if self.isReverseContentLayout == false {
                width = self.doneTextButton.frame.minX - self.cancelTextButton.frame.maxX
            }
            else {
                width = self.cancelTextButton.frame.minX - self.doneTextButton.frame.maxX
            }
            var containerRect: CGRect = [x, frame.origin.y, width, 44.0]
            #if TOCROPTOOLBAR_DEBUG_SHOWING_BUTTONS_CONTAINER_RECT
                containerView?.frame = containerRect
            #endif
            var buttonSize: CGSize = [44.0, 44.0]
            var buttonsInOrderHorizontally = [Any]()
            if !self.isRotateCounterclockwiseButtonHidden {
                buttonsInOrderHorizontally.append(self.rotateCounterclockwiseButton)
            }
            buttonsInOrderHorizontally.append(self.resetButton)
            if !self.isClampButtonHidden {
                buttonsInOrderHorizontally.append(self.clampButton)
            }
            if !self.isRotateClockwiseButtonHidden {
                buttonsInOrderHorizontally.append(self.rotateClockwiseButton)
            }
            self.layoutToolbarButtons(buttonsInOrderHorizontally, withSameButtonSize: buttonSize, inContainerRect: containerRect, horizontally: true)
        }
        else {
            var frame = CGRect.zero
            frame.size.height = 44.0
            frame.size.width = 44.0
            frame.origin.y = self.bounds.height - 44.0
            self.cancelIconButton.frame = frame
            frame.origin.y = 0.0
            frame.size.width = 44.0
            frame.size.height = 44.0
            self.doneIconButton.frame = frame
            var containerRect: CGRect = [0, self.doneIconButton.frame.maxY, 44.0, self.cancelIconButton.frame.minY - self.doneIconButton.frame.maxY]
            #if TOCROPTOOLBAR_DEBUG_SHOWING_BUTTONS_CONTAINER_RECT
                containerView?.frame = containerRect
            #endif
            var buttonSize: CGSize = [44.0, 44.0]
            var buttonsInOrderVertically = [Any]()
            if !self.isRotateCounterclockwiseButtonHidden {
                buttonsInOrderVertically.append(self.rotateCounterclockwiseButton)
            }
            buttonsInOrderVertically.append(self.resetButton)
            if !self.isClampButtonHidden {
                buttonsInOrderVertically.append(self.clampButton)
            }
            if !self.isRotateClockwiseButtonHidden {
                buttonsInOrderVertically.append(self.rotateClockwiseButton)
            }
            self.layoutToolbarButtons(buttonsInOrderVertically, withSameButtonSize: buttonSize, inContainerRect: containerRect, horizontally: false)
        }
    }
    // The convenience method for calculating button's frame inside of the container rect
    
    func layoutToolbarButtons(_ buttons: [Any], withSameButtonSize size: CGSize, inContainerRect containerRect: CGRect, horizontally: Bool) {
        var count: Int = buttons.count
        var fixedSize: CGFloat = horizontally ? size.width : size.height
        var maxLength: CGFloat = horizontally ? containerRect.width : containerRect.height
        var padding: CGFloat = (maxLength - fixedSize * count) / (count + 1)
        for i in 0..<count {
            var button: UIView? = buttons[i]
            var sameOffset: CGFloat? = horizontally ? fabs(containerRect.height - button?.bounds.height) : fabs(containerRect.width - button?.bounds.width)
            var diffOffset: CGFloat = padding + i * (fixedSize + padding)
            var origin = horizontally ? CGPoint(x: diffOffset, y: CGFloat(sameOffset)) : CGPoint(x: CGFloat(sameOffset), y: diffOffset)
            if horizontally {
                origin.x += containerRect.minX
                origin.y += self.isStatusBarVisible ? 20.0 : 0.0
            }
            else {
                origin.y += containerRect.minY
            }
            button?.frame = [origin, size]
        }
    }
    
    func setRotateCounterClockwiseButtonHidden(_ rotateButtonHidden: Bool) {
        if self.isRotateCounterclockwiseButtonHidden == rotateButtonHidden {
            return
        }
        self.isRotateCounterclockwiseButtonHidden = rotateButtonHidden
        self.setNeedsLayout()
    }
    // MARK: - Image Generation -
    // MARK: - Accessors -
}

// TODO: - remove it

let TOCROPTOOLBAR_DEBUG_SHOWING_BUTTONS_CONTAINER_RECT = 0

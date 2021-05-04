//
//  ViewController.swift
//  ReactionAnimations
//
//  Created by Nishant Taneja on 05/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var button: UIButton!
    
    private let iconsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let iconHeight: CGFloat = 48
        view.layer.cornerRadius = iconHeight / 2
        let padding: CGFloat = 8
        let arrangedSubViews = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")].compactMap { image -> UIView in
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = iconHeight/2
            return imageView
        }
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = .init(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        let numberOfIcons = CGFloat(arrangedSubViews.count)
        stackView.frame.size = CGSize(width:  numberOfIcons * iconHeight + (numberOfIcons + 1)*padding, height: iconHeight + (2 * padding))
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = iconHeight/2
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.frame.size = stackView.frame.size
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = button.frame.height / 2
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:))))
    }
}

extension ViewController {
    @objc private func handleLongPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began: // Display Reactions
            handleStateBegan(gesture)
        case .changed: // Move Icons
            handleStateChanged(gesture)
        case .ended: // Remove animations & from SuperView
            handleStateEnded(gesture)
        default: break
        }
    }
}

extension ViewController {
    private func handleStateBegan(_ gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconsContainerView)
        iconsContainerView.alpha = 0
        iconsContainerView.center = button.center
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.iconsContainerView.transform = CGAffineTransform(translationX: 0, y: -self.iconsContainerView.frame.height - 8)
            self.iconsContainerView.alpha = 1
        }
    }
    
    private func handleStateChanged(_ gesture: UILongPressGestureRecognizer) {
        print(#function)
    }
    
    private func handleStateEnded(_ gesture: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.iconsContainerView.transform = .identity
            self.iconsContainerView.alpha = 0
        } completion: { _ in
            self.iconsContainerView.removeFromSuperview()
        }

    }
}

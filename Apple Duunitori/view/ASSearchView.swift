//
//  ASSearchView.swift
//  Apple Duunitori
//
//  Created by giang on 1/7/18.
//  Copyright © 2018 giang. All rights reserved.
//

import UIKit
import AsyncDisplayKit

let textFieldHeight = 31
let iconSize = 30

class ASSearchView: ASDisplayNode {
    
    private(set) var searchField : ASEditableTextNode!
    private(set) var imageButton : ASButtonNode!
    private(set) var commandButton : ASButtonNode!
    
    private(set) var primaryText: String! = ""
    private(set) var secondaryText: String! = ""
    
    private(set) var isInSecondaryMode : Bool = false {
        didSet {
            stateChanged()
            setNeedsLayout()
        }
    }
    
    override init() {
        super.init()
        let image = UIImage(named: "ic_location_off")
        searchField = ASEditableTextNode()
        searchField.style.flexGrow = 1.0
        searchField.maximumLinesToDisplay = 1
        searchField.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        searchField.borderWidth = 1
        searchField.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        searchField.typingAttributes = [NSAttributedStringKey.foregroundColor.rawValue : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),  NSAttributedStringKey.font.rawValue : UIFont(name: "Helvetica", size: 15.0)!]
        
        imageButton = ASButtonNode()
        imageButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        imageButton.setImage(image, for: .normal)
        imageButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        imageButton.style.flexGrow = 0
        
        commandButton = ASButtonNode()
        commandButton.style.flexGrow = 0
        
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        stateChanged()
        imageButton.addTarget(self, action: #selector(imageButtonPressed), forControlEvents: .touchUpInside)
        commandButton.addTarget(self, action: #selector(commandButtonPressed), forControlEvents: .touchUpInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let searchFieldInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 8), child: searchField)
        searchFieldInsetSpec.style.flexGrow = 1.0
        let imageButtonInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0), child: imageButton)
        
        let commandButtonInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 16), child: commandButton)
        
        let stackView = ASStackLayoutSpec.horizontal()
        stackView.alignItems = .center
        stackView.justifyContent = .start
        if isInSecondaryMode {
            stackView.children = [searchFieldInsetSpec, commandButtonInsetSpec]
        } else {
            stackView.children = [searchFieldInsetSpec, imageButtonInsetSpec, commandButtonInsetSpec]
        }
        
        return stackView
    }
    
    override func layout() {
        super.layout()
        searchField.cornerRadius = searchField.calculatedSize.height / 2
        imageButton.cornerRadius = imageButton.calculatedSize.height / 2
    }
    
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        if isInSecondaryMode {
            UIView.animate(withDuration: 0.3, animations: {
                self.imageButton.alpha = 0
                self.imageButton.isHidden = true
            }, completion: { (completed) in
                context.completeTransition(completed)
            })
        } else {
            
        }
    }
    
    fileprivate func stateChanged() {
        commandButton.setTitle(isInSecondaryMode ? "Cancel" : "Search", with: nil, with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        searchField.attributedPlaceholderText = NSAttributedString(string: isInSecondaryMode ? "Where?" : "Looking for a job?", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), NSAttributedStringKey.font : UIFont(name: "Helvetica", size: 15.0)!])
    }
    
    @objc func imageButtonPressed() {
        isInSecondaryMode = true
    }
    
    @objc func commandButtonPressed() {
        if isInSecondaryMode {
            isInSecondaryMode = false
        }
    }
}

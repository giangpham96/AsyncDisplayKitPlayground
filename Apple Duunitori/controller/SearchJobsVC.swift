//
//  SearchJobsVC.swift
//  Apple Duunitori
//
//  Created by giang on 1/7/18.
//  Copyright © 2018 giang. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SearchJobsVC: ASViewController<ASDisplayNode> {
    init() {
        super.init(node: ASDisplayNode())
        title = "random title"
        node.addSubnode(ASSearchView())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
    }
}

//
//  TableViewController.swift
//  Collapsibleheaders
//
//  Created by Ben Smith on 05/12/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int)
}
class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(CollapsibleTableViewHeader.tapHeader(gestureRecognizer:))))

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let views = [
            "titleLabel" : titleLabel,
            "arrowLabel" : arrowLabel,
            ]
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|",
            options: [],
            metrics: nil,
            views: views
        ))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[titleLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[arrowLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
    }
    @objc func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func setCollapsed(collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
//        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {
//    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
//        let collapsed = !section[section].collapsed
//
//        // Toggle collapse
//        section[section].collapsed = collapsed
//        header.setCollapsed(collapsed)
//
//        // Reload the whole section
//        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
//    }
//}


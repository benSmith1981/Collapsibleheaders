//
//  ViewController.swift
//  Collapsibleheaders
//
//  Created by Ben Smith on 05/12/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
struct Section {
    var name: String
    var items: [String]
    var collapsed: Bool
    
    init(name: String,
         items: [String],
         collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var sections = [Section]()
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        
        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        sections = [
            Section(name: "Mac", items: ["MacBook", "MacBook Air"], collapsed: false),
            Section(name: "iPad", items: ["iPad Pro", "iPad Air 2"], collapsed: false),
            Section(name: "iPhone", items: ["iPhone 7", "iPhone 6"], collapsed: false)
        ]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: sections[section].collapsed)
        header.section = section
        header.delegate = self
        return header
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return sections[(indexPath as NSIndexPath).section].collapsed ? 0 : UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count

    }
}


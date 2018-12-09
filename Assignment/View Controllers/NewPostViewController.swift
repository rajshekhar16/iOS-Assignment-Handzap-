//
//  ViewController.swift
//  Assignment
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var picker:UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension NewPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableCell") as? DescriptionTableCell {
                descriptionCell.textViewDesc.isScrollEnabled = false
                descriptionCell.textViewDesc.translatesAutoresizingMaskIntoConstraints = false
                descriptionCell.tag = indexPath.row
                return descriptionCell
            }
        } else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleElementTableViewCell", for: indexPath) as? DoubleElementTableViewCell {
                cell.tag = indexPath.row
                cell.setPlaceHoldersForFields(picker)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SingleElementTableViewCell", for: indexPath) as? SingleElementTableViewCell {
                cell.tag = indexPath.row
                cell.setPlaceHoldersForFields()
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension NewPostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
}


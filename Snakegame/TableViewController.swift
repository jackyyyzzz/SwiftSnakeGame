//
//  TableViewController.swift
//  Snakegame
//
//  Created by Jacky on 2019-05-26.
//  Copyright © 2019 Jacky. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

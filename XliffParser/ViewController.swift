//
//  ViewController.swift
//  XliffParser
//
//  Created by Tudor Ana on 7/31/18.
//  Copyright © 2018 Tudor Ana. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var segmentedControl: NSSegmentedControl!
    @IBOutlet weak var parseButton: NSButton!
    @IBOutlet weak var inputTextView: NSTextView!
    @IBOutlet weak var outputTextView: NSTextView!
    
    
    
    @IBAction func parseAction(id: Any) {
        print("Parse")
        
        
        if let output = Parser.shared.parse(string: inputTextView.string, type: segmentedControl.selectedSegment) {
            outputTextView.string = output
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegment = 0

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


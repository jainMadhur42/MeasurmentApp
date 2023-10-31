//
//  ShareableTextSource.swift
//  AROFFSETAPP
//
//  Created by Darshan on 29/10/23.
//

import Foundation
import UIKit

class ShareableTextSource: NSObject, UIActivityItemSource {
    
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Destination"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        
        return text
    }
}

//
//  LogTableViewCell.swift
//  Pods
//
//  Created by Martin Eberl on 09.08.17.
//
//

import UIKit

public final class LogTableViewCell: UITableViewCell {
    static let nibName = "LogTableViewCell"
    private let formatter = DateFormatter()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logTextLabel: UILabel!
    
    var content: SwiftLogProtocol? {
        didSet {
            updateUI()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
    }
    
    private func updateUI() {
        dateLabel.isHidden = content?.date == nil
        
        if let date = content?.date {
            dateLabel.text = formatter.string(from: date)
        }
        
        logTextLabel.text = content?.text
    }
}

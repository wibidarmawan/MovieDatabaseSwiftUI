//
//  String+Extension.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 24/03/25.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy"
        
        return outputFormatter.string(from: date)
    }
} 

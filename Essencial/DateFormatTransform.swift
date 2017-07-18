//
//  DateFormatTransform.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/17/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import ObjectMapper
public class DateFormatTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    var dateFormat = DateFormatter()
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat.dateFormat = "yyyy-MM-dd hh:mm:ss ZZZ"
        self.dateFormat.locale = Locale(identifier: "en_US")
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if let dateString = value as? String {
            return self.dateFormat.date(from: dateString)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let date = value {
            return self.dateFormat.string(from: date as Date)
        }
        return nil
    }
}

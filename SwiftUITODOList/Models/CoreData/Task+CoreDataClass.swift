//
//  Task+CoreDataClass.swift
//  SwiftUITODOList
//
//  Created by Deborah Newberry on 6/20/19.
//  Copyright © 2019 Deborah Newberry. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI
import Combine

@objc(Task)
public class Task: NSManagedObject,  BindableObject {
    public let didChange = PassthroughSubject<Void, Never>()
    private var changePublisher: PassthroughSubject<Void, Never> {
        return didChange
    }

    override public func didChangeValue(forKey key: String) {
        super.didChangeValue(forKey: key)
        self.changePublisher.send(())
    }
    
    func toggleCompletion() {
        isComplete = !isComplete
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: dateAdded)
    }
}

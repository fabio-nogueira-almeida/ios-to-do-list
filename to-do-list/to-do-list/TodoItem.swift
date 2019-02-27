//
//  TodoItem.swift
//  to-do-list
//
//  Created by Fábio Nogueira de Almeida on 26/02/19.
//  Copyright © 2019 Fábio Nogueira de Almeida. All rights reserved.
//

import Foundation

struct TodoItem: Codable {
    var title: String
    var completed: Bool
    var createdAt: Date
    var itemIdentifier: UUID

    func saveItem() {
    }

    func deleteItem() {
    }

    func markAsCompleted() {
    }
}

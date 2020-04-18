//
//  Todo.swift
//  SwiftUITodo
//
//  Created by Ethan Hess on 4/13/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Chore : Identifiable {
    //var id: ObjectIdentifier //This should just be key?
    var id = String()
    var choreBody = String()
    var imageData : Data? //For core data
}

class ChoreDatabase : ObservableObject {
    @Published var chores = [Chore]()
}

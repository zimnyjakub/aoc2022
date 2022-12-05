//
//  File.swift
//  
//
//  Created by Jakub Zimny on 05/12/2022.
//

import Foundation


struct Stack<T> {
    private var elements: [T] = []
    
    
    func push(_ element: T) {
        elements.append(element)
    }
    
    func pop() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
    }
    
    return popLast()
}

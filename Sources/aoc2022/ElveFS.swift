//
//  File.swift
//  
//
//  Created by Jakub Zimny on 08/12/2022.
//

import Foundation

protocol Nameable {
    var name: String {get}
}

final class ElveFile: Equatable, Nameable, CustomStringConvertible {
    var description: String {
        "\(size) \(name)"
    }
    
    static func == (lhs: ElveFile, rhs: ElveFile) -> Bool {
        lhs.name == rhs.name && lhs.size == rhs.size
    }
    
    private(set) var name: String
    private(set) var size: Int
    
    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}

final class ElveFSNode: Equatable, Nameable, CustomStringConvertible {
    var description: String {
        "\(name) -> files: \(files), dirs: \(directories) || size: \(size)"
    }
    
    static func == (lhs: ElveFSNode, rhs: ElveFSNode) -> Bool {
        lhs.name == rhs.name && lhs.files == rhs.files && lhs.directories == rhs.directories
    }
    
    var name: String
    private(set) var files: [ElveFile]
    private(set) var directories: [ElveFSNode]
    
    var size: Int {
        0 + files.reduce(0) { $0 + $1.size} + directories.reduce(0) { $0 + $1.size }
    }
    
    init(_ value: String) {
        self.name = value
        self.directories = []
        self.files = []
    }
    
    init(_ value: String, files: [ElveFile], directories:[ElveFSNode]) {
        self.name = value
        self.files = files
        self.directories = directories
    }
    
    func add(child: ElveFSNode) {
        directories.append(child)
    }
    
    func add(child: ElveFile) {
        files.append(child)
    }
    
    func find(_ name: String) -> ElveFSNode? {
        if self.name == name {
            return self
        }
        
        for dir in directories {
            if let match = dir.find(name) {
                return match
            }
        }
        
        return nil
    }
    
}

extension ElveFSNode: Sequence {
    typealias Element = ElveFSNode
    
    func makeIterator() -> Iterator {
        return Iterator(root: self)
    }
    
    struct Iterator: IteratorProtocol {
        var nodes: [(index:Int, node: ElveFSNode)]
        
        init(root: ElveFSNode) {
            nodes = [(0,root)]
        }
        
        mutating func next() -> Element? {
            defer {
                while let (index, node) = nodes.last, index >= node.directories.count {
                    nodes.removeLast()
                }
                
                if let (index, node) = nodes.popLast() {
                    nodes.append((index + 1, node))
                    nodes.append((0, node.directories[index]))
                }
            }
            
            return nodes.last?.node
        }
    }
}

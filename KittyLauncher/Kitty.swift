//
//  Kitten.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 21/12/2024.
//
import Foundation

class Kitty: Identifiable, Hashable, Equatable{
    
    private static let emojis: [String] = ["😹", "😻", "🙀", "😿", "🐱", "😽", "😸", "😼", "😾"]
    
    let emoji: String = Kitty.emojis.randomElement() ?? "🐞"
    
    public let process: KittyProcess
    
    let id:UUID = UUID()
    
    init(onTermination: (@Sendable (Process) -> Void)? = nil) throws {
        self.process = try KittyProcess.run(onTermination: onTermination)
    }
    
    // MARK: Equatable
    static func == (lhs: Kitty, rhs: Kitty) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

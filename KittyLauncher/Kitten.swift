//
//  Kitten.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 21/12/2024.
//
import Foundation

class Kitten: Identifiable, Hashable, Equatable{
    
    private static let emojis: [String] = ["😹", "😻", "🙀", "😿", "🐱", "😽", "😸", "😼", "😾"]

    let emoji: String = Kitten.emojis.randomElement() ?? "🐞"

    private let process: Process

    var pid: Int32 {
        get {
            return process.processIdentifier
        }
    }
    
    var isRunning:Bool {
        get {
            return process.isRunning
        }
    }
    var terminationHandler: ((Process) -> Void)? {
         get { process.terminationHandler }
         set { process.terminationHandler = newValue }
     }
    
    func terminate() {
        process.terminate()
    }
    
    func run() throws {
        try process.run()
    }

    init() {
        self.process = Process()
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        process.launchPath = "/bin/zsh"
        process.arguments = ["/opt/homebrew/bin/kitty", home]
    }
    
    static func == (lhs: Kitten, rhs: Kitten) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
          hasher.combine(id)
      }

}

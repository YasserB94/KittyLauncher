//
//  Kitten.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 21/12/2024.
//
import Foundation

class Kitten: Identifiable, Hashable, Equatable{
    
    private static let installPaths = [
        // Brew Silicon
         "/opt/homebrew/bin/kitty",
         // Brew Intel
         "/usr/local/bin/kitty",
         // MacPorts
         "/opt/local/bin/kitty",
         // App installed
         "/Applications/kitty.app/Contents/MacOS/kitty",
         "\(FileManager.default.homeDirectoryForCurrentUser.path)/Applications/kitty.app/Contents/MacOS/kitty",
         // System-wide
         "/usr/bin/kitty",
         // Common paths
         "/usr/local/bin/kitty",
         "\(FileManager.default.homeDirectoryForCurrentUser.path)/kitty/bin/kitty",
         "\(FileManager.default.homeDirectoryForCurrentUser.path)/bin/kitty",
         "/opt/kitty/bin/kitty"
    ]
    
    public static func getKittyPath() -> String {
        for path in Kitten.installPaths {
            if FileManager.default.fileExists(atPath: path) &&
                FileManager.default.isExecutableFile(atPath: path)
            {
             return path
            }
        }
        // FIXME: Handle errors
        fatalError("Failed to resolve Kitty executable")
    }
    
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
    
    
    init(onTermination: (@Sendable (Process) -> Void)? = nil) throws {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        self.process = try Process.run(
            URL(filePath:ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/sh"),
            arguments:[Kitten.getKittyPath(), home] ,
            terminationHandler: onTermination
        )
    }

    func terminate() {
        process.terminate()
    }
    
    // MARK: Equatable
    static func == (lhs: Kitten, rhs: Kitten) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: Hashable
    func hash(into hasher: inout Hasher) {
          hasher.combine(id)
    }
}

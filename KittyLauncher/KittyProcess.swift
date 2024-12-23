//
//  KittyProcess.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 22/12/2024.
//

import Foundation

class KittyProcess {
    private static let executablePaths = [
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
    
    public static func getKittyExecutablePath() throws -> String {
        let fm = FileManager.default
        for p in executablePaths {
            if(
                fm.fileExists(atPath: p) &&
                fm.isExecutableFile(atPath: p))
            {
                return p
            }
        }
        throw KittyProcessError.EXECUTABLE_NOT_FOUND
    }
    
    private static var userShell:URL {
        guard let shellPath = ProcessInfo.processInfo.environment["SHELL"],
              !shellPath.isEmpty else
        {
            return URL(filePath: "/bin/sh")
        }
        return URL(filePath: shellPath)
    }
    
    
    @discardableResult
    public static func run(onTermination: (@Sendable (Process) -> Void)? = nil) throws -> KittyProcess {
        let kittyPath = try getKittyExecutablePath()
        
        let process = Process()
        process.executableURL = userShell
        process.arguments = [kittyPath]
        process.terminationHandler = onTermination
        
        let k = KittyProcess(process:process)
        
        try process.run()
        return k
    }
    
    private let process:Process
    
    init(process: Process) {
        self.process = process
    }
    
    func terminate() {
        self.process.terminate()
    }
    
    var isRunning:Bool{
        get { self.process.isRunning }
    }
    
    var pid:Int32 {
        get { self.process.processIdentifier }
    }
    
}

// MARK: KittyProcessError

enum KittyProcessError:Error {
    case EXECUTABLE_NOT_FOUND
}

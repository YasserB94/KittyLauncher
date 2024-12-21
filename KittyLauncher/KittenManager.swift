//
//  KittenManager.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 21/12/2024.
//

import Foundation

class KittenManager: ObservableObject {
    @Published var kittens: Set<Kitten> = []

    public func newKitty() {
        do {
            
            let k = try Kitten(shell:URL(filePath:"/bin/zsh")) { _ in
            Task { @MainActor in
              self.kittens = self.kittens.filter { $0.isRunning }
              }
            }
            self.kittens.insert(k)
        } catch {
            // FIXME: Handle Errors
            fatalError("Failed to run kitten : \(error)")
        }
    }

    public func kill(kitten: Kitten) {
        kitten.terminate()
        self.kittens.remove(kitten)
    }
    
    public func quitAll() {
        kittens.forEach { kitten in
            kitten.terminate()
            self.kittens.remove(kitten)
        }
    }
    
}

//
//  KittenManager.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 21/12/2024.
//

import Foundation

class KittyManager: ObservableObject {
    @Published var kittens: Set<Kitty> = []
    
    var kittenUpdateTimer:Timer?
    
    public func newKitty() -> Void {
        do {
            let k = try Kitty(
                onTermination: { _ in
                    Task { @MainActor in
                        self.kittens = self.kittens
                            .filter({ $0.process.isRunning })
                    }
                }
            )
            self.kittens.insert(k)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func kill(kitten: Kitty) {
        kitten.process.terminate()
        self.kittens.remove(kitten)
    }
    
    public func quitAll() {
        kittens.forEach { kitten in
            kitten.process.terminate()
        }
        self.kittens.removeAll()
    }
}

//
//  KittyLauncherApp.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 20/12/2024.
//

import SwiftUI

@main
struct KittyLauncherApp: App {
    @StateObject private var manager:KittenManager = KittenManager()
    
    var body: some Scene {
        MenuBarExtra {
            Button("🦁 New Kitty", systemImage: "plus.rectangle",action:self.manager.newKitty)
            Divider()
            ForEach(Array(manager.kittens),id:\.self) { kitten in
                Menu("\(kitten.emoji) \(kitten.pid)"){
                    Button(action: {
                        manager.kill(kitten: kitten)
                    }, label: {
                        Text("💀 Kill ")
                    })
                }
            }
            Divider()
            if(manager.kittens.count > 0) {
                Button("🪦 Killall ",systemImage: "xmark.circle.fill"){
                    manager.quitAll()
                }
            }else {
                Text("🥺 No kittens ")
                Button("Quit", systemImage: "xmark.circle.fill") {
                    NSApplication.shared.terminate(nil)
                }
            }
        } label: {
            Image("kitty")
                .resizable()
                .scaledToFit()
                .frame(height:20)
        }
    }

}

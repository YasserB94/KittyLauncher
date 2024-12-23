//
//  KittyLauncherApp.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 20/12/2024.
//

import SwiftUI

@main
struct KittyLauncherApp: App {
    @StateObject private var manager:KittyManager = KittyManager()
    
    var body: some Scene {
        MenuBarExtra {
            VStack{
                newKittyButton
                Divider()
                ForEach(Array(manager.kittens),id:\.self) { kitten in
                    KittenMenuView(kitten: kitten)
                }
                Divider()
                kittenCountLabel
                Divider()
                if(manager.kittens.count > 0) {
                    killAlllButton
                } else {
                    quitButton
                }
            }
        } label: {
            menuBarLabel
        }
        .menuBarExtraStyle(.window)
    }
    
    var menuBarLabel:some View {
        Image("kitty")
            .resizable()
            .scaledToFit()
            .frame(height:20)
    }
    
    var kittenCountLabel:some View {
        Text(
            manager.kittens.count > 0 ?
            "👵 \(manager.kittens.count) kittens" :
                "🥺 No kittens"
        )
    }
    
    var newKittyButton:some View {
        Button(
            "🦁 New Kitty",
            systemImage: "plus.rectangle",
            action: {
                manager.newKitty()
            }
        )
    }
    
    var quitButton:some View {
        Button(
            "Quit",
            systemImage: "xmark.circle.fill"
        ) {
            NSApplication.shared.terminate(nil)
        }
    }
    
    var killAlllButton:some View {
        Button(
            "🪦 Killall",
            systemImage: "xmark.circle.fill"
        ){
            manager.quitAll()
        }
    }
}

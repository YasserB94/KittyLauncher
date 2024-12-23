//
//  KittenMenuView.swift
//  KittyLauncher
//
//  Created by Yasser Bal on 23/12/2024.
//

import SwiftUI

struct KittenMenuView: View {
    let kitten:Kitty
    
    var body: some View {
        Menu("\(kitten.emoji) \(kitten.process.pid)"){
            Button(action: {
                kitten.process.terminate()
            }, label: {
                Text("💀 Kill ")
            })
        }

    }
}


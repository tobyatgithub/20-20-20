//
//  MessageView.swift
//  20-20-20
//
//  Created by Toby Huang on 2/11/24.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @State private var counter = 20
    
    var body: some View {
        VStack {
            Text("Your custom message here!")
                .font(.headline)
            
            Text("\(counter) seconds")
                .font(.largeTitle)
                .padding()
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        if self.counter > 0 {
                            self.counter -= 1
                        } else {
                            timer.invalidate()
                        }
                    }
                }
        }
    }
}


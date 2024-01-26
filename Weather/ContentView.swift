//
//  ContentView.swift
//  Weather
//
//  Created by Amir on 1/22/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    let portionOfArcToGetFill = 0.7
    var body: some View {
        VStack {
            ZStack{
                dashView(dashPoints: viewModel.dashPoints)
                arcView(fillPoints: viewModel.arcPoints)
                if let loc = viewModel.arcPoints.last {
                    sunView(point: loc)
                }
            }
        Button("Current temperature", action: {
            viewModel.startAnimating(percent: portionOfArcToGetFill)
        })
        }
        .padding()
    }
}

func dashView(dashPoints: [CGPoint]) -> some View {
    Path { path in
        for item in dashPoints {
            path.move(to: .zero)
            path.addEllipse(in: CGRect(origin: item, size: CGSize(width: 1, height: 1)))
        }
    }
    .fill(.gray)
}

func arcView(fillPoints: [CGPoint]) -> some View {
    Path { path in
        for item in fillPoints {
            path.move(to: .zero)
            path.addEllipse(in: CGRect(origin: item, size: CGSize(width: 2, height: 2)))
        }
    }
    .fill(.purple)
}

func sunView(point: CGPoint) -> some View {
    Image(systemName: "sun.max.fill")
        .foregroundStyle(.yellow)
        .position(point)
}

#Preview {
    ContentView()
}

//
//  LoadingView.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 18/03/2025.
//

import SwiftUI

struct LoadingView: View {
    var showProgress: Bool = true
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()
            if showProgress {
                VStack(spacing: 20) {
                    ProgressView()
                    Text("Loading...")
                }
                .background {
                    RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: 200, height: 200)
                }
                .offset(y: -70)
            }
        }
    }
}

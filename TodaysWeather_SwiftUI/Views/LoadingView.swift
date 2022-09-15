//
//  LodingView.swift
//  TodaysWeather_SwiftUI
//
//  Created by 서녕 on 2022/09/15.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool
    @State var imageLocation: CGFloat = -100
    private let iconWidth: CGFloat = 100
    private let iconHeight: CGFloat = 100
    
    var body: some View {
        VStack {
            lconImageView()
            progressView(task: loadingViewTask)
            titleView()
        }
    }
}

// MARK: - Displaying View
extension LoadingView {
    private func lconImageView() -> some View {
        ZStack(alignment: .top) {
            sunnyImage()
            cloudImage()
        }
    }
    
    private func progressView(task: @escaping @Sendable () async -> Void) -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(2)
            .task(task)
    }
    
    private func titleView() -> some View {
        Image("title")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250)
            .padding()
    }
}

// MARK: - Animation Image
extension LoadingView {
    private func sunnyImage() -> some View {
        HStack {
            Image("sun")
                .resizable()
                .frame(width: iconWidth, height: iconHeight)
                .frame(maxHeight: .ulpOfOne)
                .offset(x: imageLocation)
                .transition(.move(edge: .trailing))
                .onAppear{
                    let baseAnimation = Animation.easeOut.speed(0.2)
                    let repeated = baseAnimation.repeatForever(autoreverses: false)
                    withAnimation(repeated) {
                        imageLocation += UIScreen.main.bounds.width + iconWidth
                    }
                }
            Spacer()
        }
    }
    
    private func cloudImage() -> some View {
        Image("cloud")
            .resizable()
            .frame(width: iconWidth + 50, height: iconHeight + 50)
    }
}

// MARK: - LoadingView Task
extension LoadingView {
    @Sendable
    private func loadingViewTask() async {
        try? await Task.sleep(nanoseconds: 2_500_000_000)
        self.isLoading = false
    }
}

struct LodingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true))
    }
}

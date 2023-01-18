//
//  ContentView.swift
//  SwiftUIAsyncImages
//
//  Created by Abdelrahman Elsayed on 1/17/23.
//

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self.imageModifier()
            .foregroundColor(.purple)
            .frame(maxWidth: 180)
            .padding()
    }
}

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.pn"
    var body: some View {
        
        //MARK: - 1- Basic
//        AsyncImage(url: URL(string: imageURL))
        
        //MARK: - 2- Scaling the image
        // scaling is basically making the image change in size, the bigger the scale, the smaller the image.
//        AsyncImage(url: URL(string: imageURL), scale: 3)
        
        //MARK: - 3- PlaceHolder
        // adding placeholder that showes before fetching the image itself
//        AsyncImage(url: URL(string: imageURL)) { image in
//            image.imageModifier()
//        } placeholder: {
//            Image(systemName: "photo.circle.fill").iconModifier()
//        }
        
        //MARK: - 4- Phasing
        // displaying a separate image for loading, failing, and success.
//        AsyncImage(url: URL(string: imageURL)) { phase in
//            if let image = phase.image {
//                image.imageModifier()
//            } else if phase.error != nil {
//                Image(systemName: "ant.circle.fill").iconModifier()
//            } else {
//                Image(systemName: "photo.circle.fill").iconModifier()
//            }
//        }.padding(40)
        
        //MARK: - Animation
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image.imageModifier()
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

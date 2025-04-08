//
//  HomeView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 17/03/25.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    var heroTextTitle = Constants.testTitleURL
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack {
                    KFImage.url(URL(string: heroTextTitle))
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .clear, location: 0.7),
                                    Gradient.Stop(color: .gradient, location: 1)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                        .frame(width: geo.size.width, height: geo.size.height * 0.85)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Text(Constants.playString)
                                .customButton()
                        }
                        
                        Button {
                            
                        } label: {
                            Text(Constants.downloadString)
                                .customButton()
                        }
                    }
                    
                    HorizontalListView(header: Constants.nowPlayingString, movies: $viewModel.nowPlayingMovies.results)
                    HorizontalListView(header: Constants.popularString, movies: $viewModel.popular.results)
                    HorizontalListView(header: Constants.topRatedString, movies: $viewModel.topRated.results)
                    HorizontalListView(header: Constants.upcomingString, movies: $viewModel.upcoming.results)
                }
            }
        }
        .task {
            await refreshData()
        }
    }
    
    func refreshData() async {
        viewModel.getMovieList(.nowPlaying)
        viewModel.getMovieList(.popular)
        viewModel.getMovieList(.topRated)
        viewModel.getMovieList(.upcoming)
    }
}

#Preview {
    HomeView()
}

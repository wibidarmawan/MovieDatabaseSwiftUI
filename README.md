# MovieDatabaseSwiftUI

A modern iOS app built with SwiftUI that allows users to browse and discover movies using The Movie Database (TMDB) API. The app showcases the latest movies, top-rated films, and provides detailed information about each movie.

## Features

- 🎬 Browse Now Playing and Top Rated movies
- 🔍 Search functionality with real-time results
- ❤️ Like and save favorite movies
- 🖼️ Zoomable movie posters and backdrops
- 👥 View movie cast information
- 📱 Native iOS design following Apple's Human Interface Guidelines
- 🌓 Supports both light and dark mode

## Technologies Used

- SwiftUI
- Combine
- TMDB API
- Kingfisher for image loading and caching
- Swift's async/await for network calls
- UserDefaults for local storage

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- TMDB API Key

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/MovieDatabaseSwiftUI.git
```

2. Navigate to the project directory:
```bash
cd MovieDatabaseSwiftUI
```

3. Create a `Config.xcconfig` file based on the example:
```bash
cp Config.example.xcconfig Config.xcconfig
```

4. Edit `Config.xcconfig` and add your TMDB API key:
```xcconfig
TMDB_API_KEY = your_api_key_here
```

5. Open `MovieDatabaseSwiftUI.xcodeproj` in Xcode

6. Build and run the project
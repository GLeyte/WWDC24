import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var stackPath = PathType()
        
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stackPath.path) {
                ContentView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(stackPath)
            .tint(Color.accentColor)
        }
    }
}

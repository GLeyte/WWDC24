import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var stackPath = PathType()
    let accentColor = Color(red: 57/255, green: 255/255, blue: 20/255)
        
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stackPath.path) {
                ParametricCurvesView()
            }
            .environmentObject(stackPath)
            .tint(accentColor)
        }
    }
}

//
//  ThisHomeApp.swift
//  ThisHome
//
//  Created by Joshua Collins on 12/3/21.
//

import SwiftUI

@main
struct ThisHomeApp: App {
    @StateObject private var persistedCalories = PersistedCalories()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Home().tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                CalorieCounter(calories: $persistedCalories.calories) {
                    PersistedCalories.save(cals: persistedCalories.calories) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }.onAppear {
                    PersistedCalories.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let cals):
                            persistedCalories.calories = cals
                        }
                    }
                }.tabItem {
                    Image(systemName: "heart.circle")
                    Text("Calorie Counter")
                }
            }
        }
    }
}

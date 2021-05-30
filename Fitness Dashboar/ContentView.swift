//
//  ContentView.swift
//  Fitness Dashboar
//
//  Created by Neha on 22/05/21.
//

import SwiftUI

struct ContentView: View {
    @State var selected = 0
    var colors = [Color("Color1"), Color("Color")]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Hello, Neha")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                //Bar Charts...
                VStack(alignment: .leading, spacing: 25) {
                    Text("Daily Workout in Hrs")
                        .font(.system(size: 22))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 15) {
                        ForEach(workout_Data) { work in
                            VStack {
                                VStack {
                                    Spacer(minLength: 0)
                                    if selected == work.id {
                                        Text(getHrs(value: work.workout_in_min))
                                            .foregroundColor(Color("Color"))
                                            .padding(.bottom, 5)
                                    }
                                    
                                    RoundedShape()
                                        .fill(LinearGradient(gradient: .init(colors: selected == work.id ? colors : [Color.white.opacity(0.06)]), startPoint: .top, endPoint: .bottom))
                                        .frame(height: getHeight(value: work.workout_in_min))
                                }
                                .frame(height: 180)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        selected = work.id
                                    }
                                }
                                
                                Text(work.day)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(10)
                .padding()
                
                HStack {
                    Text("Statistics")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                //Stats
                
                LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(stats_Data) { stats in
                            VStack(spacing: 22) {
                               HStack {
                                Text(stats.title)
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer(minLength: 0)
                               }
                                ZStack {
                                    Circle()
                                        .trim(from: 0, to: 1)
                                        .stroke(stats.color.opacity(0.05), lineWidth: 10)
                                        .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                    Circle()
                                        .trim(from: 0, to: stats.currentDate/stats.goal)
                                        .stroke(stats.color, lineWidth: 10)
                                        .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                    Text(getPwrcent(current: stats.currentDate, goal: stats.goal))
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Color"))
                                    }
                                
                            }
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(10)
                    }
                  
                }
                .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
    }
    
    // Calculing Hrs for height..
    func getHeight(value: CGFloat) -> CGFloat {
        return CGFloat( value / 1440 ) * 200
    }
    
    func getHrs(value: CGFloat) -> String {
        let hrs = value / 60
        return String(format: "%.1f", hrs)
    }
    
    func getPwrcent(current: CGFloat, goal:CGFloat) -> String {
        let x = current / goal
        return String(format: "%.1f", x)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Sample Data

struct Daily: Identifiable {
    var id: Int
    var day: String
    var workout_in_min: CGFloat
}


var workout_Data = [
    Daily(id: 0, day: "Day 1", workout_in_min: 490),
    Daily(id: 1, day: "Day 2", workout_in_min: 880),
    Daily(id: 2, day: "Day 3", workout_in_min: 250),
    Daily(id: 3, day: "Day 4", workout_in_min: 700),
    Daily(id: 4, day: "Day 5", workout_in_min: 550),
    Daily(id: 5, day: "Day 6", workout_in_min: 1000),
    Daily(id: 6, day: "Day 7", workout_in_min: 320)
]

struct RoundedShape : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        return Path(path.cgPath)
    }
}


struct Stats: Identifiable {
    var id: Int
    var title: String
    var currentDate: CGFloat
    var goal: CGFloat
    var color: Color
}



var stats_Data = [
    Stats(id: 0, title: "Running", currentDate: 6.8, goal: 15, color: Color("running")),
    Stats(id: 1, title: "Sleeping", currentDate: 6.2, goal: 10, color: Color("sleep")),
    Stats(id: 2, title: "Water", currentDate: 6.5, goal: 8, color: Color("water")),
    Stats(id: 3, title: "Cycling", currentDate: 12.5, goal: 25, color: Color("cycle")),
    Stats(id: 4, title: "Steps", currentDate: 10889.0, goal: 30000.0, color: Color("steps")),
    Stats(id: 5, title: "Energy Burn", currentDate: 785.0, goal: 3000, color: Color("energy"))
]

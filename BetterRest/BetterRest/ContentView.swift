//
//  ContentView.swift
//  BetterRest
//
//  Created by Sebastian Tleye on 13/02/2024.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var sleepAmount = 0.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1

    @State private var calculatedBedtime = ""

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    private var range = stride(from: 4, through: 12, by: 0.25)

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker("Please enter a time", 
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                Section {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12,
                            step: 0.24)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                Section {
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)",
//                            value: $coffeeAmount, in: 1...20)
                    Picker("Daily Coffee Intake", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text(($0 == 1) ? "\($0) cup" : "\($0) cups")
                        }
                    }.onSubmit {
                        calculateBedtime()
                    }
                } //header: {
                    //Text("Daily coffee intake")
                      //  .font(.headline)
                //}
                Section {
                    HStack {
                        Label("Bedtime", systemImage: "bed.double")
                        Spacer()
                        Text(calculatedBedtime)
                            .font(.largeTitle)
                            .foregroundStyle(Color.blue)
                    }
                }
            }
            .navigationTitle("BetterRest")
            .onChange(of: sleepAmount) {
                calculateBedtime()
            }
            .onChange(of: wakeUp) {
                calculateBedtime()
            }
            .onChange(of: coffeeAmount) {
                calculateBedtime()
            }
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }

    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute],
                                                             from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            calculatedBedtime = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            calculatedBedtime = "???"
        }
    }
    
//    var body: some View {
//        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 1...4, step: 0.25)
//        DatePicker("Please select a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
//            .labelsHidden()
//        DatePicker("Please select a date", selection: $wakeUp, in: Date.now...)
//            .labelsHidden()
//        Text(Date.now, format: .dateTime.hour().minute())
//        Text(Date.now, format: .dateTime.day().month().year())
//        Text(Date.now.formatted(date: .long, time: .shortened))
//    }
    
//    private func exampleDates() {
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
//        
//        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
//    }

}

#Preview {
    ContentView()
}

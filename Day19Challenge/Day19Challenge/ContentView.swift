//
//  ContentView.swift
//  Day19Challenge
//
//  Created by Sebastian Tleye on 04/02/2024.
//

import SwiftUI

struct Temperature {

    enum Unit: String, CaseIterable {
        case celcius = "°C"
        case fahrenheit = "°F"
        case kelvin = "°K"
    }

    var value: Double
    var unit: Unit
    
    func convertToCelcius() -> Temperature {
        switch self.unit {
        case .celcius:
            return self
        case .fahrenheit:
            return Temperature(value: (value - 32) * 5/9, unit: .celcius)
        case .kelvin:
            return Temperature(value: value - 273.15, unit: .celcius)
        }
    }
    
    func convertTo(_ unit: Unit) -> Temperature {
        switch unit {
        case .celcius:
            return self.convertToCelcius()
        case .fahrenheit:
            let temperature = self.convertToCelcius()
            return Temperature(value: (temperature.value * 9/5) + 32, unit: .fahrenheit)
        case .kelvin:
            let temperature = self.convertToCelcius()
            return Temperature(value: temperature.value + 273.15, unit: .kelvin)
        }
    }
}

struct ContentView: View {

    @State var inputUnit: Temperature.Unit = .celcius
    @State var outputUnit: Temperature.Unit = .fahrenheit
    @State var inputTemperature = 0.0

    var outputTemperature: Temperature {
        let temperature = Temperature(value: inputTemperature, unit: inputUnit)
        return temperature.convertTo(outputUnit)
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter temperature", 
                              value: $inputTemperature,
                              format: .number)
                        .keyboardType(.numberPad)
                }
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(Temperature.Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("INPUT UNIT")
                }
                .navigationTitle("Unit Conversion")
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(Temperature.Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("OUTPUT UNIT")
                }
                Section {
                    Text("\(outputTemperature.value, specifier: "%.2f") \(outputTemperature.unit.rawValue)")
                } header: {
                    Text("Temperature")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

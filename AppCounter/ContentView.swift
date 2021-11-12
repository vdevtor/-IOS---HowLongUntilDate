//
//  ContentView.swift
//  AppCounter
//
//  Created by Vitor on 11/7/21.
//

import SwiftUI

class Counter  : ObservableObject   {
    @Published var segundos = 0
    @Published var dias = 0
    @Published var horas = 0
    @Published var minutos = 0
    var selectedDate = Date()
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true,block: {timer in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: Date())
            
            let selectedComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.selectedDate)
            
            
            
            let currentDate = calendar.date(from: components)
            var eventDateComponets = DateComponents()
            eventDateComponets.year = selectedComponents.year
            eventDateComponets.month = selectedComponents.month
            eventDateComponets.day = selectedComponents.day
            eventDateComponets.hour = selectedComponents.hour
            eventDateComponets.minute = selectedComponents.minute
            eventDateComponets.second = selectedComponents.second
            
            let eventDante = calendar.date(from: eventDateComponets)
            
            var timeLeft =  calendar.dateComponents([.day,.hour,.minute,.second], from: currentDate!, to: eventDante!)
            
            if(timeLeft.second! >= 0){
                self.dias = timeLeft.day ?? 0
                self.segundos = timeLeft.second ?? 0
                self.minutos = timeLeft.minute ?? 0
                self.horas = timeLeft.hour ?? 0
            }
            
        })
    }
}

struct ContentView: View {
    @StateObject var counter = Counter()
    var body: some View {
        VStack{
            DatePicker(selection: $counter.selectedDate, in: Date()...,
                       displayedComponents: [.hourAndMinute,.date]) {
                Text("Selecione a data:")
            }
            HStack{
                Text("\(counter.dias) Dias")
                Text("\(counter.horas) Horas")
                Text("\(counter.minutos) min")
                Text("\(counter.segundos) seg")
            }
            .padding()
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

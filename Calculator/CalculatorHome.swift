//
//  ContentView.swift
//  Calculator
//
//  Created by Adityaa Mehra on 04/07/21.
//

import SwiftUI

// Custom colours
let darkerGray = Color(CGColor(gray: 0.1, alpha: 1))
let darkGray = Color(CGColor(gray: 0.3, alpha: 1))

struct CalculatorHome: View {
    @EnvironmentObject var calculator:Calculator
    var body: some View {
        GeometryReader {geo in
            VStack(alignment: .trailing , spacing: 0){
                
                Spacer()
                
                // Display the current value
                Text(calculator.displayValue).foregroundColor(.white).font(.system(size: 40)).lineLimit(1).padding(.leading , 20).padding(.trailing , 20)
                VStack(spacing: 10){
                    CalculatorRow(labels: ["CE" , "" , "" , String("\u{00f7}")], colors: [darkGray , darkGray , darkGray , .orange])
                    CalculatorRow(labels: ["7" , "8" , "9" , String("\u{00d7}")])
                    CalculatorRow(labels: ["4" , "5" , "6" , "-"])
                    CalculatorRow(labels: ["1" , "2" , "3" , "+"])
                    CalculatorRow(labels: ["0" , "." , "" , "="])
                }.padding().frame(height: geo.size.height * 0.7)
                
            }.background(darkerGray).ignoresSafeArea()
        }
    }
}

struct CalculatorHome_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorHome().environmentObject(Calculator())
    }
}

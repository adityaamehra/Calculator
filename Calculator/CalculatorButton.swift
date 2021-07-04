//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by Adityaa Mehra on 04/07/21.
//

import SwiftUI

struct CalculatorButton: View {
    @EnvironmentObject var calculator: Calculator
    var label:String
    var color:Color
    var body: some View {
        Button(action: {
            // Inform model of button press
            calculator.buttonPressed(label: label)
        }, label: {
            ZStack(alignment: .center){
                Circle().fill(color)
                Text(label).font(.title)
            }
        }).accentColor(.white)
    }
}

struct CalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(label: "1", color: .gray).previewLayout(.fixed(width: 100, height: 100)).environmentObject(Calculator())
    }
}

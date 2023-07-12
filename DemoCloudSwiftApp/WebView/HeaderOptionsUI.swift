//
//  HeaderOptionsUI.swift
//  DemoCloudSwiftApp
//
//  Created by Daniel Diaz on 10/07/23.
//

import SwiftUI

struct HeaderOptionsUI: View {
    let title: String
    let onTapSendToken: () -> Void
    let onTapTriggerWebviewEvent: () -> Void


    @Binding var isToggled: Bool
    @Binding var isInit: Bool
    @Binding var inputValue: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)

            Toggle(isOn: $isToggled) {
                Text(isToggled ? "Stage" : "UAT")
            }
            .scaleEffect(0.9)
    
            TextField("Token", text: $inputValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

            HStack {
                Button(action: {
                    onTapSendToken()
                }, label: {
                    HStack {
                        Image(systemName: "paperplane.fill")
                            .font(.body)
                        Text(isInit ? "Send Auth Token" : "Add url Token")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    onTapTriggerWebviewEvent()
                }, label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(.body)
                        Text("Opt in event")
                    }
                })
            }
        }
        .padding()
    }
}

struct HeaderOptionsUI_Previews: PreviewProvider {
    static var previews: some View {
        HeaderOptionsUI(title: "Menu", onTapSendToken: {
            print("hi")
        }, onTapTriggerWebviewEvent: {
            print("hi")
        }, isToggled: .constant(true),
                        isInit: .constant(false),
        inputValue: .constant("")
        )
    }
}

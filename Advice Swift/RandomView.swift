//
//  RandomView.swift
//  Advice Swift
//
//  Created by Tony Gultom on 19/08/24.
//

import SwiftUI

struct RandomView: View {
    
    @State private var loading: Bool = true
    @State private var adviceData: Advice?
    
    func getInitialData() {
        RequestData.getData(requestUrl: "https://api.adviceslip.com/advice", onSuccess: {(decodedData: Advice) in self.adviceData = decodedData} , onFailed:   {Error in print("error in here \(Error)")}, onLoading: {self.loading = true}, onFinally: {self.loading = false}, requestMethod: RequestMethod.get)
    }
    
    
    var body: some View {
        ZStack {
            Color.grayishBlue
                .edgesIgnoringSafeArea(.top)
            if(loading) {
                ProgressView()
            } else {
                if(adviceData != nil) {
                        GeometryReader {
                            geometry in
                            ZStack {
                                VStack {
                                    Text("Number: #\(String(adviceData!.slip.id))").multilineTextAlignment(.center)
                                    Text(adviceData!.slip.advice).multilineTextAlignment(.center)
                                    
                                }.padding().background(.lightCyan).foregroundStyle(.white).frame(width: geometry.size.width * 0.8).clipShape(.rect(cornerRadius: 10.0))
                                
                                Image(.iconDice).padding().background(.white).clipShape(.circle).offset( y: geometry.size.height * 0.12).onTapGesture {
                                    getInitialData()
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                        }
                 
                } else {
                    Text("No Advice Found!")
                    
                }
            }
        }.onAppear(perform: getInitialData)
        
        
    }
}

#Preview {
    RandomView()
}

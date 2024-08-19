//
//  AdviceDetail.swift
//  Advice Swift
//
//  Created by Tony Gultom on 19/08/24.
//

import SwiftUI

struct AdviceDetail: View {
    var id: Int
    @State private var advice: Advice?
    @State private var loading: Bool = false;
    
    func getInitialData() {
        RequestData.getData(requestUrl: "https://api.adviceslip.com/advice/\(id)", onSuccess: {(decodedData: Advice) in self.advice = decodedData} , onFailed:   {Error in print("error in here \(Error)")}, onLoading: {self.loading = true}, onFinally: {self.loading = false}, requestMethod: RequestMethod.get)
    }
    
    var body: some View {
        ZStack {
            Color.grayishBlue.ignoresSafeArea(.all)
            if(loading) {
                ProgressView()
               
            } else {
                VStack {
                        if(advice != nil) {
                            Text("Number: #\(String(advice!.slip.id))").multilineTextAlignment(.center)
                            Text(advice!.slip.advice).multilineTextAlignment(.center)
                        } else {
                            Text("Something is wrong, please try again!")
                            Button("Try Again"){
                                getInitialData()
                            }
                        }
                }.padding().background(.lightCyan).foregroundStyle(.white).clipShape(.rect(cornerRadius: 10.0))
            }
           
          
        }.onAppear(perform: getInitialData).toolbar(.hidden, for: .tabBar)
    }
}

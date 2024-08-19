//
//  SearchList.swift
//  Advice Swift
//
//  Created by Tony Gultom on 19/08/24.
//

import Foundation


class SlipsList: Codable, Identifiable {
    var id: Int
    var advice: String
    var date: String
}

class AdviceList: Codable {
    var total_results: String
    var query: String
    var slips: [SlipsList]
}

//
//  TVShowModel.swift
//  SaveState
//
//  Created by LanceMacBookPro on 7/24/21.
//

import UIKit

final class TVShowModel {
    
    var postId: String?
    var showName: String?
    var liked: Bool?
    
    init(postId: String, showName: String) {
        self.postId = postId
        self.showName = showName
    }
}

extension TVShowModel {
    
    static func createTVShowModels() -> [TVShowModel] {
        
        var arr = [TVShowModel]()
        
        let familyGuy = TVShowModel(postId: "0", showName: "Family Guy")
        arr.append(familyGuy)
        
        let kinkyBoots = TVShowModel(postId: "1", showName: "Kinky Boots")
        arr.append(kinkyBoots)
        
        let seinfeld = TVShowModel(postId: "2", showName: "Seinfeld")
        arr.append(seinfeld)
        
        let crub = TVShowModel(postId: "3", showName: "Crub")
        arr.append(crub)
        
        let theSimpsons = TVShowModel(postId: "4", showName: "The Simpsons")
        arr.append(theSimpsons)
        
        let kingOfTheHill = TVShowModel(postId: "5", showName: "King of The Hill")
        arr.append(kingOfTheHill)
        
        let gameOfThrones = TVShowModel(postId: "6", showName: "Game of Thrones")
        arr.append(gameOfThrones)
        
        let martin = TVShowModel(postId: "7", showName: "Martin")
        arr.append(martin)
        
        let strangerThings = TVShowModel(postId: "8", showName: "Stranger Things")
        arr.append(strangerThings)
        
        let theOzarks = TVShowModel(postId: "9", showName: "The Ozarks")
        arr.append(theOzarks)
        
        let vikings = TVShowModel(postId: "10", showName: "Vikings")
        arr.append(vikings)
        
        let theWalkingDead = TVShowModel(postId: "11", showName: "The Walking Dead")
        arr.append(theWalkingDead)
        
        let sopranos = TVShowModel(postId: "12", showName: "Sopranos")
        arr.append(sopranos)
        
        let theWire = TVShowModel(postId: "13", showName: "The Wire")
        arr.append(theWire)
        
        let umbrellaAcademy = TVShowModel(postId: "14", showName: "Umbrella Academy")
        arr.append(umbrellaAcademy)
        
        return arr
    }
}

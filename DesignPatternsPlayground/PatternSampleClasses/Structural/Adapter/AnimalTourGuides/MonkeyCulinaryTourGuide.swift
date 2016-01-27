//
//  MonkeyCulinaryTourGuide.swift
//  DesignPatternsPlayground
//
//  Created by Ricardo Pramana Suranta on 1/14/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import Foundation

class MonkeyCulinaryTourGuide: AnimalCulinaryTourGuide {
    
    var tourGuideIcon: String {
        return "🐵"
    }
    
    var culinaryChefIcon: String {
        return "🐵🍌"
    }
    
    private var chef: MonkeyChef
    
    init(chef: MonkeyChef) {
        self.chef = chef
    }
    
    func requestDrinks(closure: AnimalCulinaryRequestClosure) {
        var dialogue = basicDialogue()

        dialogue.tourGuideDialogue = "Chef, may I have a drink for this good man, ooh aah?"
        dialogue.tourChefDialogue = chef.tropicalJuice()
        
        closure(dialogue)
    }
    
    func requestFood(closure: AnimalCulinaryRequestClosure) {
        
        var dialogue = basicDialogue()
        
        dialogue.tourGuideDialogue = "Chef, may I have a dish for this good man, ooh aah?"
        dialogue.tourChefDialogue = getFoodFromChef()
        
        closure(dialogue)
    }
    
    // MARK: Private methods
    
    private func basicDialogue() -> AnimalCulinaryTourDialogue {
        var dialogue = AnimalCulinaryTourDialogue()
        
        dialogue.tourGuideName = "Ganteng(🐵)"
        dialogue.tourChefName = "Tampan(🐵🍌)"
        
        return dialogue
    }
    
    private func getFoodFromChef() -> String {
        
        let randomInt = random() % 2
        
        if randomInt > 0 {
            return chef.apple()
        } else {
            return chef.banana()
        }
    }
}
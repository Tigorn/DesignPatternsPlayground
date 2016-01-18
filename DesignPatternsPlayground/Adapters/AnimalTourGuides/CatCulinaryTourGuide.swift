//
//  CatCulinaryTourGuide.swift
//  DesignPatternsPlayground
//
//  Created by Ricardo Pramana Suranta on 1/14/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import Foundation

class CatCulinaryTourGuide: AnimalCulinaryTourGuide {
    
    var tourGuideIcon: String {
        return "😸"
    }
    
    var culinaryChefIcon: String {
        return "🐱🍼"
    }
    
    private var chef: CatChef
    
    init(chef: CatChef) {
        self.chef = chef
    }
    
    func requestDrinks(closure: AnimalCulinaryRequestClosure) {
        closure(chef.catMilk())
    }
    
    func requestFood(closure: AnimalCulinaryRequestClosure) {
        let randomNumber = random() % 2
        
        var food = ""
        
        if randomNumber > 0 {
            food = chef.grilledHamster()
        } else {
            food = chef.roastedMice()
        }
        
        closure(food)
    }
    
}
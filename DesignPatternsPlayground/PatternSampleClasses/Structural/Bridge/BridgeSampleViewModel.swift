//
//  BridgeSampleViewModel.swift
//  DesignPatternsPlayground
//
//  Created by Ricardo Pramana Suranta on 1/20/16.
//  Copyright © 2016 Ricardo Pramana Suranta. All rights reserved.
//

import Foundation
import JamesBondTools

protocol BridgeSampleViewModelDelegate: class {
    
    /// Executed when `viewModel`'s `selectedTerrain` property is updated.
    func selectedTerrainUpdated(_ viewModel: BridgeSampleViewModel, selectedTerrain: JamesBondTerrainType)
    
    /// Executed when `viewModel`'s `terrainEmojis` property is updated.
    func terrainEmojisUpdated(_ viewModel: BridgeSampleViewModel, terrainEmojis: String)
    
    /// Executed when `viewModel`'s `bondCarWithEffects` property is updated
    func bondCarWithEffectsUpdated(_ viewModel: BridgeSampleViewModel, bondCarWithEffects: String)
}

class BridgeSampleViewModel {
    
    /// Contains array of `JamesBondTerrainType` options.
    internal var terrainOptions = [
        JamesBondTerrainType.Air,
        JamesBondTerrainType.Mountain,
        JamesBondTerrainType.Road,
        JamesBondTerrainType.Sea
    ]
    
    /// Selected `JamesBondTerrainType` of this instance.
    internal var selectedTerrain =  JamesBondTerrainType.Road {
        didSet {
            updateTerrainEmojis()
            updateBondCarForCurrentTerrain()
            delegate?.selectedTerrainUpdated(self, selectedTerrain: selectedTerrain)
        }
    }
    
    /// Stores `String` of emoji representation of current `selectedTerrain`.
    internal var terrainEmojis = "" {
        didSet {
            delegate?.terrainEmojisUpdated(self, terrainEmojis: terrainEmojis)
        }        
    }
    
    /// Stores `String` of emoji and text representation of bond car for currently `selectedTerrain`.
    internal var bondCarWithEffects = "" {
        didSet {
            delegate?.bondCarWithEffectsUpdated(self, bondCarWithEffects: bondCarWithEffects)
        }
    }
    
    weak internal var delegate: BridgeSampleViewModelDelegate?
    
    fileprivate var bondCar: JamesBondCar! {
        didSet {
            updateBondCarWithEffects()
        }
    }
    
    init() {
        updateTerrainEmojis()
        updateBondCarForCurrentTerrain()
    }
    
    // MARK: Private methods
    
    fileprivate func updateBondCarForCurrentTerrain() {
        bondCar = JamesBondCar(terrainType: selectedTerrain)
    }
    
    fileprivate func updateBondCarWithEffects() {
        bondCarWithEffects = "\(bondCar.carIcon())💨 \(bondCar.engineSound())"
    }
    
    fileprivate func updateTerrainEmojis() {

        let repeatCount = 40
        let terrainIconCharacter = Character(selectedTerrain.terrainIcon())
        
        terrainEmojis = String(repeating: String(terrainIconCharacter), count: repeatCount)
    }
}

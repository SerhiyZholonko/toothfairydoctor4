//
//  ModelCell.swift
//  nHealthProject
//
//  Created by admin on 12.02.2021.
//

import Foundation

struct MyCellTable {
    let content:String?
    let titleLabel:String
    init(content:String?,titleLabel:String) {
        self.content = content
        self.titleLabel = titleLabel
    }
    init(titleLabel:String) {
        self.init(content:nil,titleLabel:titleLabel)
    
     }}

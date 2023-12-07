// Created by Jake Vigeant

import Vapor

struct SelectionsResponse: Content {
    let departments: [String]
    let locations: [String:[String]]
    let posNames: [String:[String]]
}

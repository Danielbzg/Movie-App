//
//  Dependencies.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 10/4/23.
//

import Foundation

class Dependencies {

    static var repository: Repository { Repository(domain: .production, apiKey: .production) }
}

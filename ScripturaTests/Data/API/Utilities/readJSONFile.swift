//
//  readJSONFile.swift
//  ScripturaTests
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

fileprivate class BundleClass {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}

func readJSONFile(named fileName: String) -> Data? {
    do {
        guard let filePath = BundleClass().bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        return try Data(contentsOf: fileUrl)
    } catch {
        print("Error when trying to read the file \(fileName).json: ", error)
    }

    return nil
}

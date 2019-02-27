//
//  DataManager.swift
//  to-do-list
//
//  Created by Fábio Nogueira de Almeida on 26/02/19.
//  Copyright © 2019 Fábio Nogueira de Almeida. All rights reserved.
//

import Foundation

public class DataManager {

    // get Document directory
    static fileprivate func getDocumentDirectory () -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory,
                                              in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document directory")
        }
    }

    // save any kind of codable objects
    static func save <T: Encodable> (_ object: T, with filename: String) {
        let url = getDocumentDirectory().appendingPathComponent(filename, isDirectory: false)

        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static func load <T: Decodable> (filename: String, with type: T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(filename, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found ar path")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unvailable at path")
        }
    }

    static func loadData (filename: String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(filename, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found ar path")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            return data
        } else {
            fatalError("Data unvailable at path")
        }
    }

    static func loadAll <T: Decodable> (_ type: T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            var modelObjects = [T]()
            for fileName in files {
                modelObjects.append(load(filename: fileName, with: type))
            }
            return modelObjects
        } catch {
            fatalError("could not load any files")
        }
    }

    static func delete (fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)

        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError("error on delete")
            }
        }
    }
}

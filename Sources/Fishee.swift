//
// Copyright © 2024 Salar Rahmanian.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
// limitations under the License.
//


import ArgumentParser
import Foundation

let DEFAULT_FISH_HISTORY_LOCATION: String = "~/.local/share/fish/fish_history"

@main
struct Fishee: ParsableCommand {
    @Option(name: [.short, .customLong("history-file")], help: "Location of your fish history file. Will default to ~/.local/share/fish/fish_history")
    var fishHistoryLocationStr: String?
    
    @Option(name: .shortAndLong, help: "File path to file to merge with history file.")
    var mergeFile: String?
    
    @Option(
        name: [.short, .customLong("output-file")],
        help: "File to write to. Default: same as current history file."
    )
    var writeFileStr: String?
    
    @Flag(
        name: .shortAndLong,
        help: "Dry run. Will only print to the console without actually modifying the history file."
    )
    var dryRun: Bool = false
    
    @Flag(
        name: .shortAndLong,
        help: "Remove duplicates from combined history. Default: false"
    )
    var removeDuplicates: Bool = false
    
    @Flag(
        name: .shortAndLong,
        inversion: .prefixedNo,
        help: "Backup fish history file given before writing."
    )
    var backup: Bool = true
    
    var fishHistoryLocation: URL? {
        let pathStr = fishHistoryLocationStr ?? DEFAULT_FISH_HISTORY_LOCATION
        return getPath(pathStr)
    }
    
    var writeFileLocation: URL? {
        let pathStr = writeFileStr ?? DEFAULT_FISH_HISTORY_LOCATION
        return getPath(pathStr)
    }
    
    public func run() throws {
        let mergeFileLocation = mergeFile.flatMap { getPath($0) }
        let finalHistory: [FishHistoryEntry] = switch (fishHistoryLocation, mergeFileLocation) {
        case let (fishHistoryLocation?, mergeFileLocation?):
            {
                let currentHistory = parseFishHistory(from: fishHistoryLocation.path) ?? []
                let toMergeHistory = parseFishHistory(from: mergeFileLocation.path) ?? []
                return mergeFishHistory(currentHistory, toMergeHistory, removeDuplicates: removeDuplicates)
            }()
        case let (fishHistoryLocation?, nil):
            parseFishHistory(from: fishHistoryLocation.path) ?? []
        default:
            []
        }
        
        if dryRun {
            finalHistory.forEach { print("\($0.writeEntry().joined(separator: "\n"))") }
        }
        else {
            if let writePath = writeFileLocation?.path {
                let result = writeFishHistory(
                    to: writePath,
                    history: finalHistory,
                    backup: backup
                )
                if result {
                    print("Succussfully updated \(writePath)")
                }
                else {
                    print("Failed to update \(writePath)")
                }
            }
        }
        
        return
    }
}

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
	

import Foundation


func backupHistory(_ path: String) -> Bool {
    let fileManager = FileManager.default
        
    guard fileManager.fileExists(atPath: path) else {
        print("File does not exist at path: \(path)")
        return false
    }
    
    let fileURL = URL(fileURLWithPath: path)
    let fileExtension = fileURL.pathExtension
    let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
    let directory = fileURL.deletingLastPathComponent()
    
    let newFileName = "\(fileNameWithoutExtension)_copy"
    let newFileURL = directory.appendingPathComponent(newFileName).appendingPathExtension(fileExtension)
    
    do {
        try? fileManager.removeItem(at: newFileURL)
        try fileManager.copyItem(at: fileURL, to: newFileURL)
        print("File duplicated successfully to: \(newFileURL.path)")
        return true
    } catch {
        print("error making a backup of \(path), got error: \(error)")
        return false
    }
}


func writeFishHistory(to path: String, history: [FishHistoryEntry], backup: Bool = true) -> Bool {
    var output = ""
    
    if backup {
        let result = backupHistory(path)
        if !result {
            print("Failed to backup \(path) so aborting!")
            return false
        }
    }
    
    history.forEach { output += $0.writeEntry().joined(separator: "\n") + "\n" }
    
    if !output.isEmpty {
        do {
            try output.write(toFile: path, atomically: true, encoding: .utf8)
            print("Successfully wrote merged history to \(path)")
            return true
        } catch {
            print("Error writing merged history: \(error)")
            return false
        }
    }
    else {
        print("Nothing to write to \(path)")
        return false
    }
}

func parseFishHistory(from filePath: String) -> [FishHistoryEntry]? {
    guard let fileContents = try? String(contentsOfFile: filePath) else {
        print("Failed to open file.")
        return nil
    }
    
    let lines = fileContents.split(separator: "\n").map { String($0).trimmingCharacters(in: .whitespaces) }

    let initialState: (entries: [FishHistoryEntry], currentCmd: String?, currentWhen: Int?, currentPaths: [String]) = ([], nil, nil, [])
    
    let result = lines.reduce(into: initialState) { state, line in
        if line.starts(with: "- cmd:") {
            if let cmd = state.currentCmd, let when = state.currentWhen {
                let entry = FishHistoryEntry(cmd: cmd, when: when, paths: state.currentPaths)
                state.entries.append(entry)
                state.currentPaths = []
            }
            state.currentCmd = String(line.dropFirst("- cmd:".count).trimmingCharacters(in: .whitespaces))
        } else if line.starts(with: "when:") {
            if let whenValue = Int(line.dropFirst("when:".count).trimmingCharacters(in: .whitespaces)) {
                state.currentWhen = whenValue
            }
        } else if line.starts(with: "paths:") {
            return
        } else if line.starts(with: "- ") {
            let path = String(line.dropFirst("- ".count).trimmingCharacters(in: .whitespaces))
            state.currentPaths.append(path)
        }
    }
    
    if let cmd = result.currentCmd, let when = result.currentWhen {
        let entry = FishHistoryEntry(cmd: cmd, when: when, paths: result.currentPaths)
        return result.entries + [entry]
    }
    
    return result.entries
}

func mergeFishHistory(_ left: [FishHistoryEntry], _ right: [FishHistoryEntry], removeDuplicates: Bool = false) -> [FishHistoryEntry] {
    
    let merged = left + right
    
    if removeDuplicates {
        let finalList = merged.reduce(into: [String:FishHistoryEntry]()) { result, entry in
            if result[entry.cmd] == nil {
                result[entry.cmd] = entry
            }
        }
        return Array(finalList.values)
    } else {
        return merged
    }
    
}

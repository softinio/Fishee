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
import Testing
@testable import Fishee

@Suite(.serialized)
final class ParserTests {
    let fishHistoryFile = Bundle.module.path(forResource: "fish_history_test", ofType: "txt")
    let historyItem = FishHistoryEntry(cmd: "cd Projects/Fishee/", when: 1727545693, paths: ["Projects/Fishee/"])
    let historyItem2 = FishHistoryEntry(cmd: "swift package tools-version", when: 1727545709, paths: [])
    let filePathforWriteTest = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("myfile.txt")
    let filePathforFileBackupTest = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("myfile_copy.txt")
    
    deinit {
        if FileManager.default.fileExists(atPath: filePathforWriteTest.path) {
            _ = try? FileManager.default.removeItem(at: filePathforWriteTest)
        }
        if FileManager.default.fileExists(atPath: filePathforFileBackupTest.path) {
            _ = try? FileManager.default.removeItem(at: filePathforFileBackupTest)
        }
    }

    @Test func parseFishHistoryTest() {
        #expect(fishHistoryFile != nil)
        let fishHistory = parseFishHistory(from: fishHistoryFile!)
        #expect(fishHistory!.count > 0)
        let expectedHistory = [historyItem, historyItem2]
        #expect(fishHistory == expectedHistory)
    }
    
    @Test func writeFishHistoryTest() {
        let written = writeFishHistory(
            to: filePathforWriteTest.path,
            history: [historyItem],
            backup: false
        )
        #expect(written)
        
        let fileContent = try? String(contentsOf: filePathforWriteTest, encoding: .utf8)
        let expectedEntry = """
        - cmd: cd Projects/Fishee/
          when: 1727545693
          paths:
            - Projects/Fishee/
        
        """
        #expect(fileContent == expectedEntry)
        
        // confirm backup functionality is working
        #expect(FileManager.default.fileExists(atPath: filePathforWriteTest.path))
        
        let write_again = writeFishHistory(
            to: filePathforWriteTest.path,
            history: [historyItem],
            backup: true
        )
        #expect(write_again)
        #expect(FileManager.default.fileExists(atPath: filePathforFileBackupTest.path))
    }
    
    @Test func mergeFishHistoryTest() {
        let merged = mergeFishHistory([historyItem], [historyItem2])
        #expect(merged.count == 2)
        #expect(merged.contains(historyItem))
        #expect(merged.contains(historyItem2))
    }
    
    @Test func mergeFishHistoryWithDuplicateTest() {
        let merged = mergeFishHistory([historyItem], [historyItem, historyItem2])
        #expect(merged.count == 3)
        #expect(merged.contains(historyItem))
        #expect(merged.contains(historyItem2))
    }

    @Test func mergeFishHistoryRemoveDuplicateTest() {
        let merged = mergeFishHistory([historyItem], [historyItem, historyItem2], removeDuplicates: true)
        #expect(merged.count == 2)
        #expect(merged.contains(historyItem))
        #expect(merged.contains(historyItem2))
    }
}

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

@Suite
final class AlgebraTests {
    let historyItem = FishHistoryEntry(cmd: "cd Projects/Fishee/", when: 1727545693, paths: ["Projects/Fishee/"])

    @Test func dateFromHistoryTest() {
        let gotDate = historyItem.getDate()
        #expect(gotDate == Date(timeIntervalSince1970: 1727545693))
    }
    
    @Test func writeEntryTest() {
        let entry = historyItem.writeEntry()
        #expect(entry.count > 0)
        let expectedEntry = """
        - cmd: cd Projects/Fishee/
          when: 1727545693
          paths:
            - Projects/Fishee/
        """
        #expect(entry.joined(separator: "\n") == expectedEntry)
    }
    
}

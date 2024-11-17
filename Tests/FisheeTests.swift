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
final class FisheeTests {
    @Test func DryRunTest() {
        do {
            let help = try #require(Fishee.parse(["--dry-run"]) as Fishee)
            #expect(help.dryRun)
        } catch {
            Issue.record("Test failed! \(error)")
        }
    }
    
    @Test func HistoryFileTest() {
        do {
            let help = try #require(Fishee.parse(["--history-file", "/tmp/fishtest.txt"]) as Fishee)
            #expect(help.fishHistoryLocationStr == "/tmp/fishtest.txt")
        } catch {
            Issue.record("Test failed! \(error)")
        }
    }

    @Test func OutputFileTest() {
        do {
            let help = try #require(Fishee.parse(["--output-file", "/tmp/fishtest.txt"]) as Fishee)
            #expect(help.writeFileStr == "/tmp/fishtest.txt")
        } catch {
            Issue.record("Test failed! \(error)")
        }
    }

    @Test func RemoveDuplicatesTest() {
        do {
            let help = try #require(Fishee.parse(["--remove-duplicates"]) as Fishee)
            #expect(help.removeDuplicates)
        } catch {
            Issue.record("Test failed! \(error)")
        }
    }

    @Test func BackupTest() {
        do {
            let help = try #require(Fishee.parse(["--backup"]) as Fishee)
            #expect(help.backup)
        } catch {
            Issue.record("Test failed! \(error)")
        }
    }

    @Test func NoBackupTest() {
        do {
            let help = try #require(Fishee.parse(["--no-backup"]) as Fishee)
            #expect(!help.backup)
        } catch {
            Issue.record("Test failed! \(error)")
        }
    }
}

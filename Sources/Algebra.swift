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
	
/// Data Structure/Schema representing an entry in a fish history file.
struct FishHistoryEntry: Equatable {
    let cmd: String
    let when: Int
    let paths: [String]
   
    /// Converts time to Date object
    func getDate() -> Date {
        Date(timeIntervalSince1970: TimeInterval(when))
    }
   
    /// Converts structure back to list of strings as expected in a fish history file.
    func writeEntry() -> [String] {
        var output: [String] = []
        
        output.append("- cmd: \(cmd)")
        output.append("  when: \(when)")
        
        if !paths.isEmpty {
            output.append("  paths:")
            paths.forEach { output.append("    - \(String($0))") }
        }
        
        return output
    }
}

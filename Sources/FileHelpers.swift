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


func getPath(_ pathStr: String) -> URL? {
    let userHomeDirectory = FileManager.default.homeDirectoryForCurrentUser.path
    var filePath: String = pathStr
    
    if pathStr.hasPrefix("~") {
        filePath = (pathStr as NSString).expandingTildeInPath
    }
    
    if pathStr.hasPrefix("$HOME") {
        filePath = filePath.replacingOccurrences(of: "$HOME", with: userHomeDirectory)
    }
    
    if !FileManager.default.fileExists(atPath: filePath) {
        return nil
    }
    
    return URL(fileURLWithPath: filePath)
}

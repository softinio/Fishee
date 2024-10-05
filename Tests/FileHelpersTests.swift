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


final class FileHelpersTests {
    let filePath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("myfile.txt")
    
    init() {
        try? "this is a test".write(
            to: filePath,
            atomically: true,
            encoding: .utf8
        )
    }
    
    deinit {
        try? FileManager.default.removeItem(at: filePath)
    }
    
    @Test(arguments: [
        "$HOME/myfile.txt",
        "~/myfile.txt",
        "\(FileManager.default.homeDirectoryForCurrentUser.path)/myfile.txt"
    ])
    func getPathTest(testPath: String) {
        let path = getPath(testPath)
        let expected =  URL(fileURLWithPath: "\(FileManager.default.homeDirectoryForCurrentUser.path)/myfile.txt")
        #expect(path == expected)
    }
}

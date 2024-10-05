import Foundation

func countWords(in text: String) -> Int {
    let words = text.split { !$0.isLetter }
    return words.count
}

func searchWord(in text: String, word: String) -> Int {
    let words = text.split { !$0.isLetter }
    return words.filter { $0.lowercased() == word.lowercased() }.count
}

func replaceWord(in text: String, target: String, replacement: String) -> String {
    return text.replacingOccurrences(of: target, with: replacement)
}

func readFile(at path: String) -> String? {
    return try? String(contentsOfFile: path, encoding: .utf8)
}

func main() {
    guard CommandLine.arguments.count > 2 else {
        print("Usage: TextTool <command> <file> [arguments]")
        return
    }

    let command = CommandLine.arguments[1]
    let filePath = CommandLine.arguments[2]

    guard let text = readFile(at: filePath) else {
        print("Failed to read file at \(filePath)")
        return
    }

    switch command {
    case "count":
        let wordCount = countWords(in: text)
        print("Word count: \(wordCount)")
    case "search":
        guard CommandLine.arguments.count > 3 else {
            print("Usage: TextTool search <file> <word>")
            return
        }
        let word = CommandLine.arguments[3]
        let count = searchWord(in: text, word: word)
        print("The word '\(word)' appears \(count) times.")
    case "replace":
        guard CommandLine.arguments.count > 4 else {
            print("Usage: TextTool replace <file> <target> <replacement>")
            return
        }
        let target = CommandLine.arguments[3]
        let replacement = CommandLine.arguments[4]
        let newText = replaceWord(in: text, target: target, replacement: replacement)
        print(newText)
    default:
        print("Unknown command: \(command)")
    }
}



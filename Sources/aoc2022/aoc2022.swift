import Foundation
import Algorithms

@main
public struct aoc2022 {
    public static func main() {
        //        day1()
        //        day2()
        //        day2_star2()
        //        day3()
        //        day3_star2()
        //        day4()
        //        day5()
        // day6()
        //        day7()
//        day8()
        day8_star2()
    }
    
    static func day8_star2() {
        guard let filepath = Bundle.module.path(forResource:"08_input", ofType:"txt") else {
            return
        }
        
        let filecontent = try! String(contentsOfFile: filepath)
        
        var rows: [[Character]] = []
        for row in filecontent.components(separatedBy: "\n") {
            let cols = Array(row)
            
            rows.append(cols)
        }
        let forest = rows.map { $0.map { Int(String($0))!}}.dropLast(1)
    
        var bestScenicScoreSoFar = 0
        for (x,row) in forest.enumerated() {
            for (y,val) in row.enumerated() {
                if (x == 0 || x == row.count-1 || y == 0 || y == forest.count-1) {
                    continue
                } else {
                    var left = 0
                    for l in (0..<x).reversed() {
                        if val > forest[l][y] {
                            left += 1
                        } else if val == forest[l][y] {
                            left += 1
                            break
                        }
                    }
                    var right = 0
                    for r in x+1...row.count-1 {
                        if val > forest[r][y] {
                            right += 1
                        } else if val == forest[r][y] {
                            right += 1
                            break
                        }
                    }
                    var top = 0
                    for t in (0..<y).reversed() {
                        if val > forest[x][t] {
                            top += 1
                        } else if val == forest[x][t] {
                            top += 1
                            break
                        }
                    }
                    var bottom = 0
                    for b in y+1...forest.count-1 {
                        if val > forest[x][b] {
                            bottom += 1
                        } else if val == forest[x][b] {
                            bottom += 1
                            break
                        }
                    }
                    print("(\(x),\(y)):\(val) L:\(left) R:\(right) T:\(top) B:\(bottom)")
                    let scenicScore = left * right * top * bottom
                    if scenicScore > bestScenicScoreSoFar {
                        bestScenicScoreSoFar = scenicScore
                    }
                }
            }
        }
        
        print(bestScenicScoreSoFar)
    }
    
    static func day8() {
        guard let filepath = Bundle.module.path(forResource:"08_input", ofType:"txt") else {
            return
        }
        
        let filecontent = try! String(contentsOfFile: filepath)
        
        var rows: [[Character]] = []
        for row in filecontent.components(separatedBy: "\n") {
            let cols = Array(row)
            
            rows.append(cols)
        }
        let forest = rows.map { $0.map { Int(String($0))!}}.dropLast(1)
        
        var amount = 0
        
        for (x,row) in forest.enumerated() {
            for (y,val) in row.enumerated() {
                

                if (x == 0 || x == row.count-1 || y == 0 || y == forest.count-1) {
                    print("current value \(val) at: \(x),\(y) EDGE")
                    amount += 1
                } else {
                    var left = true
                    for l in 0..<x {
                        if val <= forest[l][y] {
                            left = false
                            break
                        }
                    }
                    var right = true
                    for r in x+1...row.count-1 {
                        if val <= forest[r][y] {
                            right = false
                            break
                        }
                    }
                    var top = true
                    for t in 0..<y {
                        if val <= forest[x][t] {
                            top = false
                            break
                        }
                    }
                    var bottom = true
                    for b in y+1...forest.count-1 {
                        if val <= forest[x][b] {
                            bottom = false
                            break
                        }
                    }
                    print("current value \(val) at: \(x),\(y) L:\(left) R:\(right) T:\(top) B:\(bottom)")
                    if left || right || top || bottom {
                        amount += 1
                    }
                }
            }
        }
        
        print(amount)
    }
    
    static func day7() {
        guard let filepath = Bundle.module.path(forResource:"07_input", ofType:"txt") else {
            return
        }
        
        let filecontent = try! String(contentsOfFile: filepath)
        
        
        var pwd: [String] = ["/"]
        
        let fs: ElveFSNode = ElveFSNode("/")
        for line in filecontent.components(separatedBy: "\n").dropFirst() {
            let components = line.components(separatedBy: " ")
            let workingDir = pwd.last!
            
            if components[0] == "dir" {
                if let wd = fs.find(workingDir) {
                    wd.add(child: ElveFSNode(components[1]))
                }
            }
            
            if let size = Int(components[0]) {
                if let wd = fs.find(workingDir) {
                    wd.add(child:ElveFile(name: components[1], size: size))
                }
            }
            
            if components[0] == "$" {
                if components[1] == "ls" {
                    continue
                }
                
                if components[1] == "cd" {
                    if components[2] == ".." {
                        _ = pwd.popLast()
                    } else {
                        pwd.append(components[2])
                    }
                }
            }
            
            
        }
        
        
        
        var sum = 0
        for dir in fs {
            if dir.size <= 100_000 && dir.size != 0 {
                print(dir)
                sum += dir.size
            }
        }
        
        print(sum)
        
    }
    
    static func day6() {
        if let filepath = Bundle.module.path(forResource:"06_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                
                var window: [Character] = []
                var counter = 0
                for char in filecontent {
                    counter += 1
                    window.append(char)
                    if window.count <= 4 {
                        continue
                    }
                    window.remove(at: 0)
                    
                    if Set(window).count == 4 {
                        break
                    }
                }
                
                print(counter)
                
                window = []
                counter = 0
                for char in filecontent {
                    counter += 1
                    window.append(char)
                    if window.count <= 14 {
                        continue
                    }
                    window.remove(at: 0)
                    
                    if Set(window).count == 14 {
                        break
                    }
                }
                
                print(counter)
                
            } catch {
                print(error)
            }
        }
    }
    
    static func day5() {
        if let filepath = Bundle.module.path(forResource:"05_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var supplyStacks: [Int:[Character]] = [
                    1:[],
                    2:[],
                    3:[],
                    4:[],
                    5:[],
                    6:[],
                    7:[],
                    8:[],
                    9:[],
                ]
                
                for line in filecontent.components(separatedBy: "\n") {
                    if line.starts(with: "move") {
                        break
                    }
                    let linecrates = Array(line).chunks(ofCount: 4).map(Array.init)
                    
                    for (index, crate) in linecrates.enumerated() {
                        if crate[1].description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            crate[1].isNumber {
                            continue
                        }
                        supplyStacks[index+1]?.insert(crate[1], at: 0)
                    }
                }
                print("BEFORE")
                print(supplyStacks.sorted(by: {$0.key < $1.key}))
                
                for line in filecontent.components(separatedBy: "\n") {
                    if !line.starts(with: "move") {
                        continue
                    }
                    let howMany = Int(line.components(separatedBy: " ")[1])!
                    let from = Int(line.components(separatedBy: " ")[3])!
                    let to = Int(line.components(separatedBy: " ").last!)!
                    
                    //                    print("move \(howMany) from \(from) to \(to)")
                    
                    var buf: [Character] = []
                    for _ in 0..<howMany {
                        if let popped = supplyStacks[from]?.popLast() {
                            //                            print("move \(howMany) from \(from) to \(to) ---> \(popped)")
                            buf.insert(popped, at: 0)
                        }
                    }
                    supplyStacks[to]?.append(contentsOf: buf)
                    print(buf)
                    buf = []
                }
                
                var result = ""
                for (_,val) in supplyStacks.sorted(by: {$0.key < $1.key}) {
                    if let letter = val.last {
                        result.append(letter)
                    }
                    
                }
                
                print("AFTER")
                print(supplyStacks.sorted(by: {$0.key < $1.key}))
                print("result " + result)
            } catch {
                print(error)
            }
        }
    }
    
    static func day4() {
        if let filepath = Bundle.module.path(forResource:"04_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var count = 0
                var atLeastOneOverlap = 0
                for pairs in filecontent.components(separatedBy: "\n") {
                    let rangeAs = pairs.components(separatedBy: ",").first
                    let rangeBs = pairs.components(separatedBy: ",").last
                    
                    let begginingA = Int(rangeAs!.components(separatedBy: "-").first!)!
                    let endA = Int(rangeAs!.components(separatedBy: "-").last!)!
                    
                    let begginingB = Int(rangeBs!.components(separatedBy: "-").first!)!
                    let endB = Int(rangeBs!.components(separatedBy: "-").last!)!
                    
                    let rangeA = Set(begginingA...endA)
                    let rangeB = Set(begginingB...endB)
                    
                    if rangeA.isSubset(of: rangeB) || rangeB.isSubset(of: rangeA) {
                        count += 1
                    }
                    
                    if rangeA.intersection(rangeB).count > 0 {
                        atLeastOneOverlap += 1
                    }
                    
                    
                }
                
                print("are subset of each other: \(count)")
                print("have at least one overlap: \(atLeastOneOverlap)")
                
            } catch {
                print(error)
            }
        }
    }
    
    static func day3_star2() {
        if let filepath = Bundle.module.path(forResource:"03_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var items: [String] = []
                for elveGroup in filecontent
                    .components(separatedBy: "\n")
                    .chunks(ofCount: 3)
                    .map(Array.init) {
                    let rucksack1 = Set(elveGroup[0])
                    let rucksack2 = Set(elveGroup[1])
                    let rucksack3 = Set(elveGroup[2])
                    let common = rucksack1.intersection(rucksack2).intersection(rucksack3)
                    
                    common.map { String($0) }.forEach { items.append($0) }
                    
                }
                
                var itemPriorities: [Character: Int] = [:]
                let smallLetters = (0..<26).map({Character(UnicodeScalar("a".unicodeScalars.first!.value + $0)!)})
                let capitalLetters = (0..<26).map({Character(UnicodeScalar("A".unicodeScalars.first!.value + $0)!)})
                
                smallLetters.enumerated().forEach { (index, item) in
                    itemPriorities[item] = index+1
                }
                
                capitalLetters.enumerated().forEach { (index, item) in
                    itemPriorities[item] = index+27
                }
                
                var prioritySum = 0
                items.forEach { prioritySum += itemPriorities[Character(UnicodeScalar($0.unicodeScalars.first!.value)!)] ?? 0 }
                
                print(prioritySum)
                
            } catch {
                print(error)
            }
        }
    }
    
    static func day3() {
        if let filepath = Bundle.module.path(forResource:"03_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var items: [String] = []
                for rucksack in filecontent.components(separatedBy: "\n") {
                    let compartmentOne = Set(rucksack.prefix(rucksack.count/2))
                    let compartmentTwo = Set(rucksack.suffix(rucksack.count/2))
                    let common = compartmentOne.intersection(compartmentTwo)
                    
                    common.map { String($0) }.forEach { items.append($0) }
                    
                }
                
                var itemPriorities: [Character: Int] = [:]
                let smallLetters = (0..<26).map({Character(UnicodeScalar("a".unicodeScalars.first!.value + $0)!)})
                let capitalLetters = (0..<26).map({Character(UnicodeScalar("A".unicodeScalars.first!.value + $0)!)})
                
                smallLetters.enumerated().forEach { (index, item) in
                    itemPriorities[item] = index+1
                }
                
                capitalLetters.enumerated().forEach { (index, item) in
                    itemPriorities[item] = index+27
                }
                
                var prioritySum = 0
                items.forEach { prioritySum += itemPriorities[Character(UnicodeScalar($0.unicodeScalars.first!.value)!)] ?? 0 }
                
                print(prioritySum)
                
            } catch {
                print(error)
            }
        }
    }
    
    static func day2() {
        if let filepath = Bundle.module.path(forResource:"02_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var score = 0
                for gameline in filecontent.components(separatedBy: "\n") {
                    let opponentMove = toRPSMove(gameline.components(separatedBy: " ")[0])
                    let yourMove = toRPSMove(gameline.components(separatedBy: " ")[1])
                    score += haveYouWonRPS(opponentMove, yourMove).rawValue
                    score += rpsVal[yourMove] ?? 0
                }
                
                print(score)
            } catch {
                print(error)
            }
        }
    }
    
    static func day2_star2() {
        if let filepath = Bundle.module.path(forResource:"02_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var score = 0
                for gameline in filecontent.components(separatedBy: "\n") {
                    let opponentMove = toRPSMove(gameline.components(separatedBy: " ")[0])
                    let suggestedResult = toRPSResult(gameline.components(separatedBy: " ")[1])
                    score += suggestedResult.rawValue
                    score += rpsVal[youSouldPlay(opponentMove, suggestedResult)] ?? 0
                }
                
                print(score)
            } catch {
                print(error)
            }
        }
    }
    
    static func day1() {
        if let filepath = Bundle.module.path(forResource:"01_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var elves: [[Int]] = []
                var current: [Int] = []
                for calorieline in filecontent.components(separatedBy: "\n") {
                    if calorieline == "" {
                        elves.append(current)
                        current = []
                        continue
                    }
                    let calorieInt = Int(calorieline) ?? 0
                    current.append(calorieInt)
                }
                
                let summed = elves
                    .compactMap { $0.reduce(0) {$0 + $1} }
                    .max()
                
                let topThree = elves
                    .compactMap { $0.reduce(0) {$0 + $1} }
                    .sorted { $0 > $1 }
                    .prefix(3)
                    .reduce(0) { $0 + $1 }
                
                
                print(summed ?? 0)
                print (topThree)
            } catch {
                print("error")
            }
        }
    }
}



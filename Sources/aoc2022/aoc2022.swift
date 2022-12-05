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
        day5()
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
                    
                    for _ in 0..<howMany {
                        if let popped = supplyStacks[from]?.popLast() {
                            print("move \(howMany) from \(from) to \(to) ---> \(popped)")

                            supplyStacks[to]?.append(popped)
                        }
                        
                    }
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



enum RPSMove {
    case rock
    case paper
    case scissors
    case unknown
}

let rpsVal: [RPSMove:Int] = [
    .rock: 1,
    .paper: 2,
    .scissors: 3,
]

func toRPSMove(_ s: String) -> RPSMove {
    switch s {
    case "A", "X":
        return .rock
    case "B", "Y":
        return .paper
    case "C", "Z":
        return .scissors
    default:
        return .unknown
    }
}


enum RPSResult: Int {
    case won = 6
    case tie = 3
    case lost = 0
}

func toRPSResult(_ s:String) -> RPSResult {
    switch s {
    case "Z": return .won
    case "Y": return .tie
    default: return .lost
    }
}


let rpsRequirement: [String:RPSResult] = [
    "X": .lost,
    "Y": .tie,
    "Z": .won
]


func youSouldPlay(_ opp: RPSMove, _ expectedResult: RPSResult) -> RPSMove {
    switch (opp, expectedResult) {
        
    case (.rock, .won):
        return .paper
    case (.rock, .lost):
        return .scissors
    case (.rock, .tie):
        return .rock
        
    case (.paper, .won):
        return .scissors
    case (.paper, .lost):
        return .rock
    case (.paper, .tie):
        return .paper
        
    case (.scissors, .won):
        return .rock
    case (.scissors, .lost):
        return .paper
    case (.scissors, .tie):
        return .scissors
        
    default:
        return .unknown
    }
}

func haveYouWonRPS(_ opp: RPSMove,_ you: RPSMove) -> RPSResult {
    if opp == you {
        return .tie
    }
    switch (opp, you) {
    case (.scissors, .rock), (.paper, .scissors), (.rock, .paper):
        return .won
    default:
        return .lost
    }
}


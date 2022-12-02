import Foundation


@main
public struct aoc2022 {
    public static func main() {
        //        day1()
        day2()
        day2_star2()
    }
    
    static func day2() {
        if let filepath = Bundle.module.path(forResource:"02_input", ofType:"txt") {
            do {
                let filecontent = try String(contentsOfFile: filepath)
                
                var score = 0
                for gameline in filecontent.components(separatedBy: "\n") {
                    let opponentMove = gameline.components(separatedBy: " ")[0]
                    let yourMove = gameline.components(separatedBy: " ")[1]
                    score += haveYouWonRPS(opponentMove, yourMove).rawValue
                    score += rpsVal[toRPSMove(yourMove)] ?? 0
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

func haveYouWonRPS(_ opp: String,_ you: String) -> RPSResult {
    switch (opp, you) {
    case ("A", "X"), ("B","Y"), ("C","Z"):
        return .tie
    case ("A", "Y"), ("B","Z"), ("C","X"):
        return .won
    default:
        return .lost
    }
}


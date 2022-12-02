import Foundation



let v: [String:Int] = [
    "X": 1,
    "Y": 2,
    "Z": 3,
]

@main
public struct aoc2022 {
    public static func main() {
        //        day1()
        day2()
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
                    score += v[yourMove] ?? 0
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

enum RPSResult: Int {
    case won = 6
    case tie = 3
    case lost = 0
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


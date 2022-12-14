import Foundation

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

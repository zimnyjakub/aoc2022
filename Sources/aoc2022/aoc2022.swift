import Foundation

@main
public struct aoc2022 {
    public static func main() {
        day1()
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
            }catch  {
                print("error")
            }
        }
    }
    
}

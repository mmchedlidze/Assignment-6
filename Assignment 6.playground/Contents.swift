
//1. შევქმნათ Class-ი SuperEnemy with properties: String name, Int hitPoints (ანუ სიცოცხლის რაოდენობა).
//სურვილისამებრ დაამატებ properties რომელიც მას აღწერს.

class SuperEnemy {
    var name: String
    var hitPoints: Int
    
    init(name: String, hitPoints: Int) {
        self.name = name
        self.hitPoints = hitPoints
    }
}
//2. შევქმნათ Superhero Protocol-ი.
//შემდეგი get only properties: String name, String alias, Bool isEvil და დიქშენარი (dictionary) superPowers [String: Int], სადაც String-ი არის სახელი და Int არის დაზიანება (damage).
//Method attack, რომელიც მიიღებს target SuperEnemy-ის და დააბრუნებს (return) Int-ს ანუ დარჩენილ სიცოცხლე.
//Method performSuperPower, რომელიც მიიღებს SuperEnemy-ის და დააბრუნებს (return) Int-ს, აქაც დარჩენილ სიცოცხლე.
protocol Superhero {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String: Int] { get set }
    
   mutating func performSuperPower(superPower: String, enemy: SuperEnemy ) -> Int
   mutating func attack(enemy: SuperEnemy ) -> Int
}

//3. Superhero-ს extension-ი გავაკეთოთ სადაც შევქმნით method-ს რომელიც დაგვი-print-ავს ინფორმაციას სუპერ გმირზე და მის დარჩენილ superPower-ებზე.
extension Superhero {
    func printInfo() {
        print("----Superhero: Name: \(name), Alias: \(alias), Remaining Life: \(superPowers)")
    }
}

extension SuperEnemy {
        func printInfo() {
            print("----Super Enemy: Name: \(name), Remaining Life: \(hitPoints)")
        }
    }

//4. შევქმნათ რამოდენიმე სუპერგმირი Struct-ი რომელიც ჩვენს Superhero protocol-ს დააიმპლემენტირებს მაგ:
//struct SpiderMan: Superhero და ავღწეროთ protocol-ში არსებული ცვლადები და მეთოდები.
//attack მეთოდში -> 20-იდან 40-ამდე დავაგენერიროთ Int-ის რიცხვი და ეს დაგენერებული damage დავაკლოთ SuperEnemy-ს სიცოცხლეს და დარჩენილი სიცოცხლე დავაბრუნოთ( return)
//performSuperPower-ს შემთხვევაში -> დიქშენერიდან ერთ superPower-ს ვიღებთ და ვაკლებთ enemy-ს (სიცოცხლეს ვაკლებთ). ვშლით ამ დიქშენერიდან გამოყენებულ superPower-ს. გამოყენებული superPower-ი უნდა იყოს დარანდომებული. დარჩენილ enemy-ს სიცოცხლეს ვაბრუნებთ (return).
struct marvelHeroes: Superhero {
    var name: String
    var alias: String
    var isEvil: Bool
    var superPowers: [String : Int]
    
    mutating func performSuperPower(superPower: String, enemy: SuperEnemy) -> Int {
            if let superPowerDamage = superPowers[superPower] {
                enemy.hitPoints -= superPowerDamage
                superPowers.removeValue(forKey: superPower)
                return enemy.hitPoints
            } else {
                print("You defeated your enemy")
                return 0
            }
    }
        func attack(enemy: SuperEnemy) -> Int {
        if superPowers.isEmpty {
            let randomDamage = Int.random(in: 20...40)
            enemy.hitPoints -= randomDamage
            return enemy.hitPoints
        } else {
            print("You defeated your enemy")
            return 0
        }
    }
}
    
let captainAmerica = marvelHeroes(name: "Captain America", alias: "Marvel", isEvil: false, superPowers: ["Shield Throw" : 25, "Super Strengh" : 35, "Shield Block" : 20])
let ironMan = marvelHeroes(name: "Iron Man", alias: "Marvel", isEvil: false, superPowers: ["Flight": 20,"Energy Shield": 25,"Laser Sword": 30])
let thor = marvelHeroes(name: "Thor", alias: "Marvel", isEvil: false, superPowers: ["Weather Control": 30,  "Teleportation": 25, "Lightning Bolt": 40])
let thanos = SuperEnemy(name: "Thanos", hitPoints: 100)

//5. შევქმნათ class SuperherSquad,
//რომელიც ჯენერიკ Superhero-s მიიღებს. მაგ: class SuperheroSquad<T: Superhero>.
//შევქმნათ array სუპერგმირების var superheroes: [T].
//შევქმნათ init-ი.
//შევქმნათ method რომელიც ჩამოგვითვლის სქვადში არსებულ სუპერგმირებს.

class SuperheroSquad {
    var squadMembers: [Superhero]
    
    init(squadMembers: [Superhero]) {
        self.squadMembers = squadMembers
    }
    func addMember(member: Superhero) {
           squadMembers.append(member)
       }
    func listSquadMembers() {
        print("Squad Members:")
        for member in squadMembers {
            print("Name: \(member.name), Alias: \(member.alias)")
        }
    }
}
var superheroSquad = SuperheroSquad(squadMembers: [])

superheroSquad.addMember(member: ironMan)
superheroSquad.addMember(member: captainAmerica)
//superheroSquad.listSquadMembers()
//ironMan.printInfo()
//captainAmerica.printInfo()


//6.ამ ყველაფრის მერე მოვაწყოთ ერთი ბრძოლა. 🤺🤜🏻🤛🏻
//შევქმნათ method simulateShowdown. ეს method იღებს სუპერგმირების სქვადს და იღებს SuperEnemy-ს.
//სანამ ჩვენი super enemy არ მოკვდება, ან კიდევ სანამ ჩვენ სუპერგმირებს არ დაუმთავრდებათ სუპერ შესაძლებლობები გავმართოთ ბრძოლა.
//ჩვენმა სუპერ გმირებმა რანდომად შეასრულონ superPowers, ყოველი შესრულებული superPowers-ი იშლება ამ გმირის ლისტიდან. თუ გმირს დაუმთავრდა superPowers, მას აქვს ბოლო 1 ჩვეულებრივი attack-ის განხორციელება (ამ attack განხორიციელება მხოლოდ ერთხელ შეუძლია როცა superPowers უმთავრდება).
    func fight(squad: SuperheroSquad, enemy:SuperEnemy) {
        while !squad.squadMembers.isEmpty && enemy.hitPoints > 0 {
            
            let randomMemberIndex = Int.random(in: 0..<squad.squadMembers.count)
            var member = squad.squadMembers[randomMemberIndex]
            
            if member.superPowers.isEmpty {
                let randomDamage = Int.random(in: 20...40)
                enemy.hitPoints -= randomDamage
                print("\(member.name) makes the final attack to \(enemy.name) and leaves the game  ")
                enemy.printInfo()
            } else {
                let randomSuperpowerIndex = member.superPowers.keys.randomElement()!
                let superPowerDamage = member.performSuperPower(superPower: randomSuperpowerIndex, enemy: enemy)
                print("\(member.name) attacks \(enemy.name) with \(randomSuperpowerIndex)")
                member.printInfo()
                enemy.printInfo()
            }
            if enemy.hitPoints <= 0 {
                print("***Superhero Squad wins***")
            }
            
            if squad.squadMembers.isEmpty {
                print("*** Super Enemy wins ***")
            }
        }
    }
fight(squad: superheroSquad, enemy: thanos) /*აქ გავიჭედე, undefetead Superhero-ები გამომივიდა ;დ  ფუნქცია თითქოს სწორია, მარა მეორედ რომ სრულდება ძველი უკვე გამოყენებული სუფერფაუერი მაინც უბრუნდება და ენემი განწირულია ყველა ვარიანტში ;დ კი კარგია სულ ვიგებთ მარა როგორ გავასწორო*/


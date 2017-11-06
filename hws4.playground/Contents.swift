import UIKit

// PROPERTIES
// The vars inside structs and classes have their own variables and constants, called properties
// They can be hard defined, or have methods to behave by themselves.

struct Cat {
    var name: String
    var disposition: String
    
    func describe() {
        print("My name is \(name) and I am a \(disposition.lowercased()) cat.")
    }
}

let Carmen = Cat(name: "Carmen", disposition: "huNgry")
let Wombat = Cat(name: "Wombat", disposition: "NOT a")
// Using the property "name" inside a method automatically uses the value that belongs to the same object.
Carmen.describe()
Wombat.describe()

// PROPERTY OBSERVERS
// Code to be run when a property is about to be / has changed
// Two kinds
// 1) willSet
// Comes with "newValue" that contains what the new property value is going to be
// 2) didSet
// Comes with "oldValue" to represent previous value.

struct ObservedCat {
    var tailLength: Int {
        willSet {
            updateUI(msg: "My tail will change from \(tailLength) to \(newValue)")
        }
        didSet {
            updateUI(msg: "My tail changed from \(oldValue) to \(tailLength)")
        }
    }
}
func updateUI(msg: String) {
    print(msg)
}

var tangerine = ObservedCat(tailLength: 1)
tangerine.tailLength = 2

// COMPUTED PROPERTIES
// Possible to make properties that are actually methods
// For example uppercased() or capitalized(), which are calculated as needed, instead of being constantly stored
// Keywords: get / set
// to make an action happen at an appropriate time

struct ComputedCat {
    var hungerLevel: Int
    
    var angryLevel: Int {
        get {
            return hungerLevel * 10
        }
    }
}

var smoll = ComputedCat(hungerLevel: 20)
print(smoll.angryLevel)

// STATIC PROPERTIES AND METHODS
// Able to create properties and methods that belong to a type, rather than to instances of a type. Organizes data meaningfully by storing shared data
// Create by using keyword static
// Then you can access that property by using the full name of the type

struct CatFan {
    static var personality = "Weird"
    
    var name: String
    var tailLength: Int
}
print(CatFan.personality)
// Note that I used the name of the type
// All CatFans will have their own name and tailLength, but the same personality of "Weird"
// Static methods belong to the class rather than to instances of a class, which is why you can't use it to access any non-static properties of the class. 

// ACCESS CONTROL
// Access control lets you specify what data inside structs and classes should be exposed to the outside world
// 1) Public: Everyone can read/write the property
// 2) Internal: Only my Swift code can read/write the property, so if it were distributed as a framework, it would not be viewable by others
// 3) File private "fileprivate": Only Swift code in the same file as the type can read/write the property
// 4) Private: Property is only available inside methods that belong to the type

// Useful because it stops others from accessing it directly. 
// So certain methods designed to work with that property will work, but other will have to perform certain actions in order to run.

struct Animal {
    private var name: String
}

class Album {
    var name: String
    init(name: String) {
        self.name = name
    }
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

class LimitedEditionStudioAlbum: StudioAlbum {
    var anniversary: Int
    init(name:String, studio: String, anniversary: Int) {
        self.anniversary = anniversary
        super.init(name: name, studio: studio)
    }
    override func getPerformance() -> String {
        return "The limited edition album \(name) sold lots"
    }
}

// POLYMORPHISM
// Defined four classes: StudioAlbum and LiveAlbum inherit from Album, and LimitedEditionStudioAlbum inherits from StudioAlbum (two deep).
// Any instance of LiveAlbum is inherited from album, which means it can be treated as an Album or LiveAlbum at the same time; thus Polymorphism

var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studios")
var tunesLive = LiveAlbum(name: "TS Live!", location: "Miami")
// Compiler returns an error if anniversary argument comes before studio, I suppose that's because it needs to send that data up to create the superclass before it creates the lower level classs
var bestHits = LimitedEditionStudioAlbum(name: "Best of TS", studio: "1 Studio", anniversary: 10)

// Because they all inherit from the Album superclass, they can all go into the same array that has been defined as an array of Albums (in the square brackets)
var allAlbums: [Album] = [fearless, tunesLive, bestHits]
// This for loop willl automatically use the override version of getPerformance depending on the resepctive subclass
// This is polymorphism, an object can work as its class and parent classes at the same time.
for album in allAlbums {
    print(album.getPerformance())
}

// CONVERTING TYPES WITH TYPECASTING
// If you have an object of a certain type, but you really know it's a different type, then Swift will not compile it because it does not know
// The solution is Typecasting: converting an object of one type to another
// Consider the loop previously written:
//    for album in allAlbums {
//       print(album.getPerformance())
//    }
// The allAlbums array holds the type Album, but we know it holds one of each of the subclasses
// However, Swift does NOT know that, and is going on the knowledge that all objects in the array are part of class Album
// In addition, writing print(album.studio) in the loop would not work because only StudioAlbum objects have that property.

// Typecasting comes in three forms, but will mostly use only
// as? (optional downcasting) || as! (forced downcasting)
// The former (?) means that the conversion might be true but it might fail
// The latter (!) assumes that you are sure the conversion will pass and thus the app will crash if there is an error.

for album in allAlbums {
    let studioAlbum = album as? StudioAlbum
}
// ???
// Swift will make studioAlbum have the data type StudioAlbum?.

// OPTIONAL DOWNCASTING
// Optional downcasting is frequently used with "if let" to automatically unwrap the optional result

for album in allAlbums{
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print("1 " + studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print("3 " + liveAlbum.location)
    }
}

// This goes through every album and prints its performance details. 
// Then it checks whether it can convert the album value into StudioAlbum
// If it can, it prints the studio
// If it's not, then it goes through the else to check if it can be converted to LiveAlbum
// Then it would print its location

// FORCED DOWNCASTING
// When you're sure that an object can be treated like another type
// If you're wrong then the program will crash
// There's no need for an optional, because you declare that it's definitely going to work.

var Cat1 = StudioAlbum(name: "CatOne", studio: "Fang Studio")
var Cat2 = StudioAlbum(name: "CatTwo", studio: "Tail Studio")
var allBums: [Album] = [Cat1, Cat2]

for album in allBums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.name)
}

// If this were actual code, then actually I would difrectly change allBums so that it had data type StudioAlbums, cutting out a step
// Because we made the correct assumptions (Cat1 and Cat2 are both StudioAlbums), the forced downcasting worked

// We can also downcast as part of the array loop
for album in allBums as! [StudioAlbum] {
    print(album.studio)
}
// Now we don't need to downcase every item inside the loop, because it happens when the loop begins. 
// If not all the items in the array were StudioAlbums, the code would crash.

// OPTIONAL DOWNCASTING
// Need to use nil coalescing operator to ensure there's always a value for the loop
for album in allBums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location + "cat")
}
// This tries to convert allBums to be an array of LiveAlbum objects
// If it fails, create an empty array of live albums and use that. 
// Probably don't need to use this

// CONVERTING COMMON TYPES WITH INITIALIZERS
// Typecasting is useful when you know something that Swift doesn't
// For example, when you have an object of Type A that is actually Type B.
// You can't force Type A into Type Z if they aren't actually related

// If you have an integer called number, you can't convert it into a string like this:
// > let number = 5
// > let text = number as! String
// You can't force an integer into a string because they are two completely different types.

// Instead, need to create a new string by feeding it the integer, and Swift will convert
// Difference: you have created a new value rather than reinterpreting the old one

let number = 5
let text = String(number)
print (text)

//CLOSURES
// A closure is a variable that holds code
// Closures can be passed as a paramteter or stored as a property

let vw = UIView()
UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

// UIView has a method called animate()
// Takes 2 params: seconds to animate over and closure to execute as part of the animation
// Needs a closure because UIKit has to prepare the animation, so using the closure lets it store the animation at the beginning and then run it when it's ready

// TRAILING CLOSURES
// Sugar: If the late parameter to a method teakes a closure, you can eliminate that param and instead provide it as a block of code
// For example: the above code simplified

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}




//: Playground - noun: a place where people can play

import UIKit

// OPTIONAL CHAINING
// Unwrapping and checking can be tedious
// Tempting to use ! to unwrap, but if the optional has no value, code will crash
// Optional chaining only lets code run if the optional has a value

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Swift"
    case 2008: return "Wombat"
    case 2010: return "Cat"
    case 2012: return "Blue"
    case 2014: return "1989"
    default: return nil
    }
}

// add uppercased() to make strings all uppercase
// the problem is that albumReleased might return a string or nothing (not unwrapped yet)so we cannot call the function on it straight
// i.e. albumReleased(year: 2006).uppercased()
// Adding a question mark makes it an optional chain (line 29) so the code will only be run if albumReleased has a value
let album1 = albumReleased(year: 2006)
let album = albumReleased(year: 2006)?.uppercased()
print( "The album is \(album)" )

// NIL COALESCING OPERATOR
// Double question mark ??
// Means preferable to use the value before the double question mark, but if you can't, then use the value after
// For album2, no value, so it returns the alternate. For album 3, since we have the NCO it doesn't show "Optional(Swift)"
let album2 = albumReleased(year: 2007) ?? "I don't know"
let album3 = albumReleased(year: 2006) ?? "I don't know"
print("The album is \(album3)")

// ENUMERATIONS
// When you ask for 'weather', you want 'rain' but maybe the user puts 'Rain' or 'Stormy'
// Enumerations let you define a new data type, and the possible values it can hold 
// Then it will only accept those values, anything else will give an error

enum WeatherType {
    case sun, cloudy, rain, wind, snow
}

func getStatus(now: WeatherType) -> String? {
    if now == WeatherType.sun {
        return nil
    } else {
        return "Wear the jacket"
    }
}

getStatus(now: WeatherType.cloudy)

enum SkyType {
    case sun
    case rain
    case snow
}

func weatherResponse(weather: SkyType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .rain:
        return "Get the Cat-Brella"
    default:
        return "Get the Cat-Poncho"
    }
}

// ENUMS WITH ADDITONAL VALUES
// Now in the switch we have extra conditions that will match only if they are true, as well as a modifier to the Long case
// Use the let keyword to access the value inside a case, then 'where' for pattern matching
// If the length of a Long Cat is less than ten, the 3rd switch case will activate, otherwise 4th
// Use 'let' to get hold of the value inside the enum (to declare a constant name you can reference), then a where condition to check
// Swift evaluates switches from top to bottom, so be careful in ordering the cases.

enum CatType {
    case Orange
    case ScottishFold
    case Long(length: Int)
}

func analyzeCat(cat: CatType) -> String? {
    switch cat{
    case .Orange:
        return "A Garfield."
    case .ScottishFold:
        return "Pet you."
    case .Long(let length) where length < 10:
        return "Not that long to be honest"
    case .Long:
        return "Now that is a bigass cat."
    }
}

analyzeCat(cat: CatType.Long(length: 9))
analyzeCat(cat: CatType.Long(length: 10))

// STRUCTS
// Structs are complex data types, made up of multiple values
// Create a struct and fill in its values, then it can be used as a single value

struct Person {
    var clothes: String
    var shoes: String
}

let William  = Person(clothes: "Wombat Casual", shoes: "Jordan 1 Storm Blues")
print(William.shoes)

// assigning one struct to another creates a complete, standalone duplicate of the original
// "Copy on Write" -> Only actually copies the data if you change it
// see below, that changing williamCopy did not change William 

var williamCopy = William
williamCopy.shoes = "Stan Smiths"

print(William)
print(williamCopy)

// CLASSES
// Another way of building complex data types
// Don't get an automatic memberwise initializer; need to be defined
// Classes can be based off other classes
// An instance of a class is an object. If you copy that object, both copies point at the same data
// >>>>>>>>>> UNLIKE STRUCTS, changing one will change the other too <<<<<<<<<<

// Can't write:
// class Person {
//    var clothes: String
//    var shoes: String
// }
// because there are no initial values for clothes or shoes
// With classes, Swift isn't sure that clothes&shoes will be given values, thus error

// INITIALIZING AN OBJECT
// So, the solution to the previous problem is to write an initializer
// Create a function inside the class called init() that takes the necessary parameters

class Animal {
    var legs: Int
    var fur: String
    
    init(legs: Int, fur: String) {
        self.legs = legs
        self.fur = fur
    }
}
// self makes it clear that the legs property of this object should be set to the clothes parameter that was passed in.
// note: a function inside a class such as this one is called a 'method'
// All non-optional properties MUST have a value by the end of the initializer

// CLASS INHERITANCE
// Classes are also different from structs in that they have inheritance.

class Cat {
    var name: String
    var tailLength: Int
    
    init(name: String, tailLength: Int) {
        self.name = name
        self.tailLength = tailLength
    }
    
    func purr() {
        print("Cat: " + self.name +  " makes a prrrrrrrrrrrr sound")
    }
}

var carmen = Cat(name: "Carmen", tailLength: 50)
carmen.name
carmen.purr()

// A basic class of Cat has been defined.
// What about making a BadCat class that has everything Cat has, but the purr function instead "scratches you"?
// Of course don't C+P everything from Cat to BadCat.  Instead make BadCat inherit from Cat so that if something changes in Cat, it will be reflected in BadCat too.

// OVERRIDE METHOD
// BadCat extends Cat below.
// But in order to change the purr function, we need the 'override' keyword
// Override means that we know that the method was implemented by the parent, but I want to change it for the subclass
// Swift won't let you change an inherited parent method without override, and it will return an error if you try to override a method that doesn't exist.

class BadCat: Cat {
    override func purr() {
        print("BadCat: " + self.name + " scratches you!")
    }
}

var tangerine = BadCat(name: "Tangerine", tailLength: 10)
tangerine.purr()

// A new class called WeirdCat that has a new property called 'psychicPower'
// But there are problems
// 1) Cat parent class doesn't have psychicPower, and Swift needs all non-optional properties to have values
// 2) WeirdCat needs to have a custom initializer
// 3) That initializer needs to pass the name/age values to Cat
// 4) Passing data to the superclass is done with a method call, which cannot be done until all properties have values
// 5) So We weed to set psychicPower FIRST and then pass on the parameters for the superclass to use

class WeirdCat : Cat {
    var psychicPower: Int
    
    init(name: String, tailLength: Int, psychicPower: Int) {
        // 3 params here. After setting psychicPower, it will use super.init to pass name & tL to Cat
        self.psychicPower = psychicPower
        // super keyword means to call a method on this class' super. It usually means let the parent class do everything it needs to do first, then this class will do its own stuff.
        super.init(name: name, tailLength: tailLength)
    }
    
    override func purr() {
        print("WeirdCat: My name is \(name), a level \(psychicPower) psychic cat! Fear me!")
    }
}

var purrbus = WeirdCat(name: "Purrbus", tailLength: 1, psychicPower: 69)
purrbus.purr()

// VALUES VS. REFERENCES
// A struct being copied duplicates the whole thing - each struct is indivdual
// Changing one copy of the struct does not change others
// With classes, each copy points at the original opbject, so changing one changes all of them
// Swift calls structs 'value types' becaues they point at a value
// Swift calls classes 'reference types' because objects are shared references to the real value

// WHEN TO USE EACH
// Classes - MORE FLEXIBLE
// Want one shared state that gets passed around and modified in place. You can pass them into functions or store them in arrays, modify them in there, and have it reflected in the rest of the program
// Structs - MORE SAFE
// Want to avoid a shared state where one copy can't affect all the others. Then if you pass them into fucntions or store them in arrays and modify them, they won't change wherever else they are referenced

// Always use structs unless you have a specific reason to use classes. 
//: Playground - noun: a place where people can play

import UIKit

// SWITCH CASE

let number = 2

switch number {
case 0:
    "Yes"
case 1:
    "No"
case 2:
    "Maybe"
default:
    "Perhaps"
}

// 'fallthrough to make one case fall into another'

// FUNCTIONS

func printAMiaou() {
    print("Miaou")
}

//printAMiaou()

func myName(name: String, age: Int) {
    print("My name is \(name) and I am \(age)")
}

//myName(name: "Purrus", age: 2)

// INTERNAL and external parameter names can be different.
func countLettersInString(myString str: String) {
    print("The string \(str) has \(str.characters.count) letters.")
}

//countLettersInString(myString: "Hello")

// Use an underscore if there is no need for an external name
func countLettersInString(_ str: String) {
    print("The string \(str) has \(str.characters.count) letters.")
}

//countLettersInString("Hello")

// SWIFTY WAY OF ARGUMENTS
// external parameter names like in/for/with to read more like natural English
func countLetters(in string: String) {
    print("The string \(string) has \(string.characters.count) letters.")
}

// So when you call the function, it reads like "count letters in Hello"
//countLetters(in: "Hello")

// Returns a different data type
func albumsIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    if name == "Red" { return true }
    if name == "1989" { return true }
    
    return false
}

//if albumsIsTaylor(name: "Red") {
//    print("That's a Swiftie.")
//} else {
//    print("Who made that?!")
//}

// OPTIONALS
// If you don't know whether or not you will need something returned
// In the previous function, -> String was used to imply that a String would definitely be returned
// Therefore, nil could not be returned
// Use optionals to say that nil / string might be returned

func getStatus(weather: String) -> String? {
    if weather == "Rainy" {
        return "Bring umbrella"
    } else {
        return nil
    }
}

func takeAction(status: String) {
    if status == "Bring umbrella" {
        "I am also not wearing my nice shoes"
    }
}

// if let statements check and unwrap in one line of code, which makes them common
// doing this lets us safely unwrap the return value of "getStatus", and only call
// "takeAction()" with a valid, non-optional string.

// HOW I THINK THIS WORKS: this is preventing an error, where if weather != "Rainy", then
// the nil would not cause an error with "takeAction"
// so with the let, the if is not true if "getStatus" is false
// the if statement only "lets" getStatus run and give takeAction info because it has a value, and therefore truthy

if let rainAction = getStatus(weather: "Rainy") {
    takeAction(status: rainAction)
}

// Another Example of Optionals
// The built-in "index of" uses optionals as well
// In my index-finder, you have to remember that -1 is "not found"
// The built-in version uses optionals, and therefore can return nil
var grenouilles = ["Jacquie", "Mamou", "Veletier"]
func position(of string: String, in array: [String]) -> Int {
    for i in 0 ..< array.count {
        if array[i] == string {
            return i
        }
    }
    return -1
}

let jPosition = position(of: "Alexey", in: grenouilles)

grenouilles.index(of: "Alexey")

// FORCE UNWRAPPING OPTIONALS
// Override the safety by using ! if you know that an optional definitely has a value
func bigIf (name: String) -> Int? {
    if name == "Carmen" {return 0}
    if name == "Wombat" {return 69}
    if name == "Cat" {return 1}
    if name == "William" {return 18}
    
    return nil
}

var luckyNum = bigIf(name: "William")

// Without the exclamation mark, this statement would return
// "Lucky Number is Optional(18)". With, simply puts the value.
if luckyNum == nil {
    "Error!"
} else {
    "Lucky Number is \(luckyNum!)"
}

// A regular variable must contain a value, even if it is ""
// An optional variable might or might not contain a value.
// ! up to me to figure out
// User interface elements in UIKit for iOS / macOS are usually implicitly unwrapped variable
// This is to create user interface elements at the last moment to avoid unnecessary work.
// Older Apple APIs are also often implicitly unwrapped because of old standards

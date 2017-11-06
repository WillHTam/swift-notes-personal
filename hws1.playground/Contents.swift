//: Playground - noun: a place where people can play

import UIKit

// Hacking with Swift Part 1


// Simultaneous Declaration of Variable and Type
var name : String = "Wombus"
var name2 = "Cat"

// Types are String, Int, Float, Double
// Double allows more accuracy over Float, but requires more memory

// Concatenation
var both = name + " and " + name2

var a = 1.1
var b = 2.2
var c = a + b

c > 3

name == "wombus"

// Inserting a value
"My name is \(name)"

var age = 25

// Can also write functions inside these
"My name is \(name) and my age is \(age - 5)"


// ARRAYS
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
songs[0]
songs[1]

// TYPE CHECK
type(of: songs)

var songy = [String]()
songy += ["miaou"]
songy[0] = "purr"
songy

// Combine Arrays
var one = ["heya", "kookoo"]
var two = ["hahoo", "hehehs"]
var bouf = one + two
// Add to Array
bouf += ["yeah"]


// DICTIONARY
var deets = [
    "firstname": "Cat",
    "lastname": "Purr",
    "remember": "The Name"
]

deets["remember"]

"I am \(deets["remember"])"

var action: String
var person = "Cat Lover"

// can also use else if 
if person != "Cat Lover" {
    action = "Pet the Cat"
} else {
    action = "Love the Cat"
}

var tired = true
var spacey = false

if tired && !spacey {
    action = "cruise"
}

// Print is similar to console log
// print("1 x 10 is \(1 * 10)")

//for i in 1...10 {
//    print("\(i) x 10 is \(i * 10)")
//}

// If it is not necessary to know which number you're on, can use underscores

//var str = "Fakers gonna"
//for _ in 1...5 {
//    str += " fake"
//}
//print (str)


//  LOOP IN ARRAYS

//for song in songs {
//    print("My favorite song is \(song)")
//}

//var people = ["players", "haters", "heart-breakers", "fakers"]
//var actions = ["play", "hate", "break", "fake"]

//for i in 0 ... 3 {
//    print("\(people[i]) gonna \(actions[i])")
//}

// count array length
songs.count

// INNER LOOP
var people = ["players", "haters", "heart-breakers", "miaouers"]
var actions = ["play", "hate", "break", "miaou"]

for i in 0 ..< people.count {
    var str = "\(people[i]) gonna"
    
    for _ in 1 ... 5 {
        str += " \(actions[i])"
    }
    
    print(str)
}


// WHILE LOOP

var counter = 0

//while true{
//    print ("Counter is now \(counter)")
//    counter += 1
//
//    if counter == 10 {
//        break
//    }
//}

// Continue is the counterpart to break
for song in songs {
    if song == "You Belong with Me" {
        continue
    }
    
    print("My favorite song is \(song)")
}

 

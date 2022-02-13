//
//  SnackBrain.swift
//  Snacklish Storyboards
//
//  Created by Scott Odle on 1/10/22.
//

import Foundation

private let ignoreList = Set([
    "the",
    "of",
    "and",
    "a",
    "to",
    "in",
    "is",
    "you",
    "that",
    "it",
    "it's",
    "it'll",
    "it'd",
    "he",
    "he's",
    "he'll",
    "he'd",
    "she",
    "she's",
    "she'll",
    "she'd",
    "was",
    "for",
    "on",
    "are",
    "as",
    "with",
    "his",
    "they",
    "they're",
    "they've",
    "they'll",
    "they'd",
    "i",
    "i'm",
    "i've",
    "i'll",
    "i'd",
    "you",
    "you've",
    "you'd",
    "at",
    "be",
    "this",
    "from",
    "or",
    "by",
    "what",
    "me"
])
private let fixedRules = [
    "say": "saytisfy",
    "better": "treatter",
    "there": "treatere",
    "if": "fill",
    "you're": "youchewer",
    "true": "chew",
    "us": "chews",
    "use": "chewse",
    "now": "chow",
    "make": "caramakel",
    "know": "knougat",
    "no": "nougat",
    "meme": "yume",
    "my": "yumy",
    "yes": "yumye",
    "snake": "snack",
    "little": "snackittle",
    "sucked": "snacked",
    "six": "snax",
    "storm": "snackstorm",
    "kill": "hungercide",
    "war": "whunger",
    "man": "hungerman",
    "tongue": "tonguegry",
    "noone": "chocone",
    "got": "chocot",
    "hope": "chocopelate",
    "been": "beenut",
    "can": "canut",
    "much": "nutuch",
    "pawn": "pawnuts",
    "none": "nutte",
    "regret": "nutgret",
    "must": "nuts",
    "nine": "ninut",
    "bare": "bar",
    "think": "chomptemplate",
    "time": "chomptime",
    "create": "crunch",
    "created": "crunched",
    "dead": "fed",
    "seven": "sweetven",
    "so": "soweet",
    "eat": "wait",
    "body": "candy",
    "full": "mouthfull",
    "her": "flaveher",
    "four": "flavefour",
    "worst": "flavorst",
    "give": "goodive",
    "pretty": "prettytasty",
    "take": "takesty",
    "state": "substateial",
    "hidden": "hiddenjoy",
    "have": "havisfaction"
]
private let rexRules = [
    //Bite
    (#"[bcdfghjklmnpqrstvwxz](ight|ite)"#, "bite"), // consonant + ight or ite, replace with "bite"
    
    //Chocolate
    (#"(ck|x)\b"#, "$0olate"), //append "olate": ending ck or x
    (#"\b(co|cl|go)"#, "cho$0"), //prepend cho: starting co, cl, or go
    (#"\bo"#, "choco"), //starting o: choco
    
    //Treat
    (#"t\b"#, "$0reat"), //append "reat": words ending with t
    (#"ts\b"#, "treats"), //if the word ends with "ts", replace with "treats"
    (#"tr"#, "treat"), //if "tr" is found in a word, replace with "treat"
    
    //Satisfaction
    (#"\bs"#, "sati$0"), //if the word starts with an s, prepend "sati"
    (#"\b[fpwln]"#, "satis$0"), //if the word begins with a f, p, w, l, n, prepend "satis"
    (#"\b[bcdfghjklmnpqrstvwxz]is"#, "satis"), //if the word begins with any consonant followed by "is", replace with "satis" (miserable => satiserable)
    
    //Delicious
    (#"[aeiouyr]\b"#, "$0licious"), //if the word ends with any vocal or r, append "licious"
    (#"es\b"#, "elicious"), //if the word ends in es, replace with "elicious"
    
    //Satisfaction
    (#"[ts]\b"#, "$0isfaction"), //if the word ends in t or s, append "isfaction"
    (#"er\b"#, "isfaction"), //if the word ends in er, replace with "isfaction"
    (#"\b[bcdfghjklmnpqrstvwxz]ark\b"#, "satis$0tion"), //if the word is made up of a consonant followed by "ark" (i.e. dark), prepend "sati" and append "tion".
    (#"ve\b"#, "visfaction"), //if the word ends in ve, replace with "visfaction"
    
    //Indulge
    (#"\bin"#, "indulg"), //starting in: indulg
    (#"\bd"#, "induld"), //starting d: induld
    (#"in\b"#, "indulge"), //ending in: indulge
    
    //Candy
    (#"\bany"#, "candy"), //starting any: candy
    
    //Eat
    (#"ing\b"#, "eat"), //ending ing: eat
    (#"\bext"#, "eats"), //starting ext: eat
    
    //Bar
    (#"\b(b[e]?|pre|[cdfghjklmnopqrstvwxz]ar)"#, "bar"), //starting b/be/pre and car/dar/far/etc...: bar
    
    //Chomp
    (#"\b(comp|sop?|o?p)"#, "chomp"), //starting p/op/sop/comp: chomp
    
    //Crunch
    (#"\bcont"#, "crunch"), //starting cont: crunch
    
    //Peanut
    (#"p\b"#, "peanut"), //ending p: peanut
    
    //Delectable
    (#"\bbl?"#, "delecta$0"), //prepend delecta: starting b/bl
    (#"(ds?|l)\b"#, "delectable"), //ending d(s) or l: delectable
    
    //Snack
    (#"\b[bcdfghjklmnpqrstwxz]?[ae](ck|k|c|g|t)"#, "snack"), //starting optional consonant + a/e + ck/k/c/g/t: snack
    (#"\b[k]"#, "snack"), //starting k: snack
    
    //Caramel
    (#"\bl"#, "caramel"), //starting l: caramel
    (#"l\b"#, "lamel"), //ending l: lamel
    (#"\b[bcdfghjklmnpqrstvwxz]?(a|e|i)(l|n)"#, "caram$1$2"), //optional starting consonant + a/e/i + l/n, prepend "caram". Examples: always/caramalways, well/caramell, million/caramillion
    (#"med\b"#, "meled"), //ending med: meled, sounds more related: marmalade than caramel though
    
    //Hunger
    (#"\bre"#, "hungry"), //starting re: hungry
    (#"\b(r|gr)"#, "hunger"), //starting r or gr: hunger
    
    //Yum
    (#"\b(m|hun|hum)"#, "yum"), //starting m, hun, or hum: yum
    (#"(em|eam)"#, "eyum"), //em or eam: eyum
    
    //Fill
    (#"\b[bcdfghjklmnpqrstvwxz]{0,3}(al+|il+|el+)"#, "fill"), //replace up: three initial consonants and the following al, il, or el (with any number of l's) with fill
    (#"ls\b"#, "fills"), //if the word ends in ls, replace with fills
    
    //Nougat
    (#"\bt"#, "nougat"), //starting t: nougat
    (#"\bg"#, "noug"), //starting g: to noug
    (#"n\b"#, "nougat"), //ending n: nougat
    (#"\b[bcdfghjklmnpqrstvwxz]ag"#, "noug"), //starting consonant + ag: noug
    (#"\bar"#, "nougar"), //starting ar: nougar
    (#"\bnu\b"#, "nougat"), //middling nu: nougat
    
    //Chew
    (#"\bus"#, "chews"), //replace starting "us" with "chews"
    (#"\bw"#, "chew"), //starting w: chew
    (#"\bup"#, "chewp"), //starting up: chewp
    (#"\btr"#, "chewr"), //replace starting "tr" with "chewr"
    (#"\bun"#, "chewn"), //starting un: chewn
    (#"tur"#, "chewer"), //replace "tur" with "chewer"
    (#"[c^](do|ru|tw|hu|qu|tu|eu)"#, "chew"), //replace do, ru, tw, hu, qu, tu, eu, with chew
    
    //Chow
    (#"[bcdfghjklmnpqrstvwxz](ow|aw)"#, "chow"), //replace any consonant + aw or ow with chow
    
    //Nuts
    (#"net|not"#, "nut"), //net/not: nut
    (#"ous"#, "nuts"), //ous/nt nut
    (#"nt\b"#, "nut"), //ending nt: nut
    (#"nt"#, "nutt"), //nt: nutt
    (#"\bun"#, "nut"), //starting un: nut
    (#"t\b"#, "nut") //ending t: nut
]

private func convertWord(word: String) -> String {
    if ignoreList.contains(word) {
        return word
    }
    
    if let fixedReplacement = fixedRules[word] {
        return fixedReplacement
    }
    
    let matchingRexRules = rexRules.filter { rexRule in
        word.range(of: rexRule.0, options: .regularExpression) != nil
    }.shuffled()
    if let firstMatch = matchingRexRules.first {
        let rex = firstMatch.0
        let replace = firstMatch.1
        return word.replacingOccurrences(of: rex, with: replace, options: .regularExpression)
    }
    
    return word
}

private func preserveCase(word: String, original: String) -> String {
    if original == original.lowercased() {
        return word
    } else if original == original.uppercased() {
        return word.uppercased()
    } else if original == original.capitalized {
        return word.capitalized
    } else {
        return word
    }
}

struct Snack {
    var input: String
    
    func snacklify() -> String {
        let wordPattern = #"[\w']+"#
        do {
            let wordRegex = try NSRegularExpression(pattern: wordPattern, options: [])
            let textRange = NSRange(input.startIndex..<input.endIndex, in: input)
            return wordRegex.matches(in: input, options: [], range: textRange).map { result in
                let wordRange = Range(result.range, in: input)!
                let word = String(input[wordRange])
                
                let convertedWord = convertWord(word: word)
                let casedWord = preserveCase(word: convertedWord, original: word)
                return casedWord
            }.joined(separator: " ")
        } catch {
            fatalError("Can't convert!")
        }
    }
}

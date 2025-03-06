//
// Pluralize.swift
// link:
//     https://github.com/joshualat/Pluralize.swift
//
// usage:
//     "Tooth".pluralize
//     "Nutrtion".pluralize
//     "House".pluralize(count: 1)
//     "Person".pluralize(count: 2, template: "Persons")
//
// Copyright (c) 2014 Joshua Arvin Lat
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
import Foundation

@globalActor actor Pluralize {
    public static let shared = Pluralize()
    
    private var uncountables:[String] = []
    private var rules:[(rule: String, template: String)] = []
    
    private init() {
        uncountables = [
            "access", "accommodation", "adulthood", "advertising", "advice",
            "aggression", "aid", "air", "alcohol", "anger", "applause",
            "arithmetic", "art", "assistance", "athletics", "attention",
            "bacon", "baggage", "ballet", "beauty", "beef", "beer", "biology",
            "botany", "bread", "butter", "carbon", "cash", "chaos", "cheese",
            "chess", "childhood", "clothing", "coal", "coffee", "commerce",
            "compassion", "comprehension", "content", "corruption", "cotton",
            "courage", "currency", "dancing", "danger", "data", "delight",
            "dignity", "dirt", "distribution", "dust", "economics", "education",
            "electricity", "employment", "engineering", "envy", "equipment",
            "ethics", "evidence", "evolution", "faith", "fame", "fish", "flour", "flu",
            "food", "freedom", "fuel", "fun", "furniture", "garbage", "garlic",
            "genetics", "gold", "golf", "gossip", "grammar", "gratitude", "grief",
            "ground", "guilt", "gymnastics", "hair", "happiness", "hardware",
            "harm", "hate", "hatred", "health", "heat", "height", "help", "homework",
            "honesty", "honey", "hospitality", "housework", "humour", "hunger",
            "hydrogen", "ice", "ice", "cream", "importance", "inflation", "information",
            "injustice", "innocence", "iron", "irony", "jealousy", "jelly", "judo",
            "karate", "kindness", "knowledge", "labour", "lack", "laughter", "lava",
            "leather", "leisure", "lightning", "linguistics", "litter", "livestock",
            "logic", "loneliness", "luck", "luggage", "machinery", "magic",
            "management", "mankind", "marble", "mathematics", "mayonnaise",
            "measles", "meat", "methane", "milk", "money", "mud", "music", "nature",
            "news", "nitrogen", "nonsense", "nurture", "nutrition", "obedience",
            "obesity", "oil", "oxygen", "passion", "pasta", "patience", "permission",
            "physics", "poetry", "pollution", "poverty", "power", "pronunciation",
            "psychology", "publicity", "quartz", "racism", "rain", "relaxation",
            "reliability", "research", "respect", "revenge", "rice", "rubbish",
            "rum", "salad", "satire", "seaside", "shame", "shopping", "silence",
            "sleep", "smoke", "smoking", "snow", "soap", "software", "soil",
            "sorrow", "soup", "speed", "spelling", "steam", "stuff", "stupidity",
            "sunshine", "symmetry", "tennis", "thirst", "thunder", "toast",
            "tolerance", "toys", "traffic", "transporation", "travel", "trust", "understanding",
            "unemployment", "unity", "validity", "veal", "vengeance", "violence"]
        
        rules.insert((rule: "$", template: "$1s"), at: 0)
        rules.insert((rule: "s$", template: "$1ses"), at: 0)
        rules.insert((rule: "(t|r|l|b)y$", template: "$1ies"), at: 0)
        rules.insert((rule: "x$", template: "$1xes"), at: 0)
        rules.insert((rule: "(sh|zz|ss)$", template: "$1es"), at: 0)
        rules.insert((rule: "(ax)is", template: "$1es"), at: 0)
        rules.insert((rule: "(cact|nucle|alumn|bacill|fung|radi|stimul|syllab)us$", template: "$1i"), at: 0)
        rules.insert((rule: "(corp)us$", template: "$1ora"), at: 0)
        rules.insert((rule: "sis$", template: "$1ses"), at: 0)
        rules.insert((rule: "ch$", template: "$1ches"), at: 0)
        rules.insert((rule: "o$", template: "$1os"), at: 0)
        rules.insert((rule: "(buffal|carg|mosquit|torped|zer|vet|her|ech)o$", template: "$1oes"), at: 0)
        rules.insert((rule: "fe$", template: "$1ves"), at: 0)
        rules.insert((rule: "(thie)f$", template: "$1ves"), at: 0)
        rules.insert((rule: "oaf$", template: "$1oaves"), at: 0)
        rules.insert((rule: "um$", template: "$1a"), at: 0)
        rules.insert((rule: "ium$", template: "$1ia"), at: 0)
        rules.insert((rule: "oof$", template: "$1ooves"), at: 0)
        rules.insert((rule: "(nebul)a", template: "$1ae"), at: 0)
        rules.insert((rule: "(criteri|phenomen)on$", template: "$1a"), at: 0)
        rules.insert((rule: "(potat|tomat|volcan)o$", template: "$1oes"), at: 0)
        rules.insert((rule: "^(|wo|work|fire)man$", template: "$1men"), at: 0)
        rules.insert((rule: "(f)oot$", template: "$1eet"), at: 0)
        rules.insert((rule: "lf$", template: "$1lves"), at: 0)
        rules.insert((rule: "(t)ooth$", template: "$1eeth"), at: 0)
        rules.insert((rule: "(g)oose$", template: "$1eese"), at: 0)
        rules.insert((rule: "^(c)hild$", template: "$1hildren"), at: 0)
        rules.insert((rule: "^(o)x$", template: "$1xen"), at: 0)
        rules.insert((rule: "^(p)erson$", template: "$1eople"), at: 0)
        rules.insert((rule: "(m|l)ouse$", template: "$1ice"), at: 0)
        rules.insert((rule: "^(d)ie$", template: "$1ice"), at: 0)
        rules.insert((rule: "^(alg|vertebr|vit)a$", template: "$1ae"), at: 0)
        rules.insert((rule: "^(a)lumna$", template: "$1lumnae"), at: 0)
        rules.insert((rule: "^(a)pparatus$", template: "$1pparatuses"), at: 0)
        rules.insert((rule: "^(ind)ex$", template: "$1ices"), at: 0)
        rules.insert((rule: "^(append|matr)ix$", template: "$1ices"), at: 0)
        rules.insert((rule: "^(b|tabl)eau$", template: "$1eaux"), at: 0)
        rules.insert((rule: "arf$", template: "$1arves"), at: 0)
        rules.insert((rule: "(embarg)o$", template: "$1oes"), at: 0)
        rules.insert((rule: "(gen)us$", template: "$1era"), at: 0)
        rules.insert((rule: "(r)oof$", template: "$1oofs"), at: 0)
        rules.insert((rule: "(l)eaf$", template: "$1eaves"), at: 0)
        rules.insert((rule: "(millen)ium$", template: "$1ia"), at: 0)
        rules.insert((rule: "(th)at$", template: "$1ose"), at: 0)
        rules.insert((rule: "(th)is$", template: "$1ese"), at: 0)
        
        uncountables.insert("sheep", at: 0)
        uncountables.insert("deer", at: 0)
        uncountables.insert("moose", at: 0)
        uncountables.insert("swine", at: 0)
        uncountables.insert("bison", at: 0)
        uncountables.insert("corps", at: 0)
        uncountables.insert("means", at: 0)
        uncountables.insert("series", at: 0)
        uncountables.insert("scissors", at: 0)
        uncountables.insert("species", at: 0)
    }
    
    @Pluralize public static func apply(word: String) async -> String {
        if await shared.uncountables.contains(word.lowercased()) || String(word).count == 0 {
            return word
        } else {
            for pair in await shared.rules {
                let newValue = regexReplace(input: word, pattern: pair.rule, template: pair.template)
                if newValue != word {
                    return newValue
                }
            }
        }
        
        return word
    }
    
    @Pluralize public static func rule(rule: String, with template: String) async {
        await shared.rule(rule: rule, with: template)
    }
    
    @Pluralize public static func uncountable(word: String) async {
        await shared.uncountable(word: word)
    }
    
    @Pluralize public static func unchanging(word: String) async {
        await shared.unchanging(word: word)
    }
    
    private static func regexReplace(input: String, pattern: String, template: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSMakeRange(0, String(input).count)
        let output = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: template)
        return output
    }
    
   private func rule(rule: String, with template: String) {
        rules.insert((rule: rule, template: template), at: 0)
    }
    
    private func uncountable(word: String) {
        uncountables.insert(word.lowercased(), at: 0)
    }
    
    private func unchanging(word: String) {
        uncountables.insert(word.lowercased(), at: 0)
    }
}

extension String {
    public func pluralize(count: Int = 2, with: String = "") -> String {
        let semaphore = DispatchSemaphore(value: 0)
        var result = self
        
        Task {
            result = await pluralize(count: count, with: with)
            
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return result
    }
    
    @Pluralize public func pluralize(count: Int = 2, with: String = "") async -> String {
        if count == 1 {
            return self
        } else {
            if with.length != 0 {
                return with
            } else {
                return await Pluralize.apply(word: self)
            }
        }
    }
    
    // Workaround to allow us to use `count` as an argument name in pluralize() above.
    private var length: Int {
        return String(self).count
    }
}


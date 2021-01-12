//
//  Constants.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 16.11.20.
//

import UIKit


//Fallback Data
let FAMILY_NO_VERNACULAR = "NONE"
let FAMILY_NO_DESCRIPTION = "NONE"
let WARNING_CELLULAR_NEVER_SHOW_AGAIN = "WARNING_CELLULAR_NEVER"

//Colors
let pondColor = UIColor(hexString: "3498db")
let textTintColor = UIColor(hexString: "FFFFFF")

let greenColor = UIColor(hexString: "2ecc71")
let yellowColor = UIColor(hexString: "f1c40f")
let redColor = UIColor(hexString: "e74c3c")
let categoyHeaderColor = UIColor.black

let placeHolderColor = UIColor(white: 1, alpha: 0.5)
let backGroundColor = pondColor
let backGroundColor2 = UIColor(hexString: "ecf0f1")

let pinColor = pondColor
let circleFillColor = pondColor
let circleStrokeColor = UIColor.white

let skeletonColor = pondColor

let defaultCornerRadius = CGFloat(15.0)

//Classification
let classifications:Dictionary<Int, Classification> = [
    //Red
    484724:Classification(danger: .edRed, explanation: "Stings from several Species in the family of the Box Jellyfish are extremely painful and can be fatal to humans"),
    135342:Classification(danger: .edRed, explanation: "The Portuguese man o' war has numerous venomous microscopic nematocysts which deliver a painful sting powerful enough to kill fish, and has been known to occasionally kill humans"),
    105742:Classification(danger: .edRed, explanation: "Of all shark species, the great white shark is responsible for by far the largest number of recorded shark bite incidents on humans"),
    135479:Classification(danger: .edRed, explanation: "The Portuguese man o' war has numerous venomous microscopic nematocysts which deliver a painful sting powerful enough to kill fish, and has been known to occasionally kill humans"),
    344030:Classification(danger: .edRed, explanation: "The saltwater crocodile has a long history of attacking humans who unknowingly venture into its territory"),
    105838:Classification(danger: .edRed, explanation: "Of all shark species, the great white shark is responsible for by far the largest number of recorded shark bite incidents on humans"),
    105799:Classification(danger: .edRed, explanation: "Although sharks rarely bite humans, the tiger shark is reported to be responsible for a large share of fatal shark-bite incidents, and is regarded as one of the most dangerous shark species"),
    //Yellow
    10209:Classification(danger: .edYellow, explanation: "Species in the Order of the Mackerel Sharks rarely attack humans, however their size and teeth make them potentially dangerous."),
    266989:Classification(danger: .edYellow, explanation: "Stings from several Species in the Order of the Box Jellyfish are extremely painful"),
    196069:Classification(danger: .edYellow, explanation: "Stingrays generally do not attack aggressively or even actively defend themselves. However, when attacked by predators or stepped on, the stinger in their tail is whipped up."),
    105702:Classification(danger: .edYellow, explanation: "This species will not generally attack humans and does not seem to treat them as prey. Most modern attacks involving shortfin mako sharks are considered to have been provoked due to harassment or the shark being caught on a fishing line"),
    105689:Classification(danger: .edYellow, explanation: "Species in the Family of the Requiem Sharks (Except Tiger and Bull Sharks, they are labeled dangerous) rarely attack humans, however their size and teeth make them potentially dangerous."),
    105694:Classification(danger: .edYellow, explanation: "Species in the Family of the Hammerhead Sharks rarely attack humans, however their size and teeth make them potentially dangerous."),
    125595:Classification(danger: .edYellow, explanation: "Scorpionfish are equipped with spines containing dangerous venom. A sting from one of these spines can be potentially fatal to other animals and extremely painful to humans."),
    154251:Classification(danger: .edYellow, explanation: "Stonefish are equipped with spines containing dangerous venom. A sting from one of these spines can be potentially fatal to other animals and extremely painful to humans."),
    196202:Classification(danger: .edYellow, explanation: "The Crown of Thorns Starfish's spines contain neurotoxins and starfish poison that are dangerous to both humans and marine creatures"),
    135239:Classification(danger: .edYellow, explanation: "Human encounters with the Lion's mane jellyfish can cause temporary pain and localized redness"),
    14107:Classification(danger: .edYellow, explanation: "All cone snails are venomous and capable of stinging humans, live ones should never be handled, as their venomous sting will occur without warning and can be fatal"),
    125431:Classification(danger: .edYellow, explanation: "The Moray Eel is vicious when disturbed and will attack humans. The jaws of the moray eel are equipped with strong, sharp teeth, enabling them to seize hold of their prey and inflict serious wounds"),
    125451:Classification(danger: .edYellow, explanation: "Needlefish, like all ray-finned beloniforms, are capable of making short jumps out of the water at up to 60 km/h (37 mph). Their sharp beaks are capable of inflicting deep puncture wounds, often breaking off inside the victim in the process"),
    342638:Classification(danger: .edYellow, explanation: "Sea snakes are not aggressive, although if they feel threatened or surprised, a venomous bite can occur"),
    413301:Classification(danger: .edYellow, explanation: "Sea snakes are not aggressive, although if they feel threatened or surprised, a venomous bite can occur"),
    341430:Classification(danger: .edYellow, explanation: "Despite their small size—12 to 20 cm (5 to 8 in)—and relatively docile nature, Blue-ringed octopus are dangerous to humans if provoked when handled because their venom contains the powerful neurotoxin tetrodotoxin"),
    205902:Classification(danger: .edYellow, explanation: "Fire corals have nematocysts (barbed, threadlike tubes that deliver a toxic sting) and some have sharp edges that cause lacerations or abrasions"),
    123391:Classification(danger: .edYellow, explanation: "Among the creatures that are venomous but don't pose all that great a danger are a few species of the many types sea urchins. Those with poisonous spines include the Echinothuridae, Toxopneustes, and Tripneustes species"),
    135261:Classification(danger: .edYellow, explanation: "The sting of the sea nettle is not usually dangerous to humans, though it can be painful. However, some people have an allergy to the venom and can suffer serious reactions from it."),
    206646:Classification(danger: .edYellow, explanation: "The sting of the sea nettle is not usually dangerous to humans, though it can be painful. However, some people have an allergy to the venom and can suffer serious reactions from it."),
    135306:Classification(danger: .edYellow, explanation: "The Moon jellyfish falls into the category of being slightly venomous. Contact can lead to prickly sensations to mild burning"),
    291140:Classification(danger: .edYellow, explanation: "Although cannonball jellyfish are not known for stinging humans, the toxin from a cannonball can cause cardiac problems in both humans and animals alike"),
    219890:Classification(danger: .edYellow, explanation: "If approached the Lagoon Triggerfish will raise this spine as a warning, if ignored they may charge, even divers!"),
    219875:Classification(danger: .edYellow, explanation: "If approached the Titan Triggerfish will raise this spine as a warning, if ignored they may charge, even divers!"),
    135305:Classification(danger: .edYellow, explanation: "Stinging incidents are common, painful and the symptoms may continue for a considerable time after the encounter, but they are generally not dangerous"),
    135301:Classification(danger: .edYellow, explanation: "Stinging incidents are common, painful and the symptoms may continue for a considerable time after the encounter, but they are generally not dangerous"),
    135304:Classification(danger: .edYellow, explanation: "Stinging incidents are common, painful and the symptoms may continue for a considerable time after the encounter, but they are generally not dangerous"),
    ]

//Filtered Taxons
let filteredTaxons = [
    4, //Fungi
    5, 6, //Bacteria
    7, 8, //Single Cells
    801, 852, //Algae
    882, //Worms
    155670, //Water fleas
    146420, //Sea squirts
    889925, //Hexanauplia - small crustaceans
    845957, //Superclass of small crustaceans
    1069,   //Class of small crustaceans
    123084, //Class of Brittle Stars
    1836,   //Class of Birds
]

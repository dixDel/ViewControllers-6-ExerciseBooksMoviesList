//
//  FakeDatabase.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 05/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation
import UIKit

enum Genres: String, CaseIterable {
    case SciFi = "Sci-Fi"
    case Action
    case Aventure
    case Comedy = "Comédie"
    case X //JE LE SAVAIS
    case Fantasy = "Fantastique"
    case Historical = "Historique"
    case A = "Tous"
    case Drama = "Drame"
    case NIL = ""
}

class FakeDatabase {
    
    var authors = [
        Author(name: "Isaac Asimov", picture: #imageLiteral(resourceName: "liv tyler")),
        Author(name: "J.R.R. Tolkien"),
        Author(name: "Waf Dixney", picture: #imageLiteral(resourceName: "liv tyler")),
        Author(name: "Mel Gibson", picture: #imageLiteral(resourceName: "liv tyler")),
        Author(name: "James Cameron"),
        Author(name: "Wouf Dicksney"),
        Author(name: "Andrew Niccol"),
        Author(name: "David Fincher"),
        Author(name: "Martin Scorsese"),
        Author(name: "")
    ]
    
    var movies = [
        Movie(name: "Terminator 2", picture: #imageLiteral(resourceName: "terminator2"), year: 1991, genres: [
            Genres.SciFi,
            Genres.Action
        ], authors: [Author(name: "James Cameron")]),
        Movie(name: "Blanche-Neige et les septs mains", picture: #imageLiteral(resourceName: "Blanche-Neige"), genres: [Genres.X], authors: [Author(name: "Waf Dixney"), Author(name: "Wouf Dicksney")]),
        Movie(name: "Gattaca", picture: #imageLiteral(resourceName: "Gattaca"), year: 1997, genres: [Genres.SciFi], authors: [Author(name: "Andrew Niccol")]),
        Movie(name: "Fight Club", picture: #imageLiteral(resourceName: "fight club"), year: 1999, authors: [Author(name: "David Fincher")]),
        Movie(name: "Goodfellas", picture: #imageLiteral(resourceName: "goodfellas"), year: 1990, genres: [Genres.Drama], authors: [Author(name: "Martin Scorsese")]),
        Movie(name: "Braveheart", picture: #imageLiteral(resourceName: "braveheart"), year: 1995, genres: [Genres.Action, Genres.Historical, Genres.Aventure], description: "Au XIIIe siècle, Édouard Ier d'Angleterre, surnommé Longshanks (« aux longues jambes ») mais aussi The Hammer of Scots par les Anglais, occupe une bonne partie du sud de l'Écosse. Son oppression conduit à la mort du père et du frère du jeune William Wallace. Des années plus tard, après que Wallace a été élevé à l'étranger par son oncle, les Écossais continuent de vivre sous les lois cruelles d'Édouard Ier. Wallace revient dans son village natal avec l'intention de vivre comme paysan et d'éviter de s'impliquer dans les troubles qui agitent le pays. Il retrouve son amie et amour d'enfance, Murron MacClannough, à laquelle il montre le chardon, soigneusement préservé, qu'elle lui avait donné quand ils étaient enfants. Les deux jeunes gens se marient en secret afin d'éviter le décret du noctis primae (droit de la « première nuit ») que le roi a énoncé. Plus tard, quand un soldat anglais brutalise Murron et tente de la violer, Wallace vole à son secours. Il l'aide à monter à cheval pour qu'elle s'échappe pendant qu'il retient les soldats. Mais elle est finalement capturée et le shérif lui coupe la gorge en public, en proclamant : « une attaque contre les soldats du roi est pareille à une attaque contre le roi lui-même ». En représailles, Wallace, bientôt rejoint par les villageois, massacre la garnison anglaise et tranche la gorge du shérif à l'endroit même où celui-ci a tué Murron, et avec le même poignard. Ainsi débute la quête de Wallace pour l'indépendance de l'Écosse.\nQuand Édouard Ier apprend la nouvelle de la rébellion de Wallace, il charge son fils, le premier prince de Galles de l'Histoire, également prénommé Édouard, d'y mettre fin. Le prince Édouard est marié à Isabelle de France mais la délaisse car il est homosexuel. Pendant ce temps, Wallace et ses troupes multiplient les coups d'éclat et de nouvelles forces se joignent à lui au fur et à mesure que sa renommée grandit. Wallace inflige une cuisante défaite à l'armée anglaise envoyée contre lui lors de la bataille de Stirling. Il met ensuite à sac la cité d'York. Wallace cherche également à obtenir le soutien de Robert Bruce, solide prétendant au trône d'Écosse, mais celui-ci, malgré son admiration pour Wallace, est très influencé par son père, lépreux, qui le presse de soutenir Wallace officiellement tout en restant secrètement proche des Anglais.\nDevant l'ampleur que prend la rébellion, Édouard Ier envoie la princesse Isabelle négocier la paix avec Wallace. Celui-ci refuse l'or, les titres et les terres qui lui sont offerts en échange de sa soumission et fait forte impression sur Isabelle, qui s'attendait à rencontrer un barbare assoiffé de sang et non un homme cultivé. Plus tard, apprenant qu'Édouard Ier prépare une attaque surprise contre Wallace, Isabelle envoie sa servante le prévenir du danger. Wallace tente d'unir les nobles écossais contre les Anglais mais, sur le champ de bataille de Falkirk, il est trahi par les nobles Lochlan et Mornay. Les Écossais sont vaincus et Wallace découvre que Robert Bruce était dans l'état-major anglais. Il refuse néanmoins de le tuer et Bruce, saisi de remords, lui permet d'échapper à la capture. Wallace tue ensuite Lochlan et Mornay en représailles et mène désormais une guérilla contre les Anglais. Édouard Ier fait tendre une embuscade à Wallace par ses tueurs, mais prévenu à nouveau par Isabelle, il déjoue le piège et fait brûler vifs les tueurs anglais. Il retrouve Isabelle qui tombe sous son charme et couche avec lui, découvrant l'amour que son époux Édouard ne lui a pas donné.\nRobert Bruce est désormais désireux de joindre ses forces à celles de Wallace mais, lors d'une rencontre organisée entre eux deux, le père de Bruce et d'autres nobles écossais les trahissent. Wallace est capturé et livré aux Anglais alors que Bruce renie son père. Wallace est emmené à Londres et condamné à mort pour haute trahison, tandis qu'Édouard Ier est désormais gravement malade et proche de la fin. Isabelle, venue voir Wallace en prison, lui offre de s'empoisonner pour échapper à la torture mais il refuse. Isabelle apprend au roi, désormais incapable de parler, que l'enfant qu'elle attend, a priori le futur Édouard III d'Angleterre, est de Wallace, et lui promet de mettre un terme à sa lignée. Wallace subit publiquement une terrible torture mais refuse d'implorer la grâce du roi. Au lieu de crier « Pitié » pour que cessent ses tourments, il hurle « Liberté », ce qu'entend le roi d'Angleterre, et les deux personnages meurent en même temps, Wallace décapité à la hache et le roi sur son lit.\nDes années plus tard, Robert Bruce refuse de se soumettre à une armée anglaise et, invoquant la mémoire de Wallace, mène les Écossais à une écrasante victoire à la bataille de Bannockburn face à Édouard II d'Angleterre, assurant l'indépendance temporaire de l'Écosse.", authors: [Author(name: "Mel Gibson")])
    ]
    
    var books = [Book]()
    
    init() {
        self.books.append(contentsOf: [
            Book(title: "Fondation", picture: #imageLiteral(resourceName: "Fondation-Asimov"), authors: [self.authors[0]]),
            Book(title: "Le Seigneur des anneaux", picture: #imageLiteral(resourceName: "seigneur anneaux"), authors: [self.authors[1]], genres: [Genres.Fantasy])
        ])
    }
}

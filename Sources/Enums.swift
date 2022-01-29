//
//  Enums.swift
//  JAlert
//
//  Created by 장효원 on 2022/01/02.
//

import UIKit

public enum ElementType{
    case title
    case message
    case submit
    case date
    case image
}

public enum AlertType{
    case `default`
    case confirm
    case submit
    case date
    case image
    case multi
}

//MARK: - Language
public enum Language:String{
    case ko_KR = "ko_KR"
    case ja_JP = "ja_JP"
    case en_US = "en_US"
    case fr_FR = "fr_FR"
    case en_GB = "en_GB"
    case de_DE = "de_DE"
    case it_IT = "it_IT"
    case nl_NL = "nl_NL"
    case nl_BE = "nl_BE"
    case sv_SE = "sv_SE"
    case es_ES = "es_ES"
    case fr_CH = "fr_CH"
    case de_CH = "de_CH"
    case en_AU = "en_AU"
    case zh_CN = "zh_CN"
    case zh_TW = "zh_TW"
}


//MARK: - Animation
public enum AppearType {
    case `default`
    case scale
}

public enum DisappearType {
    case `default`
    case scale
}

//
//  FeelModel.swift
//  HTG
//
//  Created by 송영모 on 9/18/24.
//

import Foundation

public enum FeelModel: CaseIterable {
    public static var allCases: [FeelModel] = [] + Positive.allCases.map {.positive($0)} + Negative.allCases.map {.negative($0)} + ETC.allCases.map {.etc($0)}
    
    case positive(Positive)
    case negative(Negative)
    case etc(ETC)
    
    public var title: String {
        switch self {
        case .positive(let positive):
            return positive.rawValue
        case .negative(let negative):
            return negative.rawValue
        case .etc(let etc):
            return etc.rawValue
        }
    }
    
    public enum Positive: String, CaseIterable {
        case happy = "행복"
        case excited = "신남"
        case joyful = "즐거움"
        case content = "만족"
        case relaxed = "편안함"
        case satisfied = "흐뭇함"
        case proud = "자부심"
        case confident = "자신감"
        case hopeful = "희망"
        case amused = "재미있음"
        case inspired = "영감"
        case grateful = "감사"
        case love = "사랑"
        case peaceful = "평화로움"
        case optimistic = "낙관적임"
        case enthusiastic = "열정적임"
        case curious = "호기심"
        case courageous = "용기"
        case energetic = "활기참"
        case successful = "성공적임"
        case accepted = "인정받음"
        case appreciated = "감사받음"
        case cheerful = "쾌활함"
        case empowered = "힘이 남"
        case fulfilled = "충족감"
        case playful = "장난기"
        case serene = "고요함"
        case secure = "안정감"
        case affectionate = "애정"
        case compassionate = "연민"
        case delighted = "기쁨"
        case elated = "의기양양"
        case eager = "열망"
        case fascinated = "매료됨"
        case refreshed = "상쾌함"
        case vibrant = "생기있음"
        case thrilled = "흥분됨"
        case marvelous = "경이로움"
        case zealous = "열성적임"
        case ecstatic = "황홀함"
        case blissful = "더없는 행복"
        case splendid = "화려함"
        case fortunate = "운이 좋음"
        case overjoyed = "크게 기뻐함"
        case radiant = "빛남"
        case lively = "활발함"
        case spirited = "기백이 넘침"
        case triumphant = "승리감"
        case harmonious = "조화로움"
    }
    
    public enum Negative: String, CaseIterable {
        case sad = "슬픔"
        case angry = "분노"
        case afraid = "두려움"
        case anxious = "불안"
        case depressed = "우울함"
        case frustrated = "좌절"
        case disappointed = "실망"
        case lonely = "외로움"
        case stressed = "스트레스"
        case bored = "지루함"
        case jealous = "질투"
        case guilty = "죄책감"
        case ashamed = "수치심"
        case embarrassed = "당황"
        case hurt = "상처"
        case overwhelmed = "압도됨"
        case nervous = "긴장"
        case insecure = "불안정"
        case confused = "혼란"
        case resentful = "원망"
        case rejected = "거절당함"
        case irritated = "짜증"
        case fatigued = "피로"
        case bitter = "쓴맛"
        case helpless = "무력함"
        case hostile = "적대적임"
        case grief = "비탄"
        case panic = "공황"
        case regret = "후회"
        case miserable = "비참함"
        case annoyed = "성가심"
        case exhausted = "기진맥진"
        case hopeless = "절망"
        case devastated = "황폐함"
        case furious = "격노"
        case fearful = "겁먹음"
        case skeptical = "회의적임"
        case distrustful = "불신"
        case envious = "선망"
        case humiliated = "굴욕"
        case hesitant = "주저함"
        case agitated = "동요"
        case disturbed = "불안함"
        case paranoid = "편집증적임"
        case pessimistic = "비관적임"
        case vulnerable = "취약함"
        case withdrawn = "물러남"
        case dismayed = "경악"
    }
    
    public enum ETC: String, CaseIterable {
        case neutral = "중립"
        case surprised = "놀람"
        case indifferent = "무관심"
        case numb = "무감각"
        case blank = "멍함"
        case apathetic = "냉담함"
        case pensive = "수심"
        case conflicted = "갈등"
        case nostalgic = "향수"
        case ambivalent = "양가감정"
        case reserved = "내성적임"
        case contemplative = "사색적임"
        case perplexed = "당혹"
        case curious = "호기심"
        case skeptical = "회의적임"
        case intrigued = "흥미로움"
        case bewildered = "어리둥절함"
        case analytical = "분석적임"
        case detached = "무심함"
        case inquisitive = "탐구적임"
        case meditative = "명상적임"
        case reflective = "반성적임"
        case uncertain = "불확실함"
        case mellow = "온화함"
        case calm = "차분함"
        case thoughtful = "사려깊음"
        case observant = "관찰력있음"
        case cautious = "조심스러움"
        case wary = "경계함"
        case anticipatory = "기대감"
        case alert = "경계"
        case hesitant = "망설임"
        case expectant = "기대하는"
        case preoccupied = "몰두함"
        case disoriented = "혼란스러움"
        case dubious = "의심스러움"
        case nonchalant = "태연함"
    }
}

//
//  DomansData.swift
//  Rently
//
//  Created by Hany Alkahlout on 10/10/24.
//



// MARK: - DomansData
struct DomansData: Codable {
    let resultSt: String?
    let resultData: ResultData?

    enum CodingKeys: String, CodingKey {
        case resultSt = "RESULT_ST"
        case resultData = "RESULT_DATA"
    }
}

// MARK: - ResultData
struct ResultData: Codable {
    let siteInfoSeq: String?
    let agentSeq, siteSeq: Int?
    let uniqueKey: String?
    let siteName: String?
    let boardCategorySeq: Int?
    let pcFavicon, mobileFavicon, domainThemeSeq, metaImageURL: String?
    let defaultJoinSeq: Int?
    let defaultJoinCode, telegramReturnURL, telegramBotID, telegramBotToken: String?
    let themeYn, vipYn, loginYn, googleAnalytics: String?
    let googleAnalyticsKey, googleAnalyticsTag: String?
    let domainURL: String?

    enum CodingKeys: String, CodingKey {
        case siteInfoSeq = "site_info_seq"
        case agentSeq = "agent_seq"
        case siteSeq = "site_seq"
        case uniqueKey = "unique_key"
        case siteName = "site_name"
        case boardCategorySeq = "board_category_seq"
        case pcFavicon = "pc_favicon"
        case mobileFavicon = "mobile_favicon"
        case domainThemeSeq = "domain_theme_seq"
        case metaImageURL = "meta_image_url"
        case defaultJoinSeq = "default_join_seq"
        case defaultJoinCode = "default_join_code"
        case telegramReturnURL = "telegram_return_url"
        case telegramBotID = "telegram_bot_id"
        case telegramBotToken = "telegram_bot_token"
        case themeYn = "theme_yn"
        case vipYn = "vip_yn"
        case loginYn = "login_yn"
        case googleAnalytics = "google_analytics"
        case googleAnalyticsKey = "google_analytics_key"
        case googleAnalyticsTag = "google_analytics_tag"
        case domainURL = "domain_url"
    }
}

//
//  AccessToken.swift
//  SpotifyWebAPI
//
//  Created by Riccardo Runci on 13/02/2020.
//  Copyright © 2020 Riccardo Runci. All rights reserved.
//

// MARK: - AccessToken
public struct AccessToken: Codable {
    public var accessToken: String?
    public var expiresIn: Int?
    public var refreshToken: String?
    public var tokenType: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}

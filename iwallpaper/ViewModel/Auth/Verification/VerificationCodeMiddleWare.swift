//
//  VerificationCodeMiddleWare.swift
//  iwallpaper
//
//  Created by Selim on 24.10.2024.
//
import Foundation

struct VerificationCodeMiddleWare{
    
//    let apiKey = "f18ba00ece6dec5937930f441af304de6c0786e7158e113dbd9964ecc701e693"
    
    func sendEmail(email: String, code: String){
    
        var smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "iwallpaper06@gmail.com"
        smtpSession.password = "zxqx chxy dfug twdx"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = { (connectionID, type, data) in
            if let string = String(data: data ?? Data(), encoding: .utf8) {
                print("Connection logger: \(string)")
            }
        }

        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "\(email)", mailbox: "\(email)")]
        builder.header.from = MCOAddress(displayName: "Info@Iwallpaper.com", mailbox: "\(smtpSession.username)")
        builder.header.subject = "Verification Code"
        builder.htmlBody = "Your verification code is : \(code)"

        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) in
            if let error = error {
                print("E-posta gönderme hatası: \(error)")
            } else {
                print("E-posta başarıyla gönderildi!")
            }
        }

        
    }
 
    
    func createCode() -> String
    {
        return String(Int.random(in: 1000...9999) )
    }
    
}

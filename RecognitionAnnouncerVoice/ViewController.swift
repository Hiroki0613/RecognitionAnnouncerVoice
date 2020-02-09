//
//  ViewController.swift
//  RecognitionAnnouncerVoice
//
//  Created by 近藤宏輝 on 2020/02/09.
//  Copyright © 2020 Hiroki. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController,SFSpeechRecognizerDelegate {
    
    // MARK: 温泉関連Properties
    //localeのidentifierに言語を指定、。日本語はja-JP,英語はen-US
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))
    private var recognitionTask: SFSpeechRecognitionTask?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        
        //ユーザーに音声認識の許可を求める
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    //ユーザが音声認識の許可を出した時
                    print("音声認識許可")
                case .denied:
                    //ユーザが音声認識を拒否した時
                    print("音声認識拒否")
                case .restricted:
                    //端末が音声認識に対応していない場合
                    print("音声認識が対応していません")
                case .notDetermined:
                    //ユーザが音声認識をまだ認証していない時
                    print("音声認識の認証ができていません")
                }
            }
        }
    }

    
    //音声ファイルのパスの取得
    let path = Bundle.main.path(forResource: "nhk", ofType: "mp3")

    
    //音声の解析を実行
    func doRecognize(url:URL){
        let recognitionRequest = SFSpeechURLRecognitionRequest(url: url)
        //時間計測用
        let start = Date()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            if let result = result {
                print("所要時間", Date().timeIntervalSince(start))
                //解析結果の文字列表示
                print(result.bestTranscription.formattedString)
            }
            
            if let error = error {
                print(error)
            }
        })
    }


}

/*
 参考URL
 【iOS】Speechフレームワークでアナウンサーの声を認識させてみた
 https://www.konosumi.net/entry/2017/10/22/173153
 */


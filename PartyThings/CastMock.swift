//
//  CastMock.swift
//  PartyThings
//
//  Created by Jeremy Robertson on 6/20/15.
//  Copyright (c) 2015 Jeremy Robertson. All rights reserved.
//

import Foundation

class CastMock : NSObject {
    required override init(){
        Hub.Instance.Register(GameNameResponse.self) {
            let args : GameNameResponse = $0 as! GameNameResponse;
            println("game name: " + args.GameName);
            println("player name: " + args.PlayerName);
            
            var newReadyArgs = ReadyRequest();
            Hub.Instance.Send(newReadyArgs);
        };
        Hub.Instance.Register(PlayerNameResponse.self) {
            let args : PlayerNameResponse = $0 as! PlayerNameResponse;
            
            println("player name: " + args.PlayerName);
            
            var newReadyArgs = ReadyRequest();
            Hub.Instance.Send(newReadyArgs);
        };
        Hub.Instance.Register(ReadyResponse.self) {
            let args : ReadyResponse = $0 as! ReadyResponse;
            
            var prompts = [String](arrayLiteral: "a", "b", "c");
            var newPromptRequest = PromptRequest(Prompts: prompts);
            Hub.Instance.Send(newPromptRequest);
        };
        Hub.Instance.Register(PromptResponse.self) {
            let args : PromptResponse = $0 as! PromptResponse;
            
            println("prompt selected: " + args.Prompt);
            
            var thing = ThingRequest(Prompt: "Something");
            Hub.Instance.Send(thing);
        };
        
        Hub.Instance.Register(ThingResponse.self) {
            let args : ThingResponse = $0 as! ThingResponse;
            
            println("thing response: " + args.Thing);
            
            var prompts = [String](arrayLiteral: "a", "b", "c");
            var prompts2 = [String](arrayLiteral: "a", "b", "c");
            
            var guess = GuessRequest(Prompts : prompts, Players: prompts2);
            Hub.Instance.Send();
        };
        
        Hub.Instance.Register(GuessResponse.self) {
            let args : GuessResponse = $0 as! GuessResponse;
            
            println("guessed player: " + args.Player);
            println("guessed promtp: " + args.Prompt);
            
            var prompts = [String](arrayLiteral: "a", "b", "c");
            var newPromptRequest = PromptRequest(Prompts: prompts);
            Hub.Instance.Send();
        };
        Hub.Instance.Register(QuitResponse.self) {
            let args : QuitResponse = $0 as! QuitResponse;
            
            Hub.Instance.Send();
        };
    }
}
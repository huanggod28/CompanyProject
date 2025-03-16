package com;

import com.example.numbergame.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/game")
public class GameController {

    @Autowired
    private GameService gameService;

    @GetMapping("/start")
    public String startGame() {
        gameService.startNewGame();
        return "遊戲開始！請輸入四個不重複數字";
    }

    @PostMapping("/guess")
    public String makeGuess(@RequestBody List<Integer> guess) {
        return gameService.makeGuess(guess);
    }

    @GetMapping("/history")
    public List<String> getHistory() {
        return gameService.getHistory();
    }
}

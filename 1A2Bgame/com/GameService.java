package com;

import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class GameService {
    private List<Integer> answer;
    private List<String> history = new ArrayList<>();

    public void startNewGame() {
        answer = new ArrayList<>();
        history.clear();
        Random rand = new Random();
        while (answer.size() < 4) {
            int num = rand.nextInt(10);
            if (!answer.contains(num)) {
                answer.add(num);
            }
        }
    }

    public String makeGuess(List<Integer> guess) {
        int a = 0, b = 0;
        for (int i = 0; i < 4; i++) {
            if (answer.get(i).equals(guess.get(i))) {
                a++;
            } else if (answer.contains(guess.get(i))) {
                b++;
            }
        }
        String result = guess + " -> " + a + "A" + b + "B";
        history.add(result);
        return result;
    }

    public List<String> getHistory() {
        return history;
    }
}

package game;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/TicTacToeServlet")
public class TicTacToeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Gson gson = new GsonBuilder().create();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        HttpSession session = request.getSession();
        GameState state = (GameState) session.getAttribute("gameState");
        String action = request.getParameter("action");

        if(action==null){ writeJson(response,gson.toJson(Map.of("error","Missing action"))); return; }

        switch(action){
	        case "init": {
	            String first = request.getParameter("first");
	
	            //如果沒帶參數就預設 O（玩家先攻）
	            if(first == null || first.isEmpty()) first = "O";
	            first = first.trim().toUpperCase();
	
	            //僅允許 O（先攻）或 X（後攻）
	            if(!"O".equals(first) && !"X".equals(first)) {
	                first = "O"; // 預設玩家先攻
	            }
	
	            //建立遊戲（這裡 GameState 需要依照 first 設置 playerSymbol 與 computerSymbol）
	            state = new GameState(first);
	            session.setAttribute("gameState", state);
	
	            //如果電腦先攻（玩家選了 X = 後攻）
	            //    → init 階段電腦要自動先下一步
	            if (state.currentPlayer.equals(state.computerSymbol)) {
	                state.computerMove();
	                // 回合交給玩家
	                state.currentPlayer = state.playerSymbol;
	            }
	
	            logBoard(state);
	            writeJson(response, gson.toJson(state));
	            return;
	        }
            case "move":{
                if(state==null){ writeJson(response,gson.toJson(Map.of("error","遊戲尚未初始化"))); return; }
                if(state.gameOver){ writeJson(response,gson.toJson(state)); return; }

                try{
                    int row = Integer.parseInt(request.getParameter("row"));
                    int col = Integer.parseInt(request.getParameter("col"));
                    state.playerMove(row,col);
                    if(!state.gameOver && state.currentPlayer.equals(state.computerSymbol)) state.computerMove();
                }catch(NumberFormatException e){
                    writeJson(response,gson.toJson(Map.of("error","row/col invalid"))); return;
                }
                logBoard(state);
                writeJson(response,gson.toJson(state));
                return;
            }
            case "reset":{
                session.removeAttribute("gameState");
                GameState newState = new GameState("X");
                session.setAttribute("gameState", newState);
                writeJson(response,gson.toJson(newState));
                return;
            }
            default: writeJson(response,gson.toJson(Map.of("error","Unknown action"))); return;
        }
    }

    private void writeJson(HttpServletResponse resp, String json) throws IOException {
        resp.getWriter().write(json);
    }

    private void logBoard(GameState s){
        System.out.println("==== 後端棋盤狀態 ====");
        for(int i=0;i<3;i++){
            String a = s.board[i][0].isEmpty()?" ":s.board[i][0];
            String b = s.board[i][1].isEmpty()?" ":s.board[i][1];
            String c = s.board[i][2].isEmpty()?" ":s.board[i][2];
            System.out.println(a+" | "+b+" | "+c);
        }
        System.out.println("currentPlayer="+s.currentPlayer+"  gameOver="+s.gameOver+"  winner="+s.winner);
        System.out.println("=====================");
    }

    public static class GameState {
        public String[][] board = new String[3][3];
        public String currentPlayer;
        public boolean gameOver = false;
        public String winner = "";
        public String playerSymbol;
        public String computerSymbol;

        private transient Random rand = new Random();
        private transient LinkedList<int[]> playerMoves = new LinkedList<>();
        private transient LinkedList<int[]> computerMoves = new LinkedList<>();

        public GameState(String playerFirst){
            // 清盤
            for(int i=0;i<3;i++) Arrays.fill(board[i], "");

            // 設定玩家符號
            this.playerSymbol = playerFirst.equalsIgnoreCase("X") ? "X" : "O";
            this.computerSymbol = this.playerSymbol.equals("X") ? "O" : "X";

            // ✅ 永遠 O 先攻（標準井字遊戲）
            this.currentPlayer = "O";

            this.gameOver = false;
            this.winner = "";
        }

        public void playerMove(int row,int col){
            if(gameOver||!isInBounds(row,col)||!board[row][col].isEmpty()||!currentPlayer.equals(playerSymbol)) return;
            placeMove(row,col,playerMoves,playerSymbol);
            if(checkWin(playerSymbol)){ gameOver=true; winner="player"; return; }
            if(isBoardFull()){ gameOver=true; winner="draw"; return; }
            currentPlayer = computerSymbol;
        }

        public void computerMove(){
            if(gameOver||!currentPlayer.equals(computerSymbol)) return;
            int[] best = findWinningMove(computerSymbol);
            if(best==null) best=findWinningMove(playerSymbol);
            if(best==null){
                List<int[]> empties = getEmptyCells();
                if(empties.isEmpty()){ if(isBoardFull()){ gameOver=true; winner="draw"; } return; }
                best = empties.get(rand.nextInt(empties.size()));
            }
            placeMove(best[0],best[1],computerMoves,computerSymbol);
            if(checkWin(computerSymbol)){ gameOver=true; winner="computer"; return; }
            if(isBoardFull()){ gameOver=true; winner="draw"; return; }
            currentPlayer = playerSymbol;
        }

        private void placeMove(int r,int c,LinkedList<int[]> list,String sym){
            if(!"X".equals(sym) && !"O".equals(sym)) sym="";
            board[r][c] = sym;
            list.addLast(new int[]{r,c});
            if(list.size()>3){
                int[] old=list.removeFirst();
                int or=old[0],oc=old[1];
                if(board[or][oc].equals(sym)) board[or][oc]="";
            }
        }

        private boolean checkWin(String s){
            for(int i=0;i<3;i++){
                if(s.equals(board[i][0]) && s.equals(board[i][1]) && s.equals(board[i][2])) return true;
                if(s.equals(board[0][i]) && s.equals(board[1][i]) && s.equals(board[2][i])) return true;
            }
            if(s.equals(board[0][0]) && s.equals(board[1][1]) && s.equals(board[2][2])) return true;
            if(s.equals(board[0][2]) && s.equals(board[1][1]) && s.equals(board[2][0])) return true;
            return false;
        }

        private boolean isInBounds(int r,int c){ return r>=0&&r<3&&c>=0&&c<3; }
        private boolean isBoardFull(){ for(int i=0;i<3;i++) for(int j=0;j<3;j++) if(board[i][j].isEmpty()) return false; return true; }
        private List<int[]> getEmptyCells(){
            List<int[]> empties=new ArrayList<>();
            for(int i=0;i<3;i++) for(int j=0;j<3;j++) if(board[i][j].isEmpty()) empties.add(new int[]{i,j});
            return empties;
        }

        private int[] findWinningMove(String sym){
            for(int i=0;i<3;i++){
                for(int j=0;j<3;j++){
                    if(!board[i][j].isEmpty()) continue;
                    board[i][j]=sym;
                    boolean win=checkWin(sym);
                    board[i][j]="";
                    if(win) return new int[]{i,j};
                }
            }
            return null;
        }
    }
}
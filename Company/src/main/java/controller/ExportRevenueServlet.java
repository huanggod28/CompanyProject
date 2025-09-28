package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RevenueRecordDao;
import dao.impl.RevenueRecordDaoImpl;
import model.RevenueRecord;

//此為匯出營收csv用 配合InsertCoinServlet和/ShipmentServlet

@WebServlet("/ExportRevenueServlet")
public class ExportRevenueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private RevenueRecordDao revenueRecordDao = new RevenueRecordDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	String filename = "營收報表.csv";
        String encodedFilename = java.net.URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFilename);
    	
    	//response.setContentType("text/csv; charset=UTF-8");
        //response.setHeader("Content-Disposition", "attachment; filename=revenue_report.csv");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");

        if (userId == null) {
            response.getWriter().write("❌ 未登入，無法匯出");
            return;
        }

        // 查詢當前使用者的營收紀錄
        List<RevenueRecord> records = revenueRecordDao.findByUserId(userId);

        PrintWriter writer = response.getWriter();
        writer.write('\uFEFF'); // BOM，讓 Excel 正確識別 UTF-8

        // CSV 標題
        writer.println("機台ID,使用者ID,累積投入金額,保底金額,獎品成本,總收入,出貨數,淨利潤,毛利率(%),最後更新時間,出貨說明");

        // 輸出每筆紀錄
        for (RevenueRecord r : records) {
            writer.printf("%d,%d,%d,%d,%.2f,%.2f,%d,%.2f,%.2f,%s,%s%n",
                    r.getMachineId(),
                    r.getUserId(),
                    r.getTotalCoin(),
                    r.getGuaranteeAmount(),
                    r.getProductCost(),
                    r.getTotalRevenue(),
                    r.getShipmentCount(),
                    r.getNetProfit(),
                    r.getGrossMargin(),
                    r.getLastUpdate() != null ? r.getLastUpdate().toString() : "",
                    r.getNote() != null ? r.getNote() : "");
        }

        writer.flush();
        writer.close();
    }
}
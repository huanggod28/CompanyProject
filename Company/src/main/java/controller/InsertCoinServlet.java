package controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.impl.RevenueRecordDaoImpl;
import model.RevenueRecord;

//此為模擬投幣用+10元
@WebServlet("/InsertCoinServlet")
public class InsertCoinServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RevenueRecordDaoImpl dao = new RevenueRecordDaoImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int machineId = Integer.parseInt(request.getParameter("machineId"));

        // 取得登入使用者
        model.Register loginUser = (model.Register) request.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            response.getWriter().write("❌ 尚未登入，無法投幣");
            return;
        }

        int userId = loginUser.getId();

        RevenueRecord record = dao.findByMachineId(machineId);
        if (record == null) {
            record = new RevenueRecord();
            record.setMachineId(machineId);
            record.setUserId(userId); // 新增
            record.setTotalCoin(10);
            record.setShipmentCount(0);
            record.setGuaranteeAmount(0);
            record.setProductCost(0);
            record.setTotalRevenue(0);
            dao.insert(record);
        } else {
        	//更新現有投幣紀錄
            record.setTotalCoin(record.getTotalCoin() + 10);
            dao.update(record);
        }

        response.getWriter().write("✅ 投幣成功，目前金額: " + record.getTotalCoin());
    }
}
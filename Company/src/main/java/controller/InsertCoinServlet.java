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

        RevenueRecord record = dao.findByMachineId(machineId);
        if (record == null) {
            record = new RevenueRecord();
            record.setMachineId(machineId);
            record.setTotalCoin(10);
            record.setShipmentCount(0);
            record.setGuaranteeAmount(0); // 之後再由 machine_parameters 補上
            record.setProductCost(0);
            record.setTotalRevenue(0);
            dao.insert(record);
        } else {
            record.setTotalCoin(record.getTotalCoin() + 10);
            dao.update(record);
        }

        response.getWriter().write("✅ 投幣成功，目前金額: " + record.getTotalCoin());
    }
}
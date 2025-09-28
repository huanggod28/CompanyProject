package controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DbConnection;
import dao.impl.MachineParametersDaoImpl;
import dao.impl.RevenueRecordDaoImpl;
import dao.impl.ShipmentRecordDaoImpl;
import model.RevenueRecord;
import model.ShipmentRecord;

//此為模擬出貨按鈕用

@WebServlet("/ShipmentServlet")
public class ShipmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RevenueRecordDaoImpl revenueDao = new RevenueRecordDaoImpl();
    private ShipmentRecordDaoImpl shipmentDao = new ShipmentRecordDaoImpl();
    private MachineParametersDaoImpl paramsDao = new MachineParametersDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String machineIdStr = request.getParameter("machineId");
        String productCostStr = request.getParameter("productCost");

        response.setContentType("text/plain; charset=UTF-8");

        try {
            int machineId = Integer.parseInt(machineIdStr);
            double productCost = Double.parseDouble(productCostStr);

            Connection conn = DbConnection.getDB();
            try {
                conn.setAutoCommit(false); // transaction start

                RevenueRecord r = revenueDao.findByMachineId(machineId);
                if (r == null) {
                    response.getWriter().write("❌ 尚未有投幣紀錄，無法出貨");
                    conn.rollback();
                    return;
                }

                int totalCoin = r.getTotalCoin();
                int guarantee = 0;
                try {
                    // 從 machine_parameters 取 max_price（若你有此欄）
                    model.MachineParameters mp = paramsDao.getParametersByMachineId(machineId);
                    if (mp != null) guarantee = mp.getMax_price();
                } catch (Exception ignore) {}

                // 建出 shipment record
                ShipmentRecord s = new ShipmentRecord();
                s.setMachineId(machineId);
                s.setTotalCoin(totalCoin);
                s.setGuaranteeAmount(guarantee);
                s.setProductCost(productCost);
                s.setShipmentCount(1);
                s.setRevenue(totalCoin); // 營收視為投幣金額
                shipmentDao.insert(s);

                // 更新 revenue_record：累積 totalRevenue、出貨次數、存 product cost、淨利毛利率
                double newTotalRevenue = r.getTotalRevenue() + totalCoin;
                int newShipmentCount = r.getShipmentCount() + 1;
                r.setTotalRevenue(newTotalRevenue);
                r.setShipmentCount(newShipmentCount);
                r.setProductCost(productCost);
                r.setTotalCoin(0); // 出貨後清空投入金額

                // 計算淨利與毛利率（簡單計算）
                double netProfit = newTotalRevenue - (productCost * newShipmentCount);
                double grossMargin = newTotalRevenue > 0 ? (netProfit / newTotalRevenue) * 100.0 : 0.0;
                r.setNetProfit(netProfit);
                r.setGrossMargin(grossMargin);

                revenueDao.update(r);

                conn.commit();
                response.getWriter().write("✅ 出貨成功，本次營收: " + s.getRevenue());
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                response.getWriter().write("❌ 出貨時發生錯誤");
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("❌ 參數錯誤");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("❌ 系統錯誤");
        }
    }
}
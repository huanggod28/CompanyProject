package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.DbConnection;
import dao.RevenueRecordDao;
import model.RevenueRecord;
import model.ShipmentRecord;

public class RevenueRecordDaoImpl implements RevenueRecordDao {

    private static Connection conn = DbConnection.getDB();

    @Override
    public void insert(RevenueRecord record) {
    	String sql = "INSERT INTO revenue_record (machine_id, user_id, total_coin, guarantee_amount, product_cost, total_revenue, shipment_count, note) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

     try (PreparedStatement ps = conn.prepareStatement(sql)) {
         ps.setInt(1, record.getMachineId());
         ps.setInt(2, record.getUserId());
         ps.setInt(3, record.getTotalCoin());
         ps.setInt(4, record.getGuaranteeAmount());
         ps.setDouble(5, record.getProductCost());
         ps.setDouble(6, record.getTotalRevenue());
         ps.setInt(7, record.getShipmentCount());
         ps.setString(8, record.getNote());
         ps.executeUpdate();
     } catch (SQLException e) {
         e.printStackTrace();
     }
 }

    @Override
    public void update(RevenueRecord record) {
        String sql = "UPDATE revenue_record SET total_coin=?, product_cost=?, total_revenue=?, shipment_count=? WHERE machine_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, record.getTotalCoin());
            ps.setDouble(2, record.getProductCost());
            ps.setDouble(3, record.getTotalRevenue());
            ps.setInt(4, record.getShipmentCount());
            ps.setInt(5, record.getMachineId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public RevenueRecord findByMachineId(int machineId) {
        String sql = "SELECT * FROM revenue_record WHERE machine_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, machineId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                RevenueRecord record = new RevenueRecord();
                record.setId(rs.getInt("id"));
                record.setMachineId(rs.getInt("machine_id"));
                record.setTotalCoin(rs.getInt("total_coin"));
                record.setGuaranteeAmount(rs.getInt("guarantee_amount"));
                record.setProductCost(rs.getDouble("product_cost"));
                record.setTotalRevenue(rs.getDouble("total_revenue"));
                record.setShipmentCount(rs.getInt("shipment_count"));
                record.setNetProfit(rs.getDouble("net_profit"));
                record.setGrossMargin(rs.getDouble("gross_margin"));
                record.setLastUpdate(rs.getTimestamp("last_update"));
                return record;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<RevenueRecord> findAll() {
        List<RevenueRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM revenue_record";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                RevenueRecord record = new RevenueRecord();
                record.setId(rs.getInt("id"));
                record.setMachineId(rs.getInt("machine_id"));
                record.setTotalCoin(rs.getInt("total_coin"));
                record.setGuaranteeAmount(rs.getInt("guarantee_amount"));
                record.setProductCost(rs.getDouble("product_cost"));
                record.setTotalRevenue(rs.getDouble("total_revenue"));
                record.setShipmentCount(rs.getInt("shipment_count"));
                record.setNetProfit(rs.getDouble("net_profit"));
                record.setGrossMargin(rs.getDouble("gross_margin"));
                record.setLastUpdate(rs.getTimestamp("last_update"));
                list.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<RevenueRecord> findByUserId(int userId) {
        List<RevenueRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM revenue_record WHERE user_id = ? ORDER BY last_update DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                RevenueRecord r = new RevenueRecord();
                r.setId(rs.getInt("id"));
                r.setMachineId(rs.getInt("machine_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setTotalCoin(rs.getInt("total_coin"));
                r.setGuaranteeAmount(rs.getInt("guarantee_amount"));
                r.setProductCost(rs.getDouble("product_cost"));
                r.setTotalRevenue(rs.getDouble("total_revenue"));
                r.setShipmentCount(rs.getInt("shipment_count"));
                r.setNetProfit(rs.getDouble("net_profit"));
                r.setGrossMargin(rs.getDouble("gross_margin"));
                r.setLastUpdate(rs.getTimestamp("last_update"));
                r.setNote(rs.getString("note"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
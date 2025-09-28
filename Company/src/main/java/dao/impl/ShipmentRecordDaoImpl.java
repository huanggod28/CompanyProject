package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.DbConnection;
import dao.ShipmentRecordDao;
import model.ShipmentRecord;

public class ShipmentRecordDaoImpl implements ShipmentRecordDao {

    // 使用你現有的資料庫連線方法
    private static Connection conn = DbConnection.getDB();

    @Override
    public void insert(ShipmentRecord record) {
    	String sql = "INSERT INTO shipment_record "
    		    + "(machine_id, total_coin, guarantee_amount, product_cost, shipment_count, revenue) "
    		    + "VALUES (?, ?, ?, ?, ?, ?)";

    		try (PreparedStatement ps = conn.prepareStatement(sql)) {
    		    ps.setInt(1, record.getMachineId());
    		    ps.setInt(2, record.getTotalCoin());
    		    ps.setInt(3, record.getGuaranteeAmount());
    		    ps.setDouble(4, record.getProductCost());
    		    ps.setInt(5, record.getShipmentCount());
    		    ps.setDouble(6, record.getRevenue());
    		    ps.executeUpdate();

            // 如果需要，把自增 id 回寫到物件
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    record.setId(keys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<ShipmentRecord> findByMachineId(int machineId) {
        List<ShipmentRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM shipment_record WHERE machine_id = ? ORDER BY shipment_time DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, machineId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShipmentRecord r = new ShipmentRecord();
                    r.setId(rs.getInt("id"));
                    r.setMachineId(rs.getInt("machine_id"));
                    r.setShipmentTime(rs.getTimestamp("shipment_time"));
                    r.setTotalCoin(rs.getInt("total_coin"));
                    r.setGuaranteeAmount(rs.getInt("guarantee_amount"));
                    r.setProductCost(rs.getDouble("product_cost"));
                    r.setShipmentCount(rs.getInt("shipment_count"));
                    r.setRevenue(rs.getDouble("revenue")); // 若為 GENERATED COLUMN，DB 會回傳
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<ShipmentRecord> findAll() {
        List<ShipmentRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM shipment_record ORDER BY shipment_time DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ShipmentRecord r = new ShipmentRecord();
                r.setId(rs.getInt("id"));
                r.setMachineId(rs.getInt("machine_id"));
                r.setShipmentTime(rs.getTimestamp("shipment_time"));
                r.setTotalCoin(rs.getInt("total_coin"));
                r.setGuaranteeAmount(rs.getInt("guarantee_amount"));
                r.setProductCost(rs.getDouble("product_cost"));
                r.setShipmentCount(rs.getInt("shipment_count"));
                r.setRevenue(rs.getDouble("revenue"));
                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public List<ShipmentRecord> findByUserId(int userId) {
        List<ShipmentRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM shipment_record WHERE user_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShipmentRecord r = new ShipmentRecord();
                r.setId(rs.getInt("id"));
                r.setMachineId(rs.getInt("machine_id"));
                r.setProductCost(rs.getInt("product_cost"));
                r.setShipmentCount(rs.getInt("shipment_count"));
                r.setShipmentTime(rs.getTimestamp("shipment_time"));
                r.setRevenue(rs.getInt("revenue"));
                r.setUserId(rs.getInt("user_id"));
                r.setNote(rs.getString("note"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

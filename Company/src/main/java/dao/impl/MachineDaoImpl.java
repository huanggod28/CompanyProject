package dao.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dao.MachineDao;
import model.Machine;
import dao.DbConnection;  // 使用你的資料庫連線類別

public class MachineDaoImpl implements MachineDao {

    private static Connection conn = DbConnection.getDB();  // 直接取得資料庫連線

    @Override
    public List<Machine> getMachinesByLocationId(int id) {
        List<Machine> machines = new ArrayList<>();
        String sql = "SELECT * FROM Machines WHERE location_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Machine machine = new Machine(
                    rs.getInt("id"),
                    rs.getInt("location_id"),
                    rs.getString("name"),
                    rs.getString("camera_url"),
                    rs.getString("image_url")
                );
                machines.add(machine);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return machines;
    }

    @Override
    public void addMachine(Machine machine) {
        String sql = "INSERT INTO Machines (location_id, name, camera_url,image_url) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, machine.getLocationId());
            stmt.setString(2, machine.getName());
            stmt.setString(3, machine.getCameraUrl());
            stmt.setString(4, machine.getImageUrl());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public int getMachineCountByLocation(int locationId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Machines WHERE location_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, locationId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
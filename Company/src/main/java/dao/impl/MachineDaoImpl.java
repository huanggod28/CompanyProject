package dao.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dao.MachineDao;
import model.Machine;
import util.DbConnection;

public class MachineDaoImpl implements MachineDao {

    @Override
    public List<Machine> getMachinesByLocationId(int id) {
        List<Machine> machines = new ArrayList<>();
        String sql = "SELECT * FROM Machines WHERE location_id = ?";

        try (
            Connection conn = DbConnection.getDB();        //每次取得新連線
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
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
    public void updateMachine(Machine machine) {
        String sql = "UPDATE Machines SET name=?, camera_url=?, image_url=? WHERE id=?";
        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, machine.getName());
            stmt.setString(2, machine.getCameraUrl());
            stmt.setString(3, machine.getImageUrl());
            stmt.setInt(4, machine.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMachine(int machineId) {
        try (Connection conn = DbConnection.getDB()) {
            // 先刪掉 machine_parameters
            String sqlParams = "DELETE FROM machine_parameters WHERE machine_id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sqlParams)) {
                stmt.setInt(1, machineId);
                stmt.executeUpdate();
            }

            // 再刪掉 machine
            String sqlMachine = "DELETE FROM Machines WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sqlMachine)) {
                stmt.setInt(1, machineId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addMachine(Machine machine) {
        String sql = "INSERT INTO Machines (location_id, name, camera_url, image_url) VALUES (?, ?, ?, ?)";
        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            stmt.setInt(1, machine.getLocationId());
            stmt.setString(2, machine.getName());
            stmt.setString(3, machine.getCameraUrl());
            stmt.setString(4, machine.getImageUrl());
            stmt.executeUpdate();

            // 取得自動生成的 machine_id
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    int machineId = rs.getInt(1);

                    // 自動建立 machine_parameters（使用 default 值）
                    String sqlParam = "INSERT INTO machine_parameters (machine_id) VALUES (?)";
                    try (PreparedStatement stmtParam = conn.prepareStatement(sqlParam)) {
                        stmtParam.setInt(1, machineId);
                        stmtParam.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Machine getMachineById(int machineId) {
        System.out.println("DAO 收到的 machineId = " + machineId);
        String sql = "SELECT * FROM Machines WHERE id = ?";

        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, machineId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Machine(
                    rs.getInt("id"),
                    rs.getInt("location_id"),
                    rs.getString("name"),
                    rs.getString("camera_url"),
                    rs.getString("image_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
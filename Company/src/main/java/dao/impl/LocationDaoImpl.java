package dao.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dao.LocationDao;
import dao.MachineDao;
import model.Location;
import util.DbConnection;

public class LocationDaoImpl implements LocationDao {

    @Override
    public List<Location> getLocationsByUserId(int id) {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM Locations WHERE user_id = ?";

        try (
            Connection conn = DbConnection.getDB(); //每次使用新的連線（連線池自動管理）
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Location location = new Location(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("address")
                );
                locations.add(location);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

    @Override
    public void addLocation(Location location) {
        String sql = "INSERT INTO Locations (user_id, name, address) VALUES (?, ?, ?)";

        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, location.getUserId());
            stmt.setString(2, location.getName());
            stmt.setString(3, location.getAddress());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateLocation(Location location) {
        String sql = "UPDATE Locations SET name=?, address=? WHERE id=?";

        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, location.getName());
            stmt.setString(2, location.getAddress());
            stmt.setInt(3, location.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteLocation(int locationId) {
        // 不在 DAO 內呼叫其他 DAO，而是在 Service 層負責
        // 若真的要刪所有機台，也要確保在同一個連線裡操作（避免資料不一致）
        String sqlDeleteMachines = "DELETE FROM Machines WHERE location_id = ?";
        String sqlDeleteLocation = "DELETE FROM Locations WHERE id = ?";

        try (Connection conn = DbConnection.getDB()) {
            conn.setAutoCommit(false); // 開啟交易

            try (
                PreparedStatement stmtMachines = conn.prepareStatement(sqlDeleteMachines);
                PreparedStatement stmtLocation = conn.prepareStatement(sqlDeleteLocation)
            ) {
                // 刪機台
                stmtMachines.setInt(1, locationId);
                stmtMachines.executeUpdate();

                // 刪場地
                stmtLocation.setInt(1, locationId);
                stmtLocation.executeUpdate();

                conn.commit(); //提交交易
            } catch (SQLException e) {
                conn.rollback(); //發生錯誤就回滾
                throw e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
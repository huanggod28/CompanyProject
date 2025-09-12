package dao.impl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dao.LocationDao;
import model.Location;
import dao.DbConnection;  // 使用你的資料庫連線類別

public class LocationDaoImpl implements LocationDao {

    private static Connection conn = DbConnection.getDB();  // 直接取得資料庫連線

    @Override
    public List<Location> getLocationsByUserId(int id) {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM Locations WHERE user_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try {
            // 刪掉該場地下所有機台及其參數
            String sqlMachines = "SELECT id FROM Machines WHERE location_id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sqlMachines)) {
                stmt.setInt(1, locationId);
                ResultSet rs = stmt.executeQuery();
                MachineDaoImpl machineDao = new MachineDaoImpl();
                while (rs.next()) {
                    int machineId = rs.getInt("id");
                    machineDao.deleteMachine(machineId); // 會連帶刪 machine_parameters
                }
            }

            // 刪掉場地
            String sqlLocation = "DELETE FROM Locations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sqlLocation)) {
                stmt.setInt(1, locationId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
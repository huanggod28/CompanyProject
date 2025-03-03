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
    public List<Location> getLocationsByUserId(int userId) {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM Locations WHERE user_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
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
}
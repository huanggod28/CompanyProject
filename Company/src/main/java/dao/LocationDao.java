package dao;

import java.util.List;
import model.Location;

public interface LocationDao {
    List<Location> getLocationsByUserId(int userId);  // 取得該使用者的場地
    void addLocation(Location location);  // 新增場地
}
package dao;

import java.util.List;
import model.ShipmentRecord;

public interface ShipmentRecordDao {
    void insert(ShipmentRecord record);
    List<ShipmentRecord> findByMachineId(int machineId);
    List<ShipmentRecord> findAll();
    public List<ShipmentRecord> findByUserId(int userId);
}

package dao;

import java.util.List;
import model.RevenueRecord;
import model.ShipmentRecord;

public interface RevenueRecordDao {
    void insert(RevenueRecord record);
    void update(RevenueRecord record);
    RevenueRecord findByMachineId(int machineId);
    List<RevenueRecord> findAll();
    
    // 依 userId 查詢該使用者的所有營收紀錄
    List<RevenueRecord> findByUserId(int userId);
}
package dao;

import java.util.List;
import model.Machine;

public interface MachineDao {
    List<Machine> getMachinesByLocationId(int id); // 取得該場地的機台列表
    void addMachine(Machine machine);  // 新增機台
    void updateMachine(Machine machine);   // 修改機台
    void deleteMachine(int machineId);     // 刪除機台
    Machine getMachineById(int machineId); // ✅ 改成用 int 傳入
}
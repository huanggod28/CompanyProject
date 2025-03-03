package dao;

import java.util.List;
import model.Machine;

public interface MachineDao {
    List<Machine> getMachinesByLocationId(int locationId); // 取得該場地的機台列表
    void addMachine(Machine machine);  // 新增機台
}
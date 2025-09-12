package dao;

import model.MachineParameters;

public interface MachineParametersDao {
    MachineParameters getParametersByMachineId(int machineId);  // 取得參數
    void updateParameters(MachineParameters params);            // 更新參數
}
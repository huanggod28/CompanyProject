package dao.impl;

import java.sql.*;
import dao.MachineParametersDao;
import model.MachineParameters;
import util.DbConnection;

public class MachineParametersDaoImpl implements MachineParametersDao {

    @Override
    public MachineParameters getParametersByMachineId(int machineId) {
        String sql = "SELECT * FROM machine_parameters WHERE machine_id=?";
        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, machineId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    MachineParameters params = new MachineParameters();
                    params.setMachineId(machineId);

                    // 爪力設定
                    params.setInitialGrip(rs.getInt("initial_grip"));
                    params.setMoveGrip(rs.getInt("move_grip"));
                    params.setPreDropGrip(rs.getInt("pre_drop_grip"));
                    params.setStrongGrip(rs.getInt("strong_grip"));
                    params.setOpenAngle(rs.getInt("open_angle"));
                    params.setCloseAngle(rs.getInt("close_angle"));
                    params.setGripDelay(rs.getDouble("grip_delay"));

                    // 機率/保夾設定
                    params.setGuaranteeCount(rs.getInt("guarantee_count"));
                    params.setGuaranteeGrip(rs.getInt("guarantee_grip"));

                    // 操作設定
                    params.setPlayTime(rs.getInt("play_time"));
                    params.setzSpeed(rs.getInt("z_speed"));
                    params.setXySpeed(rs.getInt("xy_speed"));
                    params.setQuickDrop(rs.getString("quick_drop"));
                    params.setMoveLimit(rs.getString("move_limit"));

                    // 金額與投幣設定
                    params.setPrice(rs.getInt("price"));
                    params.setMax_price(rs.getInt("max_price"));
                    params.setCoinMemory(rs.getString("coin_memory"));
                    params.setResetMode(rs.getString("reset_mode"));

                    // 音效與燈光設定
                    params.setSoundSwitch(rs.getString("sound_switch"));
                    params.setVolume(rs.getInt("volume"));
                    params.setLightMode(rs.getString("light_mode"));
                    params.setJackpotLight(rs.getString("jackpot_light"));

                    return params;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateParameters(MachineParameters params) {
        String sql = "UPDATE machine_parameters SET initial_grip=?, move_grip=?, pre_drop_grip=?, strong_grip=?, open_angle=?, close_angle=?, grip_delay=?, "
                   + "guarantee_count=?, guarantee_grip=?, play_time=?, z_speed=?, xy_speed=?, quick_drop=?, move_limit=?, price=?, max_price=?, coin_memory=?, reset_mode=?, "
                   + "sound_switch=?, volume=?, light_mode=?, jackpot_light=? WHERE machine_id=?";

        try (
            Connection conn = DbConnection.getDB();   // ✅ 每次使用都重新取得
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            int i = 1;
            stmt.setInt(i++, params.getInitialGrip());
            stmt.setInt(i++, params.getMoveGrip());
            stmt.setInt(i++, params.getPreDropGrip());
            stmt.setInt(i++, params.getStrongGrip());
            stmt.setInt(i++, params.getOpenAngle());
            stmt.setInt(i++, params.getCloseAngle());
            stmt.setDouble(i++, params.getGripDelay());

            stmt.setInt(i++, params.getGuaranteeCount());
            stmt.setInt(i++, params.getGuaranteeGrip());

            stmt.setInt(i++, params.getPlayTime());
            stmt.setInt(i++, params.getzSpeed());
            stmt.setInt(i++, params.getXySpeed());
            stmt.setString(i++, params.getQuickDrop());
            stmt.setString(i++, params.getMoveLimit());

            stmt.setInt(i++, params.getPrice());
            stmt.setInt(i++, params.getMax_price());
            stmt.setString(i++, params.getCoinMemory());
            stmt.setString(i++, params.getResetMode());

            stmt.setString(i++, params.getSoundSwitch());
            stmt.setInt(i++, params.getVolume());
            stmt.setString(i++, params.getLightMode());
            stmt.setString(i++, params.getJackpotLight());

            stmt.setInt(i++, params.getMachineId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.RegisterDao;
import model.Register;
import util.DbConnection;

public class RegisterDaoImpl implements RegisterDao {

    public static void main(String[] args) {
        System.out.println("success");
    }

    @Override
    public void addRegister(String name, String username, String password, String phone, String email, String gender,
                            String address) {

        String SQL = "INSERT INTO register(name, username, password, phone, email, genger, address) VALUES(?,?,?,?,?,?,?)";

        try (
            Connection conn = DbConnection.getDB();       //每次呼叫都向連線池借一條連線
            PreparedStatement ps = conn.prepareStatement(SQL)
        ) {
            ps.setString(1, name);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, gender);
            ps.setString(7, address);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addRegister(Register r) {
        // 可以用相同方式寫
    }

    @Override
    public Register findUsernameAndPassword(String username, String password) {
        String SQL = "SELECT * FROM register WHERE username=? AND password=?";
        Register register = null;

        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement ps = conn.prepareStatement(SQL)
        ) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                register = new Register();
                register.setId(rs.getInt("id"));
                register.setName(rs.getString("name"));
                register.setUsername(rs.getString("username"));
                register.setPassword(rs.getString("password"));
                register.setPhone(rs.getString("phone"));
                register.setEmail(rs.getString("email"));
                register.setGenger(rs.getString("genger"));
                register.setAddress(rs.getString("address"));
                register.setWhitelist(rs.getBoolean("is_whitelist"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return register;
    }

    @Override
    public boolean findByUsername(String username) {
        String SQL = "SELECT * FROM register WHERE username=?";
        boolean isUsernameBeenUse = false;

        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement ps = conn.prepareStatement(SQL)
        ) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) isUsernameBeenUse = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUsernameBeenUse;
    }

    @Override
    public Register selectMember(int id) {
        String SQL = "SELECT * FROM member WHERE id=?";
        Register m = null;

        try (
            Connection conn = DbConnection.getDB();
            PreparedStatement ps = conn.prepareStatement(SQL)
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                m = new Register();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setUsername(rs.getString("username"));
                m.setPassword(rs.getString("password"));
                m.setAddress(rs.getString("address"));
                m.setPhone(rs.getString("phone"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return m;
    }

    @Override
    public void updateRegister(int id, String name, String password, String address, String phone) {
        // TODO Auto-generated method stub
    }

}
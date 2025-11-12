package dao;

import model.User;

public interface UserDAO {
    User login(String username, String password);
    boolean register(User user);
    User getUserById(int id);
}

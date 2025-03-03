package model;

public class Location {
    private int id;
    private int userId;  // 關聯到 Users 表
    private String name;
    private String address;

    public Location() {}

    public Location(int id, int userId, String name, String address) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.address = address;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
package model;

public class Machine {
    private int id;
    private int locationId;  // 關聯到 Locations 表
    private String name;
    private String cameraUrl;
    private String imageUrl;

    

	public Machine() {}

    public Machine(int id, int locationId, String name, String cameraUrl,String imageUrl) {
        this.id = id;
        this.locationId = locationId;
        this.name = name;
        this.cameraUrl = cameraUrl;
        this.imageUrl = imageUrl;
        
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getLocationId() { return locationId; }
    public void setLocationId(int locationId) { this.locationId = locationId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCameraUrl() { return cameraUrl; }
    public void setCameraUrl(String cameraUrl) { this.cameraUrl = cameraUrl; }
    
    public String getImageUrl() {return imageUrl;}
	public void setImageUrl(String imageUrl) {this.imageUrl = imageUrl;	}
}
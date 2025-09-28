package model;

import java.sql.Timestamp;

public class ShipmentRecord {
    private int id;
    private int machineId;
    private int userId;               // 新增
    private Timestamp shipmentTime;   // 出貨時間
    private int totalCoin;            // 總投入金額
    private int guaranteeAmount;      // 保底金額
    private double productCost;       // 獎品進貨價
    private int shipmentCount;        // 出貨數量
    private double revenue;           // 本次營收
    private String note;              // 出貨說明

    // getter / setter
    

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMachineId() { return machineId; }
    public void setMachineId(int machineId) { this.machineId = machineId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Timestamp getShipmentTime() { return shipmentTime; }
    public void setShipmentTime(Timestamp shipmentTime) { this.shipmentTime = shipmentTime; }

    public int getTotalCoin() { return totalCoin; }
    public void setTotalCoin(int totalCoin) { this.totalCoin = totalCoin; }

    public int getGuaranteeAmount() { return guaranteeAmount; }
    public void setGuaranteeAmount(int guaranteeAmount) { this.guaranteeAmount = guaranteeAmount; }

    public double getProductCost() { return productCost; }
    public void setProductCost(double productCost) { this.productCost = productCost; }

    public int getShipmentCount() { return shipmentCount; }
    public void setShipmentCount(int shipmentCount) { this.shipmentCount = shipmentCount; }

    public double getRevenue() { return revenue; }
    public void setRevenue(double revenue) { this.revenue = revenue; }
    
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}

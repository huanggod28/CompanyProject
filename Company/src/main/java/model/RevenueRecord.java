package model;

import java.sql.Timestamp;

public class RevenueRecord {
    private int id;
    private int machineId;
    private int userId;               // 新增
    private int totalCoin;          // 累積投入金額
    private int guaranteeAmount;    // 保底金額 (machine_parameters.max_price)
    private double productCost;     // 獎品進貨價
    private double totalRevenue;    // 總收入
    private int shipmentCount;      // 出貨數
    private double netProfit;       // 淨利潤 (DB 已自動算，但可以讀出)
    private double grossMargin;     // 毛利率 %
    private String note;              // 出貨說明
    private Timestamp lastUpdate;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMachineId() { return machineId; }
    public void setMachineId(int machineId) { this.machineId = machineId; }

    public int getTotalCoin() { return totalCoin; }
    public void setTotalCoin(int totalCoin) { this.totalCoin = totalCoin; }

    public int getGuaranteeAmount() { return guaranteeAmount; }
    public void setGuaranteeAmount(int guaranteeAmount) { this.guaranteeAmount = guaranteeAmount; }

    public double getProductCost() { return productCost; }
    public void setProductCost(double productCost) { this.productCost = productCost; }

    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }

    public int getShipmentCount() { return shipmentCount; }
    public void setShipmentCount(int shipmentCount) { this.shipmentCount = shipmentCount; }

    public double getNetProfit() { return netProfit; }
    public void setNetProfit(double netProfit) { this.netProfit = netProfit; }

    public double getGrossMargin() { return grossMargin; }
    public void setGrossMargin(double grossMargin) { this.grossMargin = grossMargin; }

    public Timestamp getLastUpdate() { return lastUpdate; }
    public void setLastUpdate(Timestamp lastUpdate) { this.lastUpdate = lastUpdate; }
	
    public int getUserId() {return userId;}
    public void setUserId(int userId) {this.userId = userId;}
	
    public String getNote() {return note;}
    public void setNote(String note) {this.note = note;}
    
    
}
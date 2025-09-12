package model;

public class MachineParameters {
    private int machineId;

    // 爪力設定
    private int initialGrip, moveGrip, preDropGrip, strongGrip, openAngle, closeAngle;
    private double gripDelay;

    // 機率/保夾設定
    private int guaranteeCount, guaranteeGrip;

    // 操作設定
    private int playTime, zSpeed, xySpeed;
    private String quickDrop, moveLimit;

    // 金額與投幣設定
    private int price,max_price;
    private String coinMemory, resetMode;

    // 音效與燈光設定
    private String soundSwitch, lightMode, jackpotLight;
    private int volume;

    
    
	public MachineParameters() {
		super();
	}

	

	public MachineParameters(int machineId, int initialGrip, int moveGrip, int preDropGrip, int strongGrip,
			int openAngle, int closeAngle, double gripDelay, int guaranteeCount, int guaranteeGrip, int playTime,
			int zSpeed, int xySpeed, String quickDrop, String moveLimit, int price, int max_price, String coinMemory,
			String resetMode, String soundSwitch, String lightMode, String jackpotLight, int volume) {
		super();
		this.machineId = machineId;
		this.initialGrip = initialGrip;
		this.moveGrip = moveGrip;
		this.preDropGrip = preDropGrip;
		this.strongGrip = strongGrip;
		this.openAngle = openAngle;
		this.closeAngle = closeAngle;
		this.gripDelay = gripDelay;
		this.guaranteeCount = guaranteeCount;
		this.guaranteeGrip = guaranteeGrip;
		this.playTime = playTime;
		this.zSpeed = zSpeed;
		this.xySpeed = xySpeed;
		this.quickDrop = quickDrop;
		this.moveLimit = moveLimit;
		this.price = price;
		this.max_price = max_price;
		this.coinMemory = coinMemory;
		this.resetMode = resetMode;
		this.soundSwitch = soundSwitch;
		this.lightMode = lightMode;
		this.jackpotLight = jackpotLight;
		this.volume = volume;
	}



	public int getMax_price() {
		return max_price;
	}



	public void setMax_price(int max_price) {
		this.max_price = max_price;
	}



	public int getMachineId() {
		return machineId;
	}

	public void setMachineId(int machineId) {
		this.machineId = machineId;
	}

	public int getInitialGrip() {
		return initialGrip;
	}

	public void setInitialGrip(int initialGrip) {
		this.initialGrip = initialGrip;
	}

	public int getMoveGrip() {
		return moveGrip;
	}

	public void setMoveGrip(int moveGrip) {
		this.moveGrip = moveGrip;
	}

	public int getPreDropGrip() {
		return preDropGrip;
	}

	public void setPreDropGrip(int preDropGrip) {
		this.preDropGrip = preDropGrip;
	}

	public int getStrongGrip() {
		return strongGrip;
	}

	public void setStrongGrip(int strongGrip) {
		this.strongGrip = strongGrip;
	}

	public int getOpenAngle() {
		return openAngle;
	}

	public void setOpenAngle(int openAngle) {
		this.openAngle = openAngle;
	}

	public int getCloseAngle() {
		return closeAngle;
	}

	public void setCloseAngle(int closeAngle) {
		this.closeAngle = closeAngle;
	}

	public double getGripDelay() {
		return gripDelay;
	}

	public void setGripDelay(double gripDelay) {
		this.gripDelay = gripDelay;
	}

	public int getGuaranteeCount() {
		return guaranteeCount;
	}

	public void setGuaranteeCount(int guaranteeCount) {
		this.guaranteeCount = guaranteeCount;
	}

	public int getGuaranteeGrip() {
		return guaranteeGrip;
	}

	public void setGuaranteeGrip(int guaranteeGrip) {
		this.guaranteeGrip = guaranteeGrip;
	}

	public int getPlayTime() {
		return playTime;
	}

	public void setPlayTime(int playTime) {
		this.playTime = playTime;
	}

	public int getzSpeed() {
		return zSpeed;
	}

	public void setzSpeed(int zSpeed) {
		this.zSpeed = zSpeed;
	}

	public int getXySpeed() {
		return xySpeed;
	}

	public void setXySpeed(int xySpeed) {
		this.xySpeed = xySpeed;
	}

	public String getQuickDrop() {
		return quickDrop;
	}

	public void setQuickDrop(String quickDrop) {
		this.quickDrop = quickDrop;
	}

	public String getMoveLimit() {
		return moveLimit;
	}

	public void setMoveLimit(String moveLimit) {
		this.moveLimit = moveLimit;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCoinMemory() {
		return coinMemory;
	}

	public void setCoinMemory(String coinMemory) {
		this.coinMemory = coinMemory;
	}

	public String getResetMode() {
		return resetMode;
	}

	public void setResetMode(String resetMode) {
		this.resetMode = resetMode;
	}

	public String getSoundSwitch() {
		return soundSwitch;
	}

	public void setSoundSwitch(String soundSwitch) {
		this.soundSwitch = soundSwitch;
	}

	public String getLightMode() {
		return lightMode;
	}

	public void setLightMode(String lightMode) {
		this.lightMode = lightMode;
	}

	public String getJackpotLight() {
		return jackpotLight;
	}

	public void setJackpotLight(String jackpotLight) {
		this.jackpotLight = jackpotLight;
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}
    
    // 省略 getter/setter，需一一對應
    
}

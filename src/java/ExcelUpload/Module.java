package ExcelUpload;

public class Module {
	
	private String moudleName;  
	private double moduleScore;
	
	public Module() {
		super();
		this.moudleName = "N/A";
		this.moduleScore = -1;
	}
	public Module(String moduleID, double moduleScore) {
		super();
		this.moudleName = moduleID;
		this.moduleScore = moduleScore;
	}

	
	public String getMoudleName() {
		return moudleName;
	}
	public void setMoudleName(String moudleName) {
		this.moudleName = moudleName;
	}

	public double getmoduleScore() {
		return moduleScore;
	}
	public void setmoduleScore(double moduleScore) {
		this.moduleScore = moduleScore;
	}

	@Override
	public String toString() {
		return "Module [moduleID=" + moudleName + ", moduleScore=" + moduleScore + "]";
	}	
}
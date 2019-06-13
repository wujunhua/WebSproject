package com.atossyntel.excelupload;

import java.util.ArrayList;
import java.util.List;
public class Employee {
	
	private String employeeID;
	private String employeeName;
	private String employeeEmail;
	private ArrayList<Module> modScores = new ArrayList<>();	
	
	public Employee() {
		super();
		this.employeeID = "N/A";
		this.employeeName = "N/A";
		this.employeeEmail = "N/A";
		
	}
  
	public Employee(String employeeID, String employeeName, String employeeEmail) {
		super();
		this.employeeID = employeeID;
		this.employeeName = employeeName;
		this.employeeEmail = employeeEmail;
	}

	
	public String getEmployeeName() {
		return employeeName;
	}
	
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	
	public List<Module> getModScores() {
		return modScores;
	}
	
	public void setModScores(List<Module> modScores) {
		this.modScores = (ArrayList<Module>) modScores;
	}
	
	public String getEmployeeEmail() {
		return employeeEmail;
	}
	
	public void setEmployeeEmail(String employeeEmail) {
		this.employeeEmail = employeeEmail;
	}
	
	public String getEmployeeID() {
		return employeeID;
	}
	
	public void setEmployeeID(String employeeID) {
		this.employeeID = employeeID;
	}
	
	public void addScore(String modName, double sco) {
		 Module mod = new Module(modName, sco);
		 this.modScores.add(mod);
	}

    @Override
    public String toString() {
        return "Employee{" + "employeeID=" + employeeID + ", employeeName=" + employeeName + ", employeeEmail=" + employeeEmail + ", modScores=" + modScores + '}';
    }
}

package POJO;

public class CheckboxForm {
    String []userNames;

    public CheckboxForm() {
    }    

    public CheckboxForm(String[] userNames) {
        this.userNames = userNames;
    }
   
    public String[] getUserNames() {
        return userNames;
    }

    public void setUserNames(String[] userNames) {
        this.userNames = userNames;
    }

    @Override
    public String toString() {
        return "User{" + "userNames=" + userNames + '}';
    }
}
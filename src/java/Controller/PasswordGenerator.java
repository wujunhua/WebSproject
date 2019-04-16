package Controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author syntel
 */
public class PasswordGenerator {

    /*
    public static void main(String[] args) {
        // TODO code application logic here
        PasswordGenerator passwordGenerator = new PasswordGenerator();       
        passwordGenerator.generatePassword(); // output ex.: lrU12fmM 75iwI90o
    }
    */
    
    // **JUST CALL THIS METHOD TO GENERATE THE RANDOM PASSWORD. IT WILL TAKE CARE OF EVERYTHING.
    public String generatePassword()
    {
        PasswordGeneratorEngine passwordGenerator = new PasswordGeneratorEngine.PasswordGeneratorBuilder()
                .useDigits(true)
                .useLower(true)
                .useUpper(true)
                .build();
        String password = passwordGenerator.generate(8); // output ex.: lrU12fmM 75iwI90o
        System.out.println(password);
        return password;
    }
}

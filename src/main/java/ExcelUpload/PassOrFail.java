/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ExcelUpload;

import java.util.ArrayList;

/**
 *
 * @author syntel
 */
public class PassOrFail {
    
    //Filters through all of an employee's modules scores
    //Returns only passing grades, and 1 of each module
    //If an employee fails all retakes, then returns null
    public ArrayList<Module> passingOrFailing(Employee emp){
        boolean passing = true;
        int passFailCounter = 0;
        
        ArrayList<Module> checkScores = new ArrayList<>();
        ArrayList<Module> finalScores = new ArrayList<>();
        
        checkScores = emp.getModScores();
        
        String currentModule = ""; //Name of the current module being worked on
        String previousModule = ""; // Name of the preceeding module
        
        
        for(Module mod: checkScores){
                
                currentModule = mod.getModuleName();
                
                
                //If the proceeding module is not the same as the current one
                //and if the score of the currentModule is passing, then
                //add that score to be stored in the database
                //Resets the pass fail counter if passed
                if(!previousModule.equals(currentModule) && mod.getmoduleScore() >= 70){
                    
                    finalScores.add(mod);
                    passFailCounter = 0;
                
                //If the current and previous modules are the same then it checks if the
                //current module is passing and adds that it to the database. Resets the
                //pass fail counter if passed
                //This is used to out retakes
                } else if (previousModule.equals(currentModule) && mod.getmoduleScore() >= 70) {
                    finalScores.add(new Module(currentModule, 70));
                    passFailCounter = 0;
                
                //If the current module and the previous module are the same then it incriments
                //the counter, when three failures are recorded for a given module name
                //then that student has failed, and will return null
                } else if (previousModule.equals(currentModule) && mod.getmoduleScore() <70){
                    passFailCounter++;
                    if(passFailCounter == 3){ 
                        passing = false; // if 3 failures on a given module then the student fails
                    }
                 //If the current module and the previous module are the different then it incriments
                //the counter, when three failures are recorded for a given module name
                //then that student has failed, and will return null
                } else if (!previousModule.equals(currentModule) && mod.getmoduleScore() < 70 ) {
                    passFailCounter++;
                    if(passFailCounter == 3){
                        passing = false; // if 3 failures on a given module then the student fails
                    }
                }
                previousModule = currentModule;
            }
       
            System.out.println(finalScores);
       
        
        
        if (passing == false){
            return null;
        } else{
            return finalScores;
        }
        
        
        
    }
    
}

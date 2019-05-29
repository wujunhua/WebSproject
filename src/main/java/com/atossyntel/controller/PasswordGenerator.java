package com.atossyntel.controller;

import org.apache.log4j.Logger;

public class PasswordGenerator {
    static final Logger logger = Logger.getLogger(PasswordGenerator.class);
    
    // **JUST CALL THIS METHOD TO GENERATE THE RANDOM PASSWORD. IT WILL TAKE CARE OF EVERYTHING.
    public String generatePassword()
    {
        PasswordGeneratorEngine passwordGenerator = new PasswordGeneratorEngine.PasswordGeneratorBuilder()
                .useDigits(true)
                .useLower(true)
                .useUpper(true)
                .usePunctuation(true)
                .build();
        String password = passwordGenerator.generate(8); // output ex.: lrU12fmM 75iwI90o
        logger.info(password);
        return password;
    }
}

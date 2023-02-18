package commons;

import java.util.Random;

public class RandomPasswordGenerator {	
	
    public static String regeneratePassword() {
        int passwordLength = 8; // Password length
        String validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"; // valid characters
        Random random = new Random();

        StringBuilder password = new StringBuilder(passwordLength);
        for (int i = 0; i < passwordLength; i++) {
            password.append(validChars.charAt(random.nextInt(validChars.length())));
        }        
        return password.toString();
    }
}

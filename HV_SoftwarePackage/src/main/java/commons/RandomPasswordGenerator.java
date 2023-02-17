package commons;

import java.util.Random;

public class RandomPasswordGenerator {	
	
    public static String RandomPasswordGenerator() {
        int passwordLength = 8; // độ dài mật khẩu
        String validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"; // các ký tự hợp lệ
        Random random = new Random();

        StringBuilder password = new StringBuilder(passwordLength);
        for (int i = 0; i < passwordLength; i++) {
            password.append(validChars.charAt(random.nextInt(validChars.length())));
        }        
        return password.toString();
    }
}

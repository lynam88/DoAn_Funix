/**

This is a utility class that contains common methods for the project.
*/
package commons;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

public class Utils {
	
	/**
	 * Converts a string representation of a date in the format "yyyy-MM-dd" to a Date object.
	 * 
	 * @param strDate the string representation of the date
	 * @return a Date object
	 */
	public static Date convertStringToDate(String strDate) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return format.parse(strDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Formats a given date to the format "dd/MM/yyyy".
	 * 
	 * @param strDate the date to format
	 * @return a string representation of the formatted date
	 */
	public static String formatDate(Date strDate) {
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		return format.format(strDate);
	}

	/**
	 * Converts a string representation of a floating-point number to a Float object.
	 * 
	 * @param value the string representation of the floating-point number
	 * @return a Float object
	 */
	public static Float convertStringToFloat(String value) {
		try {
			float amount = Float.parseFloat(value);
			return amount;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Converts a floating-point number to a string representation in currency format.
	 * 
	 * @param value the floating-point number to convert
	 * @return a string representation of the number in currency format
	 */
	public static String convertFloatToCurrency(float value) {
		Locale locale = new Locale("vi", "VN");
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);
		return format.format(value);

	}

	/**
	 * Generates an MD5 hash for the given string.
	 * 
	 * @param str the string to generate the MD5 hash for
	 * @return a string representation of the MD5 hash
	 */
	public static String md5(String str) {
		String result = "";
		MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("MD5");
			digest.update(str.getBytes());
			BigInteger bigInteger = new BigInteger(1, digest.digest());
			result = bigInteger.toString(16);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * Generates a random password of length 8 using a set of valid characters.
	 * 
	 * @return a string representation of the generated password
	 */
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

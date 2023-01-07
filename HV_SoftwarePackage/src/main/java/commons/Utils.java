package commons;

import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class Utils {
	public static boolean checkLogin() {
		return false;
		
	}
	
	public static Date convertStringToDate(String strDate) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		try {
			return format.parse(strDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static Float convertStringToFloat(String value) {
		try {	
			float amount = Float.parseFloat(value);	
			return amount;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}	
		return null;
	}

	public static String convertFloatToCurrency(float value) {
		Locale locale = new Locale("vi", "VN");
		NumberFormat format = NumberFormat.getCurrencyInstance(locale);
		return format.format(value);

	}
}

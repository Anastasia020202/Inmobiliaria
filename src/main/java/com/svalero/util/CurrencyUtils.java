package com.svalero.util;

import java.text.NumberFormat;
import java.text.ParseException;
import java.util.Locale;

public class CurrencyUtils {

    private static final Locale SPANISH_LOCALE = new Locale("es", "ES");

    public static String format(double value) {
        NumberFormat numberFormat = NumberFormat.getCurrencyInstance(SPANISH_LOCALE);
        return numberFormat.format(value);
    }

    public static double parse(String value) throws ParseException {
        NumberFormat numberFormat = NumberFormat.getCurrencyInstance(SPANISH_LOCALE);
        numberFormat.setParseIntegerOnly(false);
        
        // Eliminar posibles espacios en blanco y el símbolo de euro
        String cleanValue = value.trim().replace("€", "").replace(".", "").replace(",", ".");
        
        try {
            return numberFormat.parse(cleanValue).doubleValue();
        } catch (ParseException e) {
            throw new ParseException("No se puede parsear el valor: " + value, e.getErrorOffset());
        }
    }
}
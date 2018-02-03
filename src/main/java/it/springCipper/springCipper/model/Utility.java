package it.springCipper.springCipper.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Utility {
	public static String stampaData(Calendar data) {
		SimpleDateFormat format1 = new SimpleDateFormat("dd");
		SimpleDateFormat format2 = new SimpleDateFormat("MM");
		SimpleDateFormat format3 = new SimpleDateFormat("yyyy");

		int nGior = Integer.parseInt(format1.format(data.getTime()));
		int nMese = Integer.parseInt(format2.format(data.getTime()));
		int nAnno = Integer.parseInt(format3.format(data.getTime()));
		
		String mese="";
		if(nMese==1)  mese = "Gen";
		if(nMese==2)  mese = "Feb";
		if(nMese==3)  mese = "Mar";
		if(nMese==4)  mese = "Apr";
		if(nMese==5)  mese = "Mag";
		if(nMese==6)  mese = "Giu";
		if(nMese==7)  mese = "Lug";
		if(nMese==8)  mese = "Ago";
		if(nMese==9)  mese = "Set";
		if(nMese==10) mese = "Ott";
		if(nMese==11) mese = "Nov";
		if(nMese==12) mese = "Dic";
				
		return nGior+" "+mese+" "+nAnno;
	}
	
	public static String stampaTesto(String testo) {
		return testo.replaceAll("\n", "<br>");
	}
}

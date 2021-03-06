package mboard.controller.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import mboard.dao.CovidStatusDao;

@WebServlet("/covidstatustable")
public class CovidStatusTable extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// String  gubun = request.getParameter("gubun");
		CovidStatusDao csDao = new CovidStatusDao();
		Fnc fnc = new Fnc();
		String period = request.getParameter("period");
		LocalDate today = LocalDate.now();
		
		String api = fnc.getDataPeriod(0).toString();
		
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = null;
			try {
				db = dbf.newDocumentBuilder();
			} catch (ParserConfigurationException e3) {
				e3.printStackTrace();
			}
		Document doc = null;
		try {
			doc = db.parse(new InputSource(new StringReader(api)));
		} catch (SAXException e2) {
			e2.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		doc.getDocumentElement().normalize();
		
		String xml = "";
		
		NodeList itemList = doc.getElementsByTagName("item");
		
		
		if (itemList.getLength() == 0) {
			int dbDate = csDao.getDBDate();
			
			SimpleDateFormat dateParser = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			String sysdate = LocalDate.now().toString();
			Date sysdate2 = null;
			try {
				sysdate2 = dateParser.parse(sysdate);
			} catch (ParseException e) {
			}
			String sysdate3 = dateFormat.format(sysdate2);
			
			int dateGap = Integer.parseInt(sysdate3) - dbDate;
			System.out.println("json empty:"+dateGap);
			
			if (dateGap > 0) {
				// ?????? sys ????????? ~ DB?????? ????????? ???????????? ?????? + 1 ?????? DB??? ??????
				try {
					csDao.insertPeriodData(fnc.getDataPeriod(dateGap - 1));
				} catch (SAXException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (ParserConfigurationException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
				}
			
			//DB?????? 15?????? ???????????? ??????
			xml = csDao.getPeriodRecentData(4).toString();
			//json = vsDao.getPeriodData(period).toString();
		} else {
			
			Node itemNode = itemList.item(0);
			Element itemEle = (Element) itemNode;
			
			
			// String apiDate??? ?????? api ????????? ?????????
			String apiDate = fnc.getValue(itemEle, "stdDay");
			System.out.println("apiDate:"+apiDate);

			// apiDate??? 2021-12-05 ???????????? 20211205???????????? ??????
			SimpleDateFormat dateparser = new SimpleDateFormat("yyyy??? MM??? dd??? HH???");
			Date apiDate2 = null;
			try {
				apiDate2 = dateparser.parse(apiDate);
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			System.out.println("apiDate2:"+apiDate2);
			SimpleDateFormat datefomatter = new SimpleDateFormat("yyyyMMdd");
			String apiDate3 = datefomatter.format(apiDate2);
			System.out.println("apiDate3:"+apiDate3);
			
			// DB?????? ??????????????? ?????????
			int dbDate = csDao.getDBDate();
			System.out.println("dadate:"+dbDate);
			
			int dateGap = Integer.parseInt(apiDate3) - dbDate;
			System.out.println("dbDate:"+dbDate);
			// 20211206 - 20211205 = 1
			// 1??? ????????? ????????? ???????????????
			System.out.println("json not empty:"+dateGap);
			
			if (dateGap > 0) {
				try {
					// ?????? api ????????? ~ DB?????? ????????? ???????????? ??????????????? DB??? ??????
					csDao.insertPeriodData(fnc.getDataPeriod(dateGap - 1));
				} catch (SAXException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (ParserConfigurationException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
				//  dataGap = 0 ?????????, dataGap = 1 ?????????, ?????????, dateGap = 2 ?????????, ?????????, 2????????? .........
				}
			//DB?????? 15?????? ???????????? ??????
			xml = csDao.getPeriodRecentData(4).toString();
			//json = vsDao.getPeriodData(period).toString();
			}
		
		response.setContentType("application/xml;charset=UTF-8");
		PrintWriter out  = response.getWriter();
		out.print( xml );
		out.close();
		
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	class Fnc{
		
		StringBuilder sb =null;
		
		StringBuilder getDataPeriod(int period) throws IOException {
			LocalDate now = LocalDate.now();
			System.out.println("todayminus" + now.minus(Period.ofDays(1)));
			
			 LocalDate oneDayAgo = now.minusDays(period); 
			 String startCreateDt = oneDayAgo.format(DateTimeFormatter.ofPattern("yyyyMMdd")); //15
			 String endCreateDt =now.format(DateTimeFormatter.ofPattern("yyyyMMdd")); //??????
			 System.out.println("startCreateDt:" + startCreateDt);
			 System.out.println("endCreateDt:" + endCreateDt);
			
			String  key      = "OpXrReIFM3WssvT1gl8awDpSJusm5iswRhH80AwQNFPNUCPbDXxRmfNkrTarhDCq6N0Izazwla%2FOMt9RlBpc%2Fw%3D%3D"; 
			   // ?????? ????????? (Encoding)
			
			// ??????
			StringBuilder  urlBuilder = new StringBuilder(
				"http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson"); // URL
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")    + "=" + key);
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8")        + "=" + URLEncoder.encode("1", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8")     + "=" + URLEncoder.encode("10", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode(startCreateDt, "UTF-8"));
			//urlBuilder.append("&" + URLEncoder.encode("startCreateDt", "UTF-8") + "=" + URLEncoder.encode("20211201", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8")   + "=" + URLEncoder.encode(endCreateDt, "UTF-8"));
			//urlBuilder.append("&" + URLEncoder.encode("endCreateDt", "UTF-8")   + "=" + URLEncoder.encode("20211202", "UTF-8"));
			// urlBuilder.append("&" + URLEncoder.encode("GUBUN", "UTF-8")         + "=" + URLEncoder.encode(gubun, "UTF-8"));
			
			URL  url   =  new URL( urlBuilder.toString() );
			System.out.println(url);
			HttpURLConnection  conn = (HttpURLConnection) url.openConnection(); // $.ajax
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/xml");
			System.out.println("Response Code:" + conn.getResponseCode());  // 200, 404, 500
			
			// ????????? ????????? ??????
			BufferedReader   br;
			if( conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300 ) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream() ));
			} else {
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream() ));			
			}
			
			//  data -> ???????????? ??????
			 sb     = new StringBuilder();
			String         line;
			while( ( line = br.readLine() ) != null ) {
				sb.append( line );
			}
			br.close();
			conn.disconnect();
			
			return sb;
		}
		
		String getValue(Element Ele, String tag) {
			
			NodeList nList = Ele.getElementsByTagName(tag);
			Element nElmnt = (Element) nList.item(0);
			Node nNode = nElmnt.getFirstChild();
			return nNode.getNodeValue();
		}
	}
	
}
package mboard.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.dao.CountryCovidStatusDao;

@WebServlet("/getdbdate")
public class GetDBDate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		CountryCovidStatusDao ccsDao = new CountryCovidStatusDao();
		int date = ccsDao.getDBDate();
		System.out.println("getdbdate:"+date);
		
		request.setAttribute("date", date);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

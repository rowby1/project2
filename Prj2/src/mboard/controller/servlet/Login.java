package mboard.controller.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.dao.MemDao;
import mboard.vo.LocVo;

@WebServlet("/login")
public class Login extends HttpServlet {
	private String id;
	private String pw;
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		id = request.getParameter("id");
		pw = request.getParameter("pw");
		MemDao memDao = new MemDao();
		boolean result = memDao.doLogin(id, pw);
		
		if (result == true) {
			session.setAttribute("id", id);
			session.setAttribute("nickname", memDao.getNickname());
			session.setAttribute("email", memDao.getEmail());
			
			int loc = memDao.getLocStatus();
			session.setAttribute("locstatus", loc);
			List<LocVo> list = memDao.getLoc(id);
			LocVo home = null;
			LocVo office = null;
			List<LocVo> extraloc = new ArrayList<LocVo>();
			
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getName().equals("home"))
					home = list.get(i);
				else if (list.get(i).getName().equals("office"))
					office = list.get(i);
				else {
					extraloc.add(list.get(i));
				}
			}
			
			switch (loc) {
			case 0: break; 
			case 1: String[] homeloc = home.getAddress().split(" ");
					session.setAttribute("sido", homeloc[0]);
					session.setAttribute("sigungu", homeloc[1]);
					session.setAttribute("selectedloc", home.getAddress());
					break;
			case 2: String[] officeloc = office.getAddress().split(" ");
					session.setAttribute("sido", officeloc[0]);
					session.setAttribute("sigungu", officeloc[1]);
					session.setAttribute("selectedloc", office.getAddress());
					break;
			case 3: String[] loc1 = extraloc.get(0).getAddress().split(" ");
					session.setAttribute("sido", loc1[0]);
					session.setAttribute("sigungu", loc1[1]);
					session.setAttribute("selectedloc", extraloc.get(0).getAddress());
					System.out.println(extraloc.get(0).getAddress());
					break;
			case 4: String[] loc2 = extraloc.get(1).getAddress().split(" ");
					session.setAttribute("sido", loc2[0]);
					session.setAttribute("sigungu", loc2[1]);
					session.setAttribute("selectedloc", extraloc.get(1).getAddress());
					System.out.println(extraloc.get(1).getAddress());
					break;
			case 5: String[] loc3 = extraloc.get(2).getAddress().split(" ");
					session.setAttribute("sido", loc3[0]);
					session.setAttribute("sigungu", loc3[1]);
					session.setAttribute("selectedloc", extraloc.get(2).getAddress());
					System.out.println(extraloc.get(2).getAddress());
					break;
			}
			
			
			String path = "/view/Home.jsp";
			request.getRequestDispatcher(path).forward(request, response);
		} else {
			response.sendRedirect("/view/login.jsp");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

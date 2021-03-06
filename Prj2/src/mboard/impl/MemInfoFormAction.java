package mboard.impl;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mboard.base.Action;
import mboard.dao.MemDao;
import mboard.vo.LocVo;

public class MemInfoFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		MemDao memDao = new MemDao();
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
		
		request.setAttribute("home", home);
		request.setAttribute("office", office);
		request.setAttribute("extraloc", extraloc);
		
		String path = "view/memEdit.jsp";
		request.getRequestDispatcher(path).forward(request, response);
	}

}

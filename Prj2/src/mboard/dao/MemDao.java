package mboard.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import db.DBConn;
import mboard.vo.LocVo;
import mboard.vo.MemViewVo;
import mboard.vo.MemVo;





public class MemDao {
	private Connection          conn   = null;
	private PreparedStatement pstmt  = null;
	private String nickname;
	private String email;
	private int locstatus = 0;
	private CallableStatement   cstmt  = null;
	
	public String getNickname() {
		return nickname;
	}
	
	public String getEmail() {
		return email;
	}
	
	public int getLocStatus() {
		return locstatus;
	}
	
	public boolean doLogin(String id, String pw) {
		boolean login = false;
		ResultSet rs = null;
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "SELECT NICKNAME, LOCSTATUS, EMAIL"
					+ " FROM MEMBERS"
					+ " WHERE ID = ? AND PASSWORD = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				nickname = rs.getString("NICKNAME");
				locstatus = rs.getInt("LOCSTATUS");
				email = rs.getString("EMAIL");
				
				login = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
				if (rs != null) rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return login;
	}
	
	public int doRegInfo(MemVo memVo) {
		int aftcnt = 0;
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "INSERT INTO MEMBERS"
					+ " VALUES(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memVo.getId());
			pstmt.setString(2, memVo.getPassword());
			pstmt.setString(3, memVo.getEmail());
			pstmt.setString(4, memVo.getNickname());
			pstmt.setInt(5, memVo.getLocstatus());
			
			aftcnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return aftcnt;
	}
	
	public int doRegLoc(String id, String name, String loc) {
		int aftcnt = 0;
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "INSERT INTO ADDRESS"
					+ " VALUES((SELECT NVL(MAX(ADDRESS_NUM), 0) + 1 FROM ADDRESS), ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, loc);
			
			aftcnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return aftcnt;
	}

	public boolean verifyId(String id) {
		boolean verifyId = false;
		ResultSet rs = null;
		
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "SELECT ID"
					+ " FROM MEMBERS"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				verifyId = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
				if (rs != null) rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return verifyId;
	}
	
	public boolean verifyNick(String nickname) {
		boolean verifyNick = false;
		ResultSet rs = null;
		
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "SELECT ID"
					+ " FROM MEMBERS"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				verifyNick = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
				if (rs != null) rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return verifyNick;
	}
	
	
	
	public List<LocVo> getLoc(String id) {
		List<LocVo> list = new ArrayList<LocVo>();
		LocVo locVo = null;
		ResultSet rs = null;
		int cnt = 0;
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			/*
			String sql = "SELECT COUNT(ADDRESS_NUM) cnt"
						+ " FROM ADDRESS WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			 */
			
			String sql = "SELECT ADDRESS_NUM, ID, NAME, ADDRESS"
					+ "	FROM ADDRESS WHERE id = ?"
					+ "	ORDER BY ADDRESS_NUM";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
					locVo = new LocVo(rs.getInt("ADDRESS_NUM"), rs.getString("ID"), rs.getString("NAME"), rs.getString("ADDRESS"));
					list.add(locVo);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public MemViewVo getMem(String corona_id) {
		MemViewVo      memviewvo  =  null;
		
		try {
			DBConn   db   =   new DBConn();
			conn          =   db.getConnection();
			String   sql  =   "{CALL  PKG_MEM.PROC_MEM_VIEW(?, ?, ?, ?, ?, ?, ?, ?)}";			
			cstmt         =   conn.prepareCall(sql);
			
			cstmt.setString( 1, corona_id );
			// OUT PARAMETER ??????
			cstmt.registerOutParameter( 2, Types.VARCHAR );
			cstmt.registerOutParameter( 3, Types.VARCHAR );
			cstmt.registerOutParameter( 4, Types.VARCHAR );
			cstmt.registerOutParameter( 5, Types.VARCHAR );
			cstmt.registerOutParameter( 6, Types.VARCHAR );
			cstmt.registerOutParameter( 7, Types.VARCHAR );
			cstmt.registerOutParameter( 8, Types.VARCHAR );
			
			cstmt.execute();  //  ??????????????????
			//1  2  3  4  5  6  7  8  
			//?, ?, ?, ?, ?, ?, ?, ?  
			
															
			// ????????? ???????????????
			String  o_mem_id   			 = cstmt.getString(2);
			String  o_mem_name 			 = cstmt.getString(3);
			String  o_mem_tel 			 = cstmt.getString(4);
			String  o_mem_email 		 = cstmt.getString(5);
			String  o_mem_sido 			 = cstmt.getString(6);
			String  o_mem_sigungu 		 = cstmt.getString(7);
			String  o_mem_eup_myeon_dong = cstmt.getString(8);
			
			memviewvo  = new MemViewVo(o_mem_id, o_mem_name, 
					o_mem_tel, o_mem_email, o_mem_sido, o_mem_sigungu, o_mem_eup_myeon_dong);
			
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
			try {
				if( cstmt != null ) cstmt.close();
				if( conn  != null ) conn.close();
			} catch (SQLException e) {
			}
		}
		
		return   memviewvo;
	}

	public void doUpdateInfo(String id, String pw) {
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "UPDATE MEMBERS"
					+ "	SET PW = ?"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		try {
			if( cstmt != null ) cstmt.close();
			if( conn  != null ) conn.close();
		} catch (SQLException e) {
			}
		}
	}

	public void doUpdateLoc(LocVo locVo) {
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "UPDATE MEMBERS"
					+ "	SET PW = ?"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		try {
			if( cstmt != null ) cstmt.close();
			if( conn  != null ) conn.close();
		} catch (SQLException e) {
			}
		}
	}

	public int doEditInfo(MemVo memVo) throws SQLException {
		int aftcnt = 0;
		DBConn db = new DBConn();
		conn = db.getConnection();
		String sql = "";
		if (memVo.getPassword().isEmpty() || memVo.getPassword() == null) {
			sql = "UPDATE MEMBERS"
					+ "	SET NICKNAME = ?,"
					+ " EMAIL = ?,"
					+ "	LOCSTATUS = ?"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memVo.getNickname());
			pstmt.setString(2, memVo.getEmail());
			pstmt.setInt(3, memVo.getLocstatus());
			pstmt.setString(4, memVo.getId());
		} else {
			sql = "UPDATE MEMBERS"
					+ "	SET NICKNAME = ?,"
					+ " EMAIL = ?,"
					+ "	LOCSTATUS = ?,"
					+ "	PASSWORD = ?"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memVo.getNickname());
			pstmt.setString(2, memVo.getEmail());
			pstmt.setInt(3, memVo.getLocstatus());
			pstmt.setString(4, memVo.getPassword());
			pstmt.setString(5, memVo.getId());
			
		}
		
		aftcnt = pstmt.executeUpdate();
		
		if( cstmt != null ) cstmt.close();
		if( conn  != null ) conn.close();
		return aftcnt;
	}

	public int doDeleteLoc(String id) {
		int aftcnt = 0;
		try {
			DBConn db = new DBConn();
			conn = db.getConnection();
			String sql = "DELETE ADDRESS"
					+ " WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			aftcnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) conn.close();
				if (pstmt != null) pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return aftcnt;
	}
}

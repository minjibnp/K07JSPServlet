package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.sun.xml.internal.ws.api.ha.StickyFeature;


public class MemberDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//기본생성자를 통한 DB연결
	public MemberDAO() {
		String driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		try {
			Class.forName(driver);
			String id = "kosmo";
			String pw = "1234";
			con = (Connection) DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공");
		}
		
		catch (Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
		

	}
	
	//인자생성자 : 오라클드라이버와 url을 매개변수로 받아 연결한다.
	public MemberDAO(String driver, String url) {

		try {
			Class.forName(driver);
			String id = "kosmo";
			String pw = "1234";
			con = (Connection) DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(인자생성자)");
		}
		
		catch (Exception e) {
			System.out.println("DB연결실패(인자생성자)");
			e.printStackTrace();
		}
		

	}
	
	//그룹함수 count()를 통해 회원의 존재유무만 판단한다.
	public boolean isMember(String id, String pass) {
		//쿼리문 작성
		String sql = "SELECT COUNT(*) FROM member "
					+" WHERE id=? AND pass=?";
		int isMember = 0;
		boolean isFlag = false;
		
		try {
			//prepare객체를 통해 쿼리문을 전송한다.
			psmt = con.prepareStatement(sql);
			//쿼리문의 인파라미터 설정(DB의 인덱스는 1부터 시작)
			psmt.setString(1, id);
			psmt.setString(2, pass);
			//쿼리문 실행후 결과는 ResultSet객체를 통해 반환받음
			rs = psmt.executeQuery();
			//실행결과를 가져오기 위해 next()를 호출한다
			rs.next();
			//select절의 첫번째 결과값을 얻어오기 위해 getInt()사용함.
			isMember = rs.getInt(1);
			System.out.println("affected:"+isMember);
			if(isMember==0) //회원이 아닌경우
				isFlag = false;
			else //회원인 경우(해당 아이디, 패스워드가 일치함)
				isFlag = true;
			
		}
		catch (Exception e) {
			//예외가 발생한다면 확인이 불가능하므로 무조건 false를 반환한다.
			isFlag = false;
			e.printStackTrace();
		}
		return isFlag;
	}
	//로그인방법2 : 회원인증후 MemberDTO객체에 회원정보를 저장한 후 JSP쪽으로 반환해준다.
	public MemberDTO getMemberDTO(String uid, String upass) {
		//회원정보 저장을 위해 DTO객체 생성
		MemberDTO dto = new MemberDTO();
		
		//회원정보를 가져오기 위한 쿼리문 작성
		String query = "SELECT id, pass, name FROM"
					+ " member WHERE id=? AND pass=?";
		
		try {
			//prepare객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리실행
			rs = psmt.executeQuery();
			//오라클이 반환해준 ResultSet을 통해 결과값이 있는지 확인
			if(rs.next()) {
				//결과가 있다면 DTO객체에 정보저장
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
			
		}
		
		catch (Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		return dto;
	}
	
	//로그인방법 3 : DTO객체대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> getMemberMap(String id, String pwd){
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();
		
		String query = "SELECT id, pass, name FROM"
				+ " member WHERE id=? AND pass=?";
		
		try {
			//prepare객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			//쿼리실행
			rs = psmt.executeQuery();
			//회원정보가 있다면 put()을 통해 정보를 저장한다.
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString("pass"));
				maps.put("name",rs.getString("name"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
			
		}
		
		catch (Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		
		return maps;
	}
	
	//아이디만 전달하면 회원정보를 Map컬렉션으로 반환
	public Map<String, String> getMemberMap(String id){
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();
		
		String query = "SELECT id, pass, name FROM"
				+ " member WHERE id=?";
		
		try {
			//prepare객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, id);
			//쿼리실행
			rs = psmt.executeQuery();
			//회원정보가 있다면 put()을 통해 정보를 저장한다.
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString("pass"));
				maps.put("name",rs.getString("name"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
			
		}
		
		catch (Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		
		return maps;
	}
	public static void main(String[] args) {
		new MemberDAO();
	}
	
	//비밀번호 변경 메소드-지훈ver 추가
	public boolean changeClientPass(String newpass, String id, String pw) {
		int affected = 0;
		
		String query = "UPDATE member SET "
					+ " pass='"+newpass+"'"
					+ " WHERE id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			
			affected = psmt.executeUpdate();
			
			if(affected==1) {
				//디버깅용
				System.out.println("비밀번호 변경 성공!");
				return true;
			}
			else {
				return false;
			}
		}
		
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}

<%@page import="model.MyFileDAO"%>
<%@page import="model.MyfileDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//한글깨짐처리(post로 폼값 전송시 꺠짐 부분 처리)
request.setCharacterEncoding("UTF-8");

String saveDirectory = application.getRealPath("/Upload");
//업로드할 최대용량 설정. 5MB
int maxPostSize = 1024*5000;
//3.인코딩 방식 설정
String encoding = "UTF-8";

FileRenamePolicy policy = new DefaultFileRenamePolicy();

//멀티파트 객체 생성 및 전송된 폼값을 저장하기 위한 변수 선언
//전송된 폼값을 저장하기 위한 변수생성.생성 안될시 업로드에 실패.
MultipartRequest mr = null;
String name = null;
String title = null;
StringBuffer inter = new StringBuffer();


File oldFile=null;
File newFile=null;
String realFileName=null;
try{

    mr = new MultipartRequest(request, saveDirectory, maxPostSize,
            encoding, policy);
//////////추가부분 start//////////////////

  //서버에 저장된 파일명 가져오기
    String fileName=mr.getFilesystemName("chumFile1");
    
    /*
    	파일명을 변경하기 위해 현재날짜와 시간을 얻어온다.
    	특히 서식중 대문자 S는 초를 1/1000단위로 가져오게 된다.
    */
    String nowTime=new SimpleDateFormat("yyyy_MM_dd_H_m_s_S")
                   .format(new Date());
    
    /*
    	파일의 확장자를 가져오기 위해 파일명의 마지막에 있는 점의 위치를 찾는다.
    	따라서 lastIndexOf()를 통해 찾아서 확장자를 따낸다.
    */
    int idx= -1;   
    idx = fileName.lastIndexOf(".");
    //시간을 통해 얻은 문자열과 확장자를 합쳐준다.
    realFileName = nowTime+fileName.substring(idx,fileName.length());
    
    
    /*
    	서버의 물리적경로와 생성된 파일명을 통해 File객체를 생성한다.
    	파일객체.separator : 파일경로를 나타낼 때 윈도우와 리눅스는 각각
    		\혹은 /와 같이 os에 따라 구분기호가 다른데, 해당 OS에 맞는
    		구분기호를 구해주는 역할을 한다.
    */
    oldFile = new File(saveDirectory+oldFile.separator+fileName);
    newFile = new File(saveDirectory+oldFile.separator+realFileName);
    
    //저장된 파일명을 변경한다.
    oldFile.renameTo(newFile);
    
    /////////////////////////////////////////////////////////
         
      
      name = mr.getParameter("name");
      title = mr.getParameter("title");
      String[] interArr = mr.getParameterValues("inter");
      for(String s : interArr){
    	  inter.append(s+",");
      }
      
      MyfileDTO dto = new MyfileDTO();
      dto.setName(name);
      dto.setTitle(title);
      dto.setInter(inter.toString());
      dto.setOfile(mr.getOriginalFileName("chumFile1"));//원본파일명
      dto.setSfile(realFileName);//서버에 저장된 파일명
      
      //DAO객체 생성후 DB연결 및 insert처리
      MyFileDAO dao = new MyFileDAO(application);
      dao.myfileInsert(dto);
      
      //DB처리 후 페이지 이동
      response.sendRedirect("FileList.jsp");   
}
catch(Exception e){
   request.setAttribute("errorMessage", "파일업로드오류");
   request.getRequestDispatcher("FileUploadMain.jsp")
      .forward(request, response);
}
%>
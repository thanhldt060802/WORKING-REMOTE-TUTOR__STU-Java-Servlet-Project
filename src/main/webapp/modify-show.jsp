<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.Seat"%>
<%@page import="model.Movie"%>
<%@page import="model.Show"%>
<%@page import="model.Theater"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="./partial/header.jsp"></jsp:include>
	<h1>CHỈNH SỬA THÔNG TIN XUẤT CHIẾU</h1>
	
	<%
	Show foundShow = (Show) request.getAttribute("foundShow");
	Movie foundMovie = (Movie) request.getAttribute("foundMovie");
	Theater foundTheater = (Theater) request.getAttribute("foundTheater");
	List<Seat> seatList = (List<Seat>) request.getAttribute("seatList");
	%>
		
	<form id="simple-form" enctype="application/x-www-form-urlencoded;charset=UTF-8">
		Mã số xuất chiếu:&emsp;<input id="id" type="text" value="<%= foundShow.getShowId() %>" readonly="readonly"/>
		<br>
		Tên phim:&emsp;<input id="movie-id" type="text" value="<%= foundMovie.getTitle() %>" readonly="readonly"/>
		<br>
		Tên rạp:&emsp;<input id="theater-id" type="text" value="<%= foundTheater.getName() %>" readonly="readonly"/>
		<br>
		Thời gian:&emsp;<input id="start-at" type="date" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(foundShow.getStartAt()) %>"/>
		<br>
		<button type="button" onclick="submitFormUpdateShow()">Cập nhật</button>
		<button type="button" onclick="deleteShow('<%= foundShow.getShowId() %>')">Xoá</button>
		<button type="button" onclick="resetForm()">Làm mới</button>
	</form>
	
	<br>
	
	<ul>
		<%
		for(Seat seat : seatList) {
		%>
		<li><%= seat.getSeatNumber() %></li>
		<%
		}
		%>
	</ul>
	
	<script>
		function submitFormUpdateShow() {
			const form = document.getElementById("simple-form");
			
			const params = new URLSearchParams();
		    params.append("idInput", document.getElementById("id").value);
		    params.append("startAtInput", document.getElementById("start-at").value);
	
		    fetch("./updateShow", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
		        },
		        body: params.toString()
		    })
		    .then(response => {
	            if(response.redirected) {
	                window.location.href = response.url;
	            }
        	})
		    .catch(error => {
		        console.error("Lỗi:", error);
		        alert("Đã xảy ra lỗi khi gửi dữ liệu.");
		    });
		}
		
		function deleteShow(id) {
			window.location.href = "./deleteShow?id=" + id
		}
		
		function resetForm() {
			location.reload();
		}
	</script>

</body>
</html>
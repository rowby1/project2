<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.card.card-info {
	width: 600px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Theme style -->
<link rel="stylesheet" href="../dist/css/adminlte.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		$('#join').on('click', function(){
			location.href = 'memReg.jsp';
		})
		
		$('#cancel').on('click', function(){
			location.href = 'Home.jsp';
		})
	});
</script>
</head>
<body>
	<main>
			<!-- Horizontal Form -->
			<div class="card card-info">
				<div class="card-header">
					<h3 class="card-title">로그인</h3>
				</div>
				<!-- /.card-header -->
				<!-- form start -->
				<form class="form-horizontal" action="/mboard?cmd=LOGIN" method="POST">
					<div class="card-body">
						<div class="form-group row">
							<label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputEmail3" name="id"
									placeholder="ID">
							</div>
						</div>
						<div class="form-group row">
							<label for="inputPassword3" class="col-sm-2 col-form-label">패스워드</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="inputPassword3" name="pw"
									placeholder="Password">
							</div>
						</div>
						<div class="form-group row">
							<div class="offset-sm-2 col-sm-10">
							<code id="loginfail"></code>
						
							</div>
						</div>
					</div>
					<!-- /.card-body -->
					<div class="card-footer">
						<button type="submit" class="btn btn-info">로그인</button>
						<button type="button" class="btn btn-info" id="join">가입</button>
						<button type="button" class="btn btn-default float-right" id="cancel">뒤로가기</button>
						<!--                   <button type="submit" class="btn btn-default float-right">Cancel</button> -->
					</div>
					<!-- /.card-footer -->
				</form>
			</div>
			<!-- /.card -->
	</main>
</body>
</html>
<!-- <h2>개인 코로+나 정보: covidinfoform.jsp</h2>
	<form action="/mboard?cmd=LOGIN" method="POST">
		<table>
			<tr>
				<td colspan="2" class="right">
					<a href="/mboard?cmd=MENULIST">회원가입</a>
				</td>
			</tr>	
			<tr>
				<td>아이디</td>
				<td><input type="text" name="corona_id" value = "1" /></td>
			</tr>	
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="corona_pwd" value = "1" /></td>
			</tr>	
			<tr>
				<td colspan="2">
				<input type="submit" value="로그인" />
				</td>
			</tr>	

			
		</table>
	</form> -->
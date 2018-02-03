<script>
	$(document).ready( function(){
		if(document.getElementById('erroreLogin').value != ''){
			checkEmailLogin(document.getElementById('emailLogin').value);
			$("#passwordLogin").addClass("is-invalid");
			$("#passwordLogin").focus();
			
			$("#controlloLogin").html("La password è errata");
		}
		else{
			$("#emailLogin").focus();
		}
		
		if(document.getElementById('erroreRegistrazione').value != ''){
			checkUsername(document.getElementById('usernameRegistrazione').value);
			checkEmail(document.getElementById('emailRegistrazione').value);
			checkPsw();
			
			$("#nav-login-tab").removeClass("active");
			$("#nav-registrazione-tab").addClass("active");

			$("#nav-login").removeClass("show");
			$("#nav-login").removeClass("active");
			$("#nav-registrazione").addClass("show");
			$("#nav-registrazione").addClass("active");
		}
		
		if(document.getElementById('erroreRecuperaPsw').value != ''){
			$("#emailRecuperaPsw").addClass("is-invalid");
			
			$("#controlloEmailRecuperaPsw").html("L'email inserita non è stata trovata");
			
			$("#nav-login-tab").removeClass("active");
			$("#nav-recuperaPsw-tab").addClass("active");

			$("#nav-login").removeClass("show");
			$("#nav-login").removeClass("active");
			$("#nav-recuperaPsw").addClass("show");
			$("#nav-recuperaPsw").addClass("active");
		}
		if(document.getElementById('messaggioRecuperaPsw').textContent != ''){
			$("#nav-login-tab").removeClass("active");
			$("#nav-recuperaPsw-tab").addClass("active");

			$("#nav-login").removeClass("show");
			$("#nav-login").removeClass("active");
			$("#nav-recuperaPsw").addClass("show");
			$("#nav-recuperaPsw").addClass("active");			
		}
	});

	function checkEmailLogin(param){
		 $.ajax({  
	          type: "POST",
	          url: "/checkEmailLogin",  
	          data: "email=" + param,
	          success: function(data) {
	        	  	if(data){
	        	  		$("#emailLogin").removeClass("is-invalid");
	        	  		$("#emailLogin").addClass("is-valid");
	        	  		
	            		$("#controlloEmailLogin").html("<br>");
	            	} 
	        	  	else{
	        	  		$("#emailLogin").removeClass("is-valid");
	        	  		$("#emailLogin").addClass("is-invalid");
	        	  		
	        	  		$("#controlloEmailLogin").html("L'email inserita non è stata trovata");
	        	  	}
	          },
	          error: function(){
	            alert("Chiamata fallita!!!");
	          } 
		}); 
	}
	
	function checkUsername(param){
		 $.ajax({  
	          type: "POST",
	          url: "/checkUsername",  
	          data: "username=" + param,
	          success: function(data) {
	        	  	if(data){
	        	  		$("#usernameRegistrazione").removeClass("is-valid");
	        	  		$("#usernameRegistrazione").addClass("is-invalid");
	        	  		
	            		$("#controlloUsername").html("username già utilizzato");
	            	} 
	        	  	else{
	        	  		$("#usernameRegistrazione").removeClass("is-invalid");
	        	  		$("#usernameRegistrazione").addClass("is-valid");
	        	  		
	        	  		$("#controlloUsername").html("<br>");
	        	  	}
	          },
	          error: function(){
	            alert("Chiamata fallita!!!");
	          } 
		}); 
	}
	
	function checkEmail(param){
		 $.ajax({  
	          type: "POST",
	          url: "/checkEmail",  
	          data: "email=" + param,
	          success: function(data) {
	        	  	if(data){
	        	  		$("#emailRegistrazione").removeClass("is-valid");
	        	  		$("#emailRegistrazione").addClass("is-invalid");
	        	  		
	            		$("#controlloEmail").html("l'email già utilizzato");
	            	} 
	        	  	else{
	        	  		$("#emailRegistrazione").removeClass("is-invalid");
	        	  		$("#emailRegistrazione").addClass("is-valid");
	        	  		
	        	  		$("#controlloEmail").html("<br>");
	        	  	}
	          },
	          error: function(){
	            alert("Chiamata fallita!!!");
	          } 
		}); 
	}
	
	function checkPsw(){
		$.ajax({
			type: "POST",
	       	url: "/checkPswRegistrazione",  
	        success: function(data){
	        		if (document.getElementById('passwordRegistrazione').value == ''){
	        			$("#passwordRegistrazione").removeClass("is-valid");
	        	  		$("#passwordRegistrazione").addClass("is-invalid");
	        	  		
	        	  		$("#confPasswordRegistrazione").removeClass("is-valid");
	        	  		$("#confPasswordRegistrazione").addClass("is-invalid");
	        	  		
	        	  		$("#controlloPsw").html("inserire una password");
	        	  		$("#controlloConfPsw").html("<br>");
	        		}
	        		else if (document.getElementById('passwordRegistrazione').value != document.getElementById('confPasswordRegistrazione').value){
	        			$("#passwordRegistrazione").removeClass("is-valid");
	        	  		$("#passwordRegistrazione").addClass("is-invalid");
	        	  		
	        	  		$("#confPasswordRegistrazione").removeClass("is-valid");
	        	  		$("#confPasswordRegistrazione").addClass("is-invalid");
	        	  		
	        	  		$("#controlloConfPsw").html("le password non coincidono");
	        	  		$("#controlloPsw").html("<br>");
	        		}
	        		else{
	        			$("#passwordRegistrazione").removeClass("is-invalid");
	        	  		$("#passwordRegistrazione").addClass("is-valid");
	        	  		
	        	  		$("#confPasswordRegistrazione").removeClass("is-invalid");
	        	  		$("#confPasswordRegistrazione").addClass("is-valid");
	        	  		
	        	  		$("#controlloConfPsw").html("<br>");
	        	  		$("#controlloPsw").html("<br>");
	        		}
	        }
		});
	}

	function checkEmailRecuperaPsw(param){
		$.ajax({  
			type: "POST",
			url: "/checkEmailRecuperaPsw",	          
			data: "email=" + param,
	        success: function(data){
	       		if(data){
	       			$("#emailRecuperaPsw").removeClass("is-invalid");
        	  			$("#emailRecuperaPsw").addClass("is-valid");
        	  			
	        	  		$("#controlloEmailRecuperaPsw").html("<br>");
	       		}
	       		else{
	       			$("#emailRecuperaPsw").addClass("is-invalid");
    	  				$("#emailRecuperaPsw").removeClass("is-valid");
    	  			
        	  			$("#controlloEmailRecuperaPsw").html("L'email inserita non è stata trovata");
	       		}
	        }
		});
	}
</script>

<br><br>
<nav>
	<div class="nav nav-tabs justify-content-center" id="nav-tab" role="tablist">
		<a class="nav-item nav-link font-weight-light text-dark" id="nav-recuperaPsw-tab" 	  data-toggle="tab" href="#nav-recuperaPsw" 	 role="tab" aria-controls="nav-recuperaPsw" 	aria-selected="false">Recupera Password</a>
		<a class="nav-item nav-link font-weight-light text-dark active" id="nav-login-tab"  data-toggle="tab" href="#nav-login" 		 role="tab" aria-controls="nav-login"    		aria-selected="true">Login</a>
		<a class="nav-item nav-link font-weight-light text-dark" id="nav-registrazione-tab" data-toggle="tab" href="#nav-registrazione" role="tab" aria-controls="nav-refistrati" 	aria-selected="false">Registrazione</a>
	</div>
</nav>
<div class="tab-content" id="nav-tabContent">
	<div class="tab-pane fade show active" id="nav-login" role="tabpanel" aria-labelledby="nav-login-tab">
		<br><br>
		<div class="col-md-10 offset-md-1">
			<div class="card border-secondary">
			  	<div class="card-header" style="background-color: #432B68;">
					<h1 style="text-align: center;" class="col-12 font-weight-light text-light">Login</h1>
				</div>
				<div class="card-body">
					<form action="login" method="post">
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-1 ml-1"><i class="fa fa-envelope-o"></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="emailLogin" type="text" name="email" placeholder="email" value='${ email }' >
									<div id="controlloEmailLogin" class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>
						
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-2 ml-2"><i class="fa fa-lock"></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="passwordLogin" type="password" name="psw" placeholder="password">
									<div id="controlloLogin"   class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>			
						
						<br>
						<input type="hidden" id="erroreLogin" value="${ errori }" >
						
						<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light col-md-8 offset-md-2">Login</button>
					</form>
				</div>
				<br>
			</div>
		</div>
		  
	</div>
	<div class="tab-pane fade" id="nav-registrazione" role="tabpanel" aria-labelledby="nav-registrati-tab">
		<br><br>
		<div class="col-md-10 offset-md-1">
			<div class="card border-secondary" id="cardRegistrazione">
	  			<div class="card-header" style="background-color: #432B68;">
					<h1 style="text-align: center;" class="col-12 font-weight-light text-light">Registrati</h1>
				</div>
				<div class="card-body">
					<form action="registrazione" method="post">
				
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-1 ml-2"><i class="fa fa-user"></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="usernameRegistrazione" onchange="checkUsername(this.value);" type="text" name="usernameRegistrazione" placeholder="username" value='${ usernameRegistrazione }' >
									<div id="controlloUsername"   class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>
						
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-1 ml-1"><i class="fa fa-envelope-o"></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="emailRegistrazione" onchange="checkEmail(this.value);" type="text" name="emailRegistrazione" placeholder="email" value='${ emailRegistrazione }' >
									<div id="controlloEmail"   class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>
						
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-2 ml-2"><i class="fa fa-lock"></i></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="passwordRegistrazione" onchange="checkPsw();" 		type="password" name="pswRegistrazione" placeholder="password" value='${ pswRegistrazione }'>
									<div id="controlloPsw"   class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>
						
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-2 ml-2"><i class="fa fa-lock"></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="confPasswordRegistrazione" onchange="checkPsw();"	type="password" name="confpswRegistrazione" placeholder="conferma password" value='${ confPswRegistrazione }'>
									<div id="controlloConfPsw"   class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>
						
						<br>
						<input type="hidden" id="erroreRegistrazione" value="${ erroriRegistrazione }" >
						
						<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light col-md-8 offset-md-2">Registrati</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="tab-pane fade" id="nav-recuperaPsw" role="tabpanel" aria-labelledby="nav-recuperaPsw-tab">
		<br><br>
		<div class="col-md-10 offset-md-1">
			<div class="card border-secondary" id="cardRecuperaPsw">
	  			<div class="card-header" style="background-color: #432B68;">
					<h1 style="text-align: center;" class="col-12 font-weight-light text-light">Recupera Password</h1>
				</div>
				<div class="card-body">
					<form action="recuperaPsw" method="post">
						<div class="col-md-8 offset-md-2">
							<div class="row">
								<div class="col-1">
									<h4 class="mt-1 ml-1"><i class="fa fa-envelope-o"></i></h4>
								</div>
								<div class="col-11">
									<input class="form-control font-weight-light" id="emailRecuperaPsw" onchange="checkEmailRecuperaPsw(this.value);" type="text" name="emailRecuperaPsw" placeholder="email" value='${ emailRecuperaPsw }' >
									<div id="controlloEmailRecuperaPsw" class="font-weight-light text-danger"><br></div>
								</div>
							</div>
						</div>
						
						<input type="hidden" id="erroreRecuperaPsw" value="${ erroriRecuperaPsw }" >
						<div class="col-md-8 offset-md-2" style="text-align: center;"> 
							<h3 id="messaggioRecuperaPsw" class="font-weight-light text-success">${messaggioRecuperaPsw}</h3>
						</div>
						<br>
						
						<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light col-md-8 offset-md-2">Conferma</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

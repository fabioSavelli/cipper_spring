<script>
	$(document).ready( function(){
		if(document.getElementById('erroreUsername').value != ''){
			$("#username").removeClass("is-valid");
			$("#username").addClass("is-invalid");
			
			$("#controlloUsername").html("Inserire un username valido");
		}
		if(document.getElementById('erroreEmail').value != ''){
			$("#email").removeClass("is-valid");
			$("#email").addClass("is-invalid");
			
			$("#controlloEmail").html("Inserire una email valida");
		}	
		if(document.getElementById('errorePsw').value == 'le password non coincidono'){

			$("#psw").removeClass("is-valid");
	  		$("#psw").addClass("is-invalid");
	  		
	  		$("#confPsw").removeClass("is-valid");
	  		$("#confPsw").addClass("is-invalid");
	  	
		 	$("#controlloConfPsw").html("Le password non coincidono");
		}
		if(document.getElementById('errorePsw').value == 'password vuota'){
			$("#psw").removeClass("is-valid");
	  		$("#psw").addClass("is-invalid");
	  		
	  		$("#confPsw").removeClass("is-valid");
	  		$("#confPsw").addClass("is-invalid");
	  	
		 	$("#controlloPsw").html("Inserire una password");
		}
		if(document.getElementById('errorePsw').value == 'vecchia password errata'){
			$("#vecchiaPsw").removeClass("is-valid");
	  		$("#vecchiaPsw").addClass("is-invalid");
	  	
		 	$("#controlloVecchiaPsw").html("Password errata");
		}
		
		if(document.getElementById('scelta').value == "username"){
			$("#nav-user-tab").addClass("active");

			$("#nav-user").addClass("show");
			$("#nav-user").aClass("active");
			
			$("#username").focus();
		}
		if(document.getElementById('scelta').value == "email"){
			$("#nav-user-tab").removeClass("active");
			$("#nav-email-tab").addClass("active");

			$("#nav-user").removeClass("show");
			$("#nav-user").removeClass("active");
			$("#nav-email").addClass("show");
			$("#nav-email").addClass("active");

			$("#email").focus();
		}
		if(document.getElementById('scelta').value == "psw"){
			$("#nav-user-tab").removeClass("active");
			$("#nav-password-tab").addClass("active");

			$("#nav-user").removeClass("show");
			$("#nav-user").removeClass("active");
			$("#nav-password").addClass("show");
			$("#nav-password").addClass("active");
		}
		if(document.getElementById('scelta').value == "foto"){
			$("#nav-user-tab").removeClass("active");
			$("#nav-foto-tab").addClass("active");

			$("#nav-user").removeClass("show");
			$("#nav-user").removeClass("active");
			$("#nav-foto").addClass("show");
			$("#nav-foto").addClass("active");
		}
	});

	function modificaFoto(foto){
		var input = foto;
	    var url = $(foto).val();
	    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
 	    if (input.files && input.files[0]&& (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
 			var reader = new FileReader();

 	        reader.onload = function (e) {
 				$('#fotoGrande').attr('src', e.target.result);
 	        }
 			reader.readAsDataURL(input.files[0]);
 	    	}
 	    	else{ 
 			$('#fotoGrande').attr('src', 'images/placeholder.jpg');
 	    	}
	}
	
	$(function() {
		$(document).on('change', ':file', function() {
		    var input = $(this),
			numFiles = input.get(0).files ? input.get(0).files.length : 1,
			label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
			input.trigger('fileselect', [numFiles, label]);
		});
		$(document).ready( function() {
			$(':file').on('fileselect', function(event, numFiles, label) {
				var input = $(this).parents('.input-group').find(':text'),
				log = numFiles > 1 ? numFiles + ' files selected' : label;
				if( input.length ) {
					input.val(log);
				} 
				else {
					if( log ) alert(log);
				}
			});
		});
	});
	
	function checkUsername(param){
		 $.ajax({  
	         type: "POST",
	         url: "/checkUsername",  
	         data: "username=" + param,
	         success: function(data) {
	        	 	if(data || param==""){
	       	  		$("#username").removeClass("is-valid");
	       	  		$("#username").addClass("is-invalid");
	       	  		
	       	 	 	if(param==""){
	       	 	 		$("#controlloUsername").html("Inserire un nuovo username");
       	 			}
	       	 	 	else{
	           			$("#controlloUsername").html("Lo username inserito è già utilizzato da un altro utente");
	       	 	 	}
	           	} 
	       	  	else{
	       	  		$("#username").removeClass("is-invalid");
	       	  		$("#username").addClass("is-valid");
	       	  		
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
	        	 	if(data || param==""){
	       	  		$("#email").removeClass("is-valid");
	       	  		$("#email").addClass("is-invalid");
	       	  		
	       	 	 	if(param==""){
	       	 	 		$("#controlloEmail").html("Inserire una email");
        	 			}
	       	 	 	else{
	           			$("#controlloEmail").html("L'email inserita è già utilizzata da un altro utente");
	       	 	 	}
	           	} 
	       	  	else{
	       	  		$("#email").removeClass("is-invalid");
	       	  		$("#email").addClass("is-valid");
	       	  		
	       	  		$("#controlloEmail").html("<br>");
	       	  	}
	         },
	         error: function(){
	           alert("Chiamata fallita!!!");
	         } 
		}); 
	}
	
	function checkVecchiaPsw(param){
		 $.ajax({  
	         type: "POST",
	         url: "/checkVecchiaPsw",  
	         data: "vecchiaPsw=" + param,
	         success: function(data) {
	        	 	if(!data || param==""){
	       	  		$("#vecchiaPsw").removeClass("is-valid");
	       	  		$("#vecchiaPsw").addClass("is-invalid");
	       	  		
	       	 	 	if(param==""){
	       	 	 		$("#controlloVecchiaPsw").html("Inserire la tua vecchia password");
        	 			}
	       	 	 	else{
	           			$("#controlloVecchiaPsw").html("La password inserita non è corretta");
	       	 	 	}
	           	} 
	       	  	else{
	       	  		$("#vecchiaPsw").removeClass("is-invalid");
	       	  		$("#vecchiaPsw").addClass("is-valid");
	       	  		
	       	  		$("#controlloVecchiaPsw").html("<br>");
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
	        		if (document.getElementById('psw').value == '' ||
	        			document.getElementById('psw').value != document.getElementById('confPsw').value){
	        			
	        			$("#psw").removeClass("is-valid");
	        	  		$("#psw").addClass("is-invalid");
	        	  		
	        	  		$("#confPsw").removeClass("is-valid");
	        	  		$("#confPsw").addClass("is-invalid");
	        	  		
	    				if(document.getElementById('psw').value == ''){    	  		
		        	  		$("#controlloPsw").html("inserire una password");
		        	  		$("#controlloConfPsw").html("<br>");
	    				}
	    				else{
	        	  			$("#controlloConfPsw").html("le password non coincidono");
	        	  			$("#controlloPsw").html("<br>");
	        	  		}
	        		}
	        		else{
	        			$("#psw").removeClass("is-invalid");
	        	  		$("#psw").addClass("is-valid");
	        	  		
	        	  		$("#confPsw").removeClass("is-invalid");
	        	  		$("#confPsw").addClass("is-valid");
	        	  		
	        	  		$("#controlloConfPsw").html("<br>");
	        	  		$("#controlloPsw").html("<br>");
	        		}
	        }
		});
	}
</script>

<input type="hidden" id="scelta" value="${parametro}" />

<br>
<div class="row">
	<div class="col-md-5 offset-md-1 row">
		<a href="#" data-toggle="modal" data-target="#fotoModal">
			<img src="images/${utente.foto}" width="50" height="50" class="d-inline-block align-top" style="border-radius: 180px;">
		</a>
		<h2 class="ml-2">
			<a href="/profilo" class="font-weight-light text-dark">
				@${utente.username}
			</a>
		</h2>
	</div>
	<button type="button" class="col-md-3 offset-md-2 btn btn-lg btn-outline-viola font-weight-light" data-toggle="modal" data-target="#newCipModal">
		Crea un nuovo cip
	</button>

</div>

<!-- Modal Foto -->
<div class="modal fade bd-example-modal-lg" id="fotoModal" tabindex="-1" role="dialog" aria-labelledby="fotoModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
    		<div class="modal-content">
      		<div class="modal-header">
        			<h5 class="modal-title font-weight-light" id="exampleModalLabel">Immagine del profilo</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
        			</button>
      		</div>
      		<div class="modal-body">
        			<img src='images/${utente.foto}' width="100%" height="100%" class="d-inline-block align-top" alt="">
      		</div>
    		</div>
  	</div>
</div>

<!-- Modal Cip -->
<div class="modal fade" id="newCipModal" tabindex="-1" role="dialog" aria-labelledby="newCipModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
    		<div class="modal-content">
      		<div class="modal-header">
        			<h5 class="modal-title font-weight-light" id="exampleModalLabel">Crea qui il tuo nuovo Cip</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
        			</button>
      		</div>
      		<form action="newCipProfilo" method="post">
      			<div class="modal-body">
					<textarea class="form-control font-weight-light" name="testo" rows="5" maxLength="150" id="comment" placeholder="Fai sapere a tutti quello che stai pensando"></textarea>
      			</div>
      			<div class="modal-footer">
      				<div class="btn-group" role="group" aria-label="Basic example">
        					<button type="button" class="btn btn-outline-secondary font-weight-light" data-dismiss="modal">annulla</button>
        					<button type="submit" class="btn btn-outline-success font-weight-light">Conferma</button>
        				</div>
      			</div>
      		</form>
    		</div>
  	</div>
</div>

<br>

<nav>
	<div class="nav nav-tabs justify-content-center" id="nav-tab" role="tablist">
		<a class="nav-item nav-link font-weight-light text-dark active" id="nav-user-tab"	data-toggle="tab" href="#nav-user"		role="tab" aria-controls="nav-user"    	aria-selected="true">
			<i class="fa fa-user"></i> Mofifica Username
		</a>
		<a class="nav-item nav-link font-weight-light text-dark" id="nav-email-tab"		data-toggle="tab" href="#nav-email"		role="tab" aria-controls="nav-email"    	aria-selected="false">
			<i class="fa fa-envelope-o"></i> Mofifica Email
		</a>
		<a class="nav-item nav-link font-weight-light text-dark" id="nav-password-tab" 	data-toggle="tab" href="#nav-password"	role="tab" aria-controls="nav-password" 	aria-selected="false">
			<i class="fa fa-key"></i> Modifica Password
		</a>
		<a class="nav-item nav-link font-weight-light text-dark" id="nav-foto-tab" 	  	data-toggle="tab" href="#nav-foto" 	 	role="tab" aria-controls="nav-foto" 		aria-selected="false">
			<i class="fa fa-camera"></i> Modifica Foto
		</a>
	</div>
</nav>
<div class="tab-content" id="nav-tabContent">
	<div class="tab-pane fade show active" id="nav-user" role="tabpanel" aria-labelledby="nav-user-tab">
		<br>
		<div style="text-align: center;">
			<h2 class="font-weight-light">Modifica qui il tuo username</h2>
			<br>
			<p class="font-weight-light">Il tuo attuale username: ${utente.username}</p>
			<br>
			
			<form action="/modificaUsername" method="post">
				<input class="col-md-6 offset-md-3 form-control font-weight-light" id="username" onchange="checkUsername(this.value);" type="text" name="username" placeholder="nuovo username" value='${ username }' >
				<div id="controlloUsername" class="col-md-8 offset-md-2 font-weight-light text-danger"><br></div>
							
				<input type="hidden" id="erroreUsername" value="${ erroreUsername }" >
				
				<div class="col-md-6 offset-md-3" style="text-align: center;"> 
					<h3 id="messaggioModificaUsername" class="font-weight-light text-success">${messaggioModificaUsername}</h3>
				</div>
				<br>
							
				<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light col-md-6 offset-md-3">Conferma</button>
			</form>
		</div>
	</div>
	
	<div class="tab-pane fade" id="nav-email" role="tabpanel" aria-labelledby="nav-email-tab">
		<br>
		<div style="text-align: center;">
			<h2 class="font-weight-light">Modifica qui la tua email</h2>
			<br>
			<p class="font-weight-light">La tua attuale email: ${utente.email}</p>
			<br>
			
			<form action="/modificaEmail" method="post">
				<input class="col-md-6 offset-md-3 form-control font-weight-light" id="email" onchange="checkEmail(this.value);" type="text" name="email" placeholder="nuova email" value='${ email }' >
				<div id="controlloEmail" class="col-md-8 offset-md-2 font-weight-light text-danger"><br></div>
							
				<input type="hidden" id="erroreEmail" value="${ erroreEmail }" >
				
				<div class="col-md-6 offset-md-3" style="text-align: center;"> 
					<h3 id="messaggioModificaEmail" class="font-weight-light text-success">${messaggioModificaEmail}</h3>
				</div>
				<br>
							
				<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light col-md-6 offset-md-3">Conferma</button>
			</form>
		</div>
	</div>
	
	<div class="tab-pane fade" id="nav-password" role="tabpanel" aria-labelledby="nav-password-tab">
		<br>
		<div style="text-align: center;">
			<h2 class="font-weight-light">Modifica qui la tua password</h2>
			<br>
			<form action="/modificaPassword" method="post">
				<input class="col-md-6 offset-md-3 form-control font-weight-light" id="vecchiaPsw" onchange="checkVecchiaPsw(this.value);" type="password" name="vecchiaPsw" placeholder="Vecchia password" value='${ vecchiaPsw }' >
				<div id="controlloVecchiaPsw" class="col-md-8 offset-md-2 font-weight-light text-danger"><br></div>
				<br>
			
				<input class="col-md-6 offset-md-3 form-control font-weight-light" id="psw" onchange="checkPsw();" type="password" name="nuovaPsw" placeholder="Nuova password" value='${ nuovaPsw }' >
				<div id="controlloPsw" class="col-md-8 offset-md-2 font-weight-light text-danger"><br></div>
				
				<input class="col-md-6 offset-md-3 form-control font-weight-light" id="confPsw" onchange="checkPsw();" type="password" name="confPsw" placeholder="Conferma nuova password" value='${ confPsw }' >
				<div id="controlloConfPsw" class="col-md-8 offset-md-2 font-weight-light text-danger"><br></div>
							
				<input type="hidden" id="errorePsw" value="${ errorePsw }" >
				
				<div class="col-md-6 offset-md-3" style="text-align: center;"> 
					<h3 id="messaggioModificaPsw" class="font-weight-light text-success">${messaggioModificaPsw}</h3>
				</div>
				<br>
							
				<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light col-md-6 offset-md-3">Conferma</button>
			</form>
		</div>
	</div>
	<div class="tab-pane fade" id="nav-foto" role="tabpanel" aria-labelledby="nav-foto-tab">
		<br>
		<div style="text-align: center;">
			<h2 class="font-weight-light">Modifica qui la tua foto</h2><br>
			
			<img id="fotoGrande" src='images/${utente.foto}' width="150" height="150" class="d-inline-block align-top" alt="" style="border-radius: 180px;"><br>
			<br>
			<div class="col-md-6 offset-md-3">
			<form action="/modificaFoto" method="post" enctype="multipart/form-data">

				<div class="input-group">
                		<input type="text" class="form-control font-weight-light" value="inserisci un'immagine" readonly>
					<label class="input-group-btn">
                    		<span class="btn btn-outline-viola mt-1">
                        		<i class="fa fa-upload"></i>
                        		<input id="inputFoto" type="file" name="pathFoto" accept="image/*" style="display: none;" onchange="modificaFoto(this);">
                    		</span>
                		</label>
            		</div>
            		
				<br>
				<button type="submit" class="btn btn-outline-viola btn-lg btn-block font-weight-light">Conferma</button>
			</form>
			</div>
		</div>
	</div>
</div>
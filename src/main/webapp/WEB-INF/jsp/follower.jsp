<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script>
	function segui(idUtenteAltro){
		$.ajax({  
			type: "POST",
			url: "/seguiUtente",  
			data: "idUtenteAltro=" + idUtenteAltro,
			success: function(data) {
				if(data){
					$("#segui"+idUtenteAltro).removeClass("btn-outline-viola");
	        	  		$("#segui"+idUtenteAltro).addClass("btn-viola");
	        	  		
	        	  		document.getElementById('segui'+idUtenteAltro).innerHTML = "<i class='fa fa-check'></i> Seguito";
	        	  	}
	        	  	else{	        	  		
	        	  		$("#segui"+idUtenteAltro).removeClass("btn-viola");
	        	  		$("#segui"+idUtenteAltro).addClass("btn-outline-viola");
	        	  		
	        	  		document.getElementById('segui'+idUtenteAltro).innerHTML = "Segui";
	        	  	}
			},
			error: function(){
				alert("Chiamata fallita!!!");
			} 
		}); 
	}
	
	function segui2(idUtenteAltro){
		$.ajax({  
	          type: "POST",
	          url: "/seguiUtente",  
	          data: "idUtenteAltro=" + idUtenteAltro,
	          success: function(data) {
	        	  	if(data){
	        	  		$("#segui2"+idUtenteAltro).removeClass("btn-outline-viola");
	        	  		$("#segui2"+idUtenteAltro).addClass("btn-viola");
	        	  		
	        	  		document.getElementById('segui2'+idUtenteAltro).innerHTML = "<i class='fa fa-check'></i> Seguito";
	        	  	}
	        	  	else{	        	  		
	        	  		$("#segui2"+idUtenteAltro).removeClass("btn-viola");
	        	  		$("#segui2"+idUtenteAltro).addClass("btn-outline-viola");
	        	  		
	        	  		document.getElementById('segui2'+idUtenteAltro).innerHTML = "Segui";
	
	        	  	}
	          },
	          error: function(){
	            alert("Chiamata fallita!!!");
	          } 
		}); 
	}
</script>
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
		<a class="nav-item nav-link font-weight-light text-dark active" id="nav-seguo-tab"  data-toggle="tab" href="#nav-seguo" 	 role="tab" aria-controls="nav-seguo"    	aria-selected="true">chi seguo</a>
		<a class="nav-item nav-link font-weight-light text-dark" id="nav-miSegue-tab" 	  data-toggle="tab" href="#nav-miSegue" 	 role="tab" aria-controls="nav-miSegue" 	aria-selected="false">chi mi segue</a>
	</div>
</nav>
<div class="tab-content" id="nav-tabContent">
	<div class="tab-pane fade show active" id="nav-seguo" role="tabpanel" aria-labelledby="nav-seguo-tab">
		<br><br>
		<c:if test="${listaFollower == null}">
			<div id="messaggio" class="alert alert-warning alert-dismissible fade show col-md-8 offset-md-2" style="text-align: center;" role="alert">
  				<strong>Attenzione!</strong> Al momento non stai seguendo alcun utente.
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    					<span aria-hidden="true">&times;</span>
  				</button>
			</div>
		</c:if>
		<div class="col-md-10 offset-md-1">
			<c:forEach items="${listaFollower}" var="item">
				<div class="col-md-8 offset-md-2">
					<div class="card border-secondary" >
						<br>
						<c:url value="/profiloAltri" var="profiloAltri">
	  						<c:param name="idUtenteAltro" value="${item.idUtente}"/>
	  					</c:url>
	  					<div class="col-8 offset-2 row justify-content-around">
		  					<div class="row">
		  						<img src="images/${item.foto}" width="40" height="40" class="d-inline-block align-top" style="border-radius: 180px;">
			  					<h4 class="mt-1 ml-2">
				  					<a href="${profiloAltri}" class="font-weight-light text-dark">
					  					@${item.username}
					  				</a>
					  			</h4>
				  			</div>
				  			<br>
				  			<button id="segui${item.idUtente}" type="button" class="btn btn-viola font-weight-light" onclick="segui(${item.idUtente})">
								<i class="fa fa-check"></i>
								Seguito
							</button>
			  			</div>
						<br>
					</div>
				</div>
				<br>
			</c:forEach>			
		</div>
	</div>
	<div class="tab-pane fade" id="nav-miSegue" role="tabpanel" aria-labelledby="nav-seguo-tab">
		<br><br>
		
		<c:if test="${listaFollowerBy == null}">
			<div id="messaggio" class="alert alert-warning alert-dismissible fade show col-md-8 offset-md-2" style="text-align: center;" role="alert">
  				<strong>Attenzione!</strong> Al momento nessun utente ti sta seguendo.
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    					<span aria-hidden="true">&times;</span>
  				</button>
			</div>
		</c:if>
		
		<div class="col-md-10 offset-md-1">
			<c:forEach items="${listaFollowerBy}" var="item" varStatus="i">
				<div class="col-md-8 offset-md-2">
					<div class="card border-secondary" >
						<br>
						<c:url value="/profiloAltri" var="profiloAltri">
	  						<c:param name="idUtenteAltro" value="${item.idUtente}"/>
	  					</c:url>
	  					<div class="col-8 offset-2 row justify-content-around">
		  					<div class="row">
		  						<img src="images/${item.foto}" width="40" height="40" class="d-inline-block align-top" style="border-radius: 180px;">
			  					<h4 class="mt-1 ml-2">
				  					<a href="${profiloAltri}" class="font-weight-light text-dark">
					  					@${item.username}
					  				</a>
					  			</h4>
				  			</div>
				  			<br>
				  			
				  			<c:if test="${listaBooleanFollower[i.index]}">
								<button id="segui2${item.idUtente}" type="button" class="btn btn-viola font-weight-light" onclick="segui2(${item.idUtente})">
									<i class="fa fa-check"></i>
									Seguito
								</button>
							</c:if>
							<c:if test="${! listaBooleanFollower[i.index]}">
								<button id="segui2${item.idUtente}" type="button" class="btn btn-outline-viola font-weight-light" onclick="segui2(${item.idUtente})">
									Segui
								</button>
							</c:if>
			  			</div>
						<br>
					</div>
				</div>
				<br>
			</c:forEach>			
		</div>
	</div>
</div>
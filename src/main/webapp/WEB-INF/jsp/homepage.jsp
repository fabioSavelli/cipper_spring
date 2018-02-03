<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script>
	function mettiLike(idCip){
		 $.ajax({  
	          type: "POST",
	          url: "/inserisciLike",  
	          data: "idCip=" + idCip,
	          success: function(data) {
	        	  	if(data){
	        	  		$("#like"+idCip).removeClass("fa fa-heart-o");
	        	  		$("#like"+idCip).addClass("fa fa-heart");
	        	  		
	        	  		document.getElementById('textLike'+idCip).textContent = parseInt(document.getElementById('textLike'+idCip).textContent, 10) + 1;
	            	} 
	        	  	else{
	        	  		$("#like"+idCip).removeClass("fa fa-heart");
	        	  		$("#like"+idCip).addClass("fa fa-heart-o");
	        	  		
	        	  		document.getElementById('textLike'+idCip).textContent = parseInt(document.getElementById('textLike'+idCip).textContent, 10) - 1;
	        	  	}
	          },
	          error: function(){
	            alert("Chiamata fallita!!!");
	          } 
		}); 
	}
</script>

<c:if test="${messaggioErrore}">
	<div id="messaggio" class="alert alert-warning alert-dismissible fade show col-md-8 offset-md-2" style="text-align: center;" role="alert">
  		<strong>Attenzione!</strong> L'utente da te cercato non è stato trovato.
  		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    			<span aria-hidden="true">&times;</span>
  		</button>
	</div>
</c:if>
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
      		<form action="newCip" method="post">
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

<br><br>

<c:forEach items="${listaCip}" var="item" varStatus="i">
	<div class="col-md-8 offset-md-2">
		<div class="card border-secondary" >
	  		<div class="card-header" style="background-color: #432B68;">
	  			<h4>
	  				<c:if test="${item.autore.idUtente == utente.idUtente}">
	  					<a href="/profilo" class="font-weight-light text-light">
	  						<img src="images/${item.autore.foto}" width="30" height="30" class="d-inline-block align-top" style="border-radius: 180px;">
		  					@${item.autore.username}
		  				</a>
	  				</c:if>
	  				<c:if test="${item.autore.idUtente != utente.idUtente}">
	  					<c:url value="/profiloAltri" var="profiloAltri">
	  						<c:param name="idUtenteAltro" value="${item.autore.idUtente}"/>
	  					</c:url>
	  					<a href="${profiloAltri}" class="font-weight-light text-light">
	  						<img src="images/${item.autore.foto}" width="30" height="30" class="d-inline-block align-top" style="border-radius: 180px;">
		  					@${item.autore.username}
		  				</a>
	  				</c:if>
		  		</h4>
	  		</div>
	  		<div class="card-body">
    				<c:if test="${item.recip != null}">
    					<h6 class="font-weight-light">
    						Ha effettuato un reCip:<br>
    					</h6>
    					<div class="col-11 offset-1">
	    					<div class="card border-secondary" >
	    						<div class="card-header" style="background-color: #432B68;">
				    				<h4 class="font-weight-light">
				    					<c:if test="${item.recip.autore.idUtente == utente.idUtente}">
				  						<a href="/profilo" class="font-weight-light text-light">
				  							<img src="images/${item.recip.autore.foto}" width="30" height="30" class="d-inline-block align-top" style="border-radius: 180px;">
					  						@${item.recip.autore.username}
					  					</a>
				  					</c:if>
				  					<c:if test="${item.recip.autore.idUtente != utente.idUtente}">
				  						<c:url value="/profiloAltri" var="profiloAltri">
				  							<c:param name="idUtenteAltro" value="${item.recip.autore.idUtente}"/>
				  						</c:url>
				  						<a href="${profiloAltri}" class="font-weight-light text-light">
				  							<img src="images/${item.recip.autore.foto}" width="30" height="30" class="d-inline-block align-top" style="border-radius: 180px;">
					  						@${item.recip.autore.username}
					  					</a>
				  					</c:if>
					  				<br>
				  				</h4>
				  			</div>
			  				
			  				<h6 class="font-weight-light ml-3">
			    					<br> ${item.testo} <br><br>
			    				</h6>
		    				</div>
	    				</div>
    				</c:if>
	    			<c:if test="${item.recip == null}">
		    			<h6 class="font-weight-light">
		    				<br> ${item.testo} <br><br>
		    			</h6>
    				</c:if>
	  		</div>
	  		<div class="card-footer"> 
	  			<div class="row justify-content-between">
		  			<small class="text-secondary mt-1 ml-2">
		  				cip creato il: ${item.dataFormattata}
		  			</small>
		  			
		  			<div class="btn-group" role="group" aria-label="Basic example">
	  					<a onclick="mettiLike(${item.idCip});">
	  						<font size="5" style="color: #432B68;" >
	  							<c:if test="${listaLike[i.index]}">
	  								<i id="like${item.idCip}" class="fa fa-heart"></i>
	  							</c:if>
	  							<c:if test="${! listaLike[i.index]}">
		  							<i id="like${item.idCip}" class="fa fa-heart-o"></i>
		  						</c:if>
	  						</font>
	  					</a>
	  					<font class="ml-2" id="textLike${item.idCip}">${item.likes}</font>
	  					
	  					<a href="#" class="ml-3" data-toggle="modal" data-target="#reCipModal${item.idCip}">
	  						<font size="5" style="color: #432B68;">
		  						<i class="fa fa-share"></i>
	  						</font>
	  					</a>
	  					<font class="ml-2 mr-2" id="textShare${item.idCip}">${item.shares}</font>
					</div>
				</div>
	  		</div>
		</div>
	</div>
	<br><br>
	
	<!-- Modal ReCip -->
    <form action="/reCipHome" method="post">
		<input type="hidden" name="idCip" value="${item.idCip}">
		<div class="modal fade" id="reCipModal${item.idCip}" tabindex="-1" role="dialog" aria-labelledby="reCipModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
	    			<div class="modal-content">
	      			<div class="modal-header">
	        				<h5 class="modal-title font-weight-light" id="exampleModalLabel">Conferma il tuo ReCip</h5>
	        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          				<span aria-hidden="true">&times;</span>
	        				</button>
	      			</div>
	      			<div class="modal-body font-weight-light">
	      				<h4 class="font-weight-light">
	      					<img src="images/${item.autore.foto}" width="40" height="40" class="d-inline-block align-top" style="border-radius: 180px;">
		  					@${item.autore.username}
		  				</h4>
		  				<br>
						${item.testo}
	      			</div>
	      			<div class="modal-footer">
      					<div class="btn-group" role="group" aria-label="Basic example">
							<button type="button" class="btn btn-outline-secondary font-weight-light" data-dismiss="modal">annulla</button>
							<button type="submit" class="btn btn-outline-success font-weight-light">Conferma</button>
						</div>
					</div>
	    			</div>
		  	</div>
		</div>
	</form>
</c:forEach>

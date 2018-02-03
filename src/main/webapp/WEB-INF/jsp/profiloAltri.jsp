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
	
	function segui(idUtenteAltro){
		$.ajax({  
	          type: "POST",
	          url: "/seguiUtente",  
	          data: "idUtenteAltro=" + idUtenteAltro,
	          success: function(data) {
	        	  	if(data){
	        	  		$("#segui").removeClass("btn-outline-viola");
	        	  		$("#segui").addClass("btn-viola");
	        	  		
	        	  		document.getElementById('segui').innerHTML = "<i class='fa fa-check'></i> Seguito";
	        	  	}
	        	  	else{	        	  		
	        	  		$("#segui").removeClass("btn-viola");
	        	  		$("#segui").addClass("btn-outline-viola");
	        	  		
	        	  		document.getElementById('segui').innerHTML = "Segui";

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
			<img src="images/${altro.foto}" width="50" height="50" class="d-inline-block align-top" style="border-radius: 180px;">
		</a>
		<h2 class="ml-2">
			<a href="#" class="font-weight-light text-dark">
				@${altro.username}
			</a>
		</h2>
	</div>
	<c:if test="${segui}">
		<button id="segui" type="button" class="col-md-3 offset-md-2 btn btn-lg btn-viola font-weight-light" onclick="segui(${altro.idUtente})">
			<i class="fa fa-check"></i>
			Seguito
		</button>
	</c:if>
	<c:if test="${! segui}">
		<button id="segui" type="button" class="col-md-3 offset-md-2 btn btn-lg btn-outline-viola font-weight-light" onclick="segui(${altro.idUtente})">
			Segui
		</button>
	</c:if>
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
        			<img src='images/${altro.foto}' width="100%" height="100%" class="d-inline-block align-top" alt="">
      		</div>
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
    <form action="/reCipProfiloAltri" method="post">
		<input type="hidden" name="idCip" value="${item.idCip}">
		<input type="hidden" name="idUtenteAltro" value="${altro.idUtente}">
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

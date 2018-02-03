<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-light fixed-top" style="background-color: #432B68;">
	<div class="container-fluid">
		<a class="navbar-brand text-light font-weight-light" href="/homepage">
			<img src="images/logoBianco.png" width="30" height="30" class="d-inline-block align-top"> 
			 Cipper
		</a>
			
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon text-light"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<div style="margin-bottom: 15px;"></div>
			<div class="col-lg-7 ml-lg-3">
				<form class="form-inline mr-auto ml-lg-5" action="/cerca" method="post">
					<div class="input-group col-12">
						<input type="text" class="autocomplete form-control" id="myInput" name="campoRicerca" placeholder="Cerca" aria-label="Cerca" aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-outline-light" type="submit">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
		    		</form>
	    		</div>
	    		<div class="col-lg-5 row justify-content-lg-end justify-content-center">
	    		<ul class="navbar-nav mr-lg-0">  
	      		<li class="nav-item active">
	        			<a class="nav-link text-light font-weight-light" href="/profilo" style="text-align: center;" >
	        				<img src="images/${utente.foto}" width="30" height="30" class="d-inline-block align-top" style="border-radius: 180px;">
	        				@${ utente.username }
	        			</a>
	      		</li>
	      		<li class="nav-item">
	        			<a class="nav-link text-light font-weight-light" style="text-align: center;" href="/follower">
	        				<i class="fa fa-users"></i>
	        				Follower
	        			</a>
	      		</li>
	      		<li class="nav-item dropdown">
	        			<a class="nav-link text-light font-weight-light" style="text-align: center;" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          			Altro
	          			<i class="fa fa-chevron-down"></i>
	        			</a>
		        		<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
		        			
		        			<c:url value="/modificaAccount" var="modificaUsername"> 	<c:param name="parametro" value="username"/> </c:url>
		        			<c:url value="/modificaAccount" var="modificaEmail">    	<c:param name="parametro" value="email"/> </c:url>
		        			<c:url value="/modificaAccount" var="modificaPsw"> 		<c:param name="parametro" value="psw"/> </c:url>
		        			<c:url value="/modificaAccount" var="modificaFoto"> 		<c:param name="parametro" value="foto"/> </c:url>
		        		
		        			<a class="dropdown-item font-weight-light" href="${ modificaUsername }" 	style="text-align: center;">
		        				<i class="fa fa-user"></i>  Modifica username 
		        			</a>
		          		<a class="dropdown-item font-weight-light" href="${ modificaEmail }"    	style="text-align: center;">
		          			<i class="fa fa-envelope-o"></i>  Modifica email 
		          		</a>
		          		<a class="dropdown-item font-weight-light" href="${ modificaPsw }" 		style="text-align: center;">
		          			<i class="fa fa-lock"></i>  Modifica password 
		          		</a>
		          		<a class="dropdown-item font-weight-light" href="${ modificaFoto }" 		style="text-align: center;">
		          			<i class="fa fa-camera"></i>  Modifica foto 
		          		</a>
		          		<div class="dropdown-divider"></div>
		          		<a class="dropdown-item font-weight-light text-danger" href="#" style="text-align: center;" data-toggle="modal" data-target="#eliminaModal">
		          			<i class="fa fa-times"></i>  Elimina Account 
		          		</a>
		          		<div class="dropdown-divider"></div>
		          		<a class="dropdown-item font-weight-light" href="/logout" style="text-align: center;">
		          			Logout <i class="fa fa-sign-out"></i>
<!-- 		          			<i class="fa fa-power-off"></i> -->
		          		</a>
		        		</div>
	      		</li>
	    		</ul>
	    		</div>
	  	</div>
	</div>
</nav>
<br>
<br>

<!-- Modal -->
<div class="modal fade" id="eliminaModal" tabindex="-1" role="dialog" aria-labelledby="eliminaModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
    		<div class="modal-content">
      		<div class="modal-header">
        			<h5 class="modal-title" id="exampleModalLabel">Elimina il tuo account</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
        			</button>
      		</div>
      		<div class="modal-body">
        			<br>Sei sicuro di voler eliminare il tuo account?<br>
        			Ricordati che tutte le tue informazioni, foto, cip, reCip e like potranno essere recuperate in caso tu decidessi di registrarti nuovamente a Cipper utilizzando la tua vecchia emil.<br><br>
      		</div>
      		<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal">Annulla</button>
        			<a href="/eliminaAccount" class="btn btn-danger">Elimina</a>
      		</div>
    		</div>
  	</div>
</div>

<script>
	var allUser = [];
	var allEmail = [];
	$(document).ready( function(){
		 $.ajax({  
	          type: "POST",
	          url: "/getAllUser",
	          success: function(data){
	        	  	var i;
	        	  	for(i=0; i<data.length; i=i+2){
	        	  		allUser.push(data[i]);
	        	  		allEmail.push(data[i+1]);
	        	  	}
	          },
	          error: function(){
	            alert("Chiamata fallita!!!");
	          } 
		}); 
	});

	function autocomplete(inp, arr, brr) {

		/*the autocomplete function takes two arguments, the text field element and an array of possible autocompleted values:*/
		var currentFocus;

		/*execute a function when someone writes in the text field:*/
		inp.addEventListener(
			"input",
			function(e) {
				var a, b, i, val = this.value;

				/*close any already open lists of autocompleted values*/
				closeAllLists();
				if (!val) {
					return false;
				}
				currentFocus = -1;

				/*create a DIV element that will contain the items (values):*/
				a = document.createElement("DIV");
				a.setAttribute("id", this.id + "autocomplete-list");
				a.setAttribute("class", "autocomplete-items");

				/*append the DIV element as a child of the autocomplete container:*/
				this.parentNode.appendChild(a);

				/*for each item in the array...*/
				for (i = 0; i < arr.length; i++) {

					/*check if the item starts with the same letters as the text field value:*/
					if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {

						/*create a DIV element for each matching element:*/
						b = document.createElement("DIV");

						/*make the matching letters bold:*/
						b.innerHTML = "<h6 class='font-weight-light text-secondary'><strong class='text-dark'>" + arr[i].substr(0, val.length) + "</strong>" + arr[i].substr(val.length) + "</h6>";
						b.innerHTML += "<small class='font-weight-light text-secondary'>"+brr[i]+"</small>";

						/*insert a input field that will hold the current array item's value:*/
						b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";

						/*execute a function when someone clicks on the item value (DIV element):*/
						b.addEventListener(
							"click",
							function(e) {

								/*insert the value for the autocomplete text field:*/
								inp.value = this.getElementsByTagName("input")[0].value;
	
								/*close the list of autocompleted values, (or any other open lists of autocompleted values:*/
								closeAllLists();
							});
						a.appendChild(b);
					}
					
					/*check if the item starts with the same letters as the text field value:*/
					else if (brr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {

						/*create a DIV element for each matching element:*/
						b = document.createElement("DIV");

						/*make the matching letters bold:*/
						b.innerHTML = "<h6 class='font-weight-light text-secondary'><strong class='text-dark'>" + brr[i].substr(0, val.length) + "</strong>" + brr[i].substr(val.length) + "</h6>";
						b.innerHTML += "<small class='font-weight-light text-secondary'>"+arr[i]+"</small>";

						/*insert a input field that will hold the current array item's value:*/
						b.innerHTML += "<input type='hidden' value='" + brr[i] + "'>";

						/*execute a function when someone clicks on the item value (DIV element):*/
						b.addEventListener(
							"click",
							function(e) {

								/*insert the value for the autocomplete text field:*/
								inp.value = this.getElementsByTagName("input")[0].value;
	
								/*close the list of autocompleted values, (or any other open lists of autocompleted values:*/
								closeAllLists();
							});
						a.appendChild(b);
					}
				}
			});

		/*execute a function presses a key on the keyboard:*/
		inp.addEventListener("keydown", function(e) {

			var x = document.getElementById(this.id + "autocomplete-list");
			if (x)
				x = x.getElementsByTagName("div");
			if (e.keyCode == 40) {

				/*If the arrow DOWN key is pressed, increase the currentFocus variable:*/
				currentFocus++;

				/*and and make the current item more visible:*/
				addActive(x);

			} else if (e.keyCode == 38) { //up

				/*If the arrow UP key is pressed, decrease the currentFocus variable:*/
				currentFocus--;

				/*and and make the current item more visible:*/
				addActive(x);
			} else if (e.keyCode == 13) {

				/*If the ENTER key is pressed, prevent the form from being submitted,*/
				e.preventDefault();

				if (currentFocus > -1) {

					/*and simulate a click on the "active" item:*/
					if (x)
						x[currentFocus].click();
				}
			}
		});
		function addActive(x) {

			/*a function to classify an item as "active":*/
			if (!x)
				return false;

			/*start by removing the "active" class on all items:*/
			removeActive(x);

			if (currentFocus >= x.length)
				currentFocus = 0;

			if (currentFocus < 0)
				currentFocus = (x.length - 1);

			/*add class "autocomplete-active":*/
			x[currentFocus].classList.add("autocomplete-active");
		}
		function removeActive(x) {

			/*a function to remove the "active" class from all autocomplete items:*/
			for (var i = 0; i < x.length; i++) {
				x[i].classList.remove("autocomplete-active");
			}
		}
		function closeAllLists(elmnt) {

			/*close all autocomplete lists in the document, except the one passed as an argument:*/
			var x = document.getElementsByClassName("autocomplete-items");
			for (var i = 0; i < x.length; i++) {
				if (elmnt != x[i] && elmnt != inp) {
					x[i].parentNode.removeChild(x[i]);
				}
			}
		}

		/*execute a function when someone clicks in the document:*/
		document.addEventListener("click", function(e) {
			closeAllLists(e.target);
		});
	}

	/*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
	autocomplete(document.getElementById("myInput"), allUser, allEmail);
</script> 
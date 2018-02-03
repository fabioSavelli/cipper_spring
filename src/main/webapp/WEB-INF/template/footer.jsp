<script>	
	window.onscroll = function() {
		scrollFunction()
	};

	function scrollFunction() {
		if (document.body.scrollTop > 20
				|| document.documentElement.scrollTop > 20) {
			document.getElementById("scrollBtn").style.display = "block";
		} else {
			document.getElementById("scrollBtn").style.display = "none";
		}
	}

	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
		document.body.scrollTop = 0; // For Safari
		document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
	}
</script>

<a href="#" onclick="topFunction()" id="scrollBtn" title="Torna in alto" class="ap-scrollup btn btn-secondary">
	<i class="fa fa-caret-up"></i>
</a>


<div class="card-footer text-muted" style="text-align: center;">
	© Cipper - <a class="text-muted" target="_blank" href="https://www.linkedin.com/in/fabio-savelli-1178a6154/">Fabio Savelli <i class="fa fa-linkedin-square"></i></a>
</div>
$(document).ready(function() {
	$(".opm").on('click', function() {
		var idModal = $(this).data('modal');
		console.log(idModal);
		$(idModal).modal("show");
	})
});
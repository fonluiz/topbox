$(document).ready(function() {
	$(".opm").on('click', function() {
		var idModal = $(this).data('modal');
		$(idModal).modal("show");
	})
});

function refresh() {
	location.reload();
}
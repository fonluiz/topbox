$(document).ready(function() {
	$(".opm").on('click', function() {
		var idModal = $(this).data('modal');
		$(idModal).modal("show");
	})
});

function refresh() {
	if(location.search.indexOf('reloaded=yes') < 0){
		var hash = window.location.hash;
		var loc = window.location.href.replace(hash, '');
		loc += (loc.indexOf('?') < 0? '?' : '&') + 'reloaded=yes';
		setTimeout(function(){window.location.href = loc + hash;}, 0);
	}
}
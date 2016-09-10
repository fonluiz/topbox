var idModal;

$(document).ready(function() {
	$(".opm").on('click', function() {
		idModal = $(this).data('modal');
		$(idModal).modal("show");
	})
});

function refresh() {
	if(navigator.userAgent.indexOf("Firefox") != -1 ) 
    {
        if(location.search.indexOf('reloaded=yes') < 0){
			var hash = window.location.hash;
			var loc = window.location.href.replace(hash, '');
			loc += (loc.indexOf('?') < 0? '?' : '&') + 'reloaded=yes';
			setTimeout(function(){window.location.href = loc + hash;}, 0);
		}
    } else {
    	location.reload();
    }
}
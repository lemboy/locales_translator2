function cleanMessage() {
	$( '#flash-message' ).show();
  $( "#flash-message-body" ).html( "" ); 
  $( "#flash-message" ).removeClass();
	$( '#flash-message-button' ).hide();
};

function showPleaseWait( message ) {
	cleanMessage();
  $( "#flash-message" ).addClass( "alert alert-info"  );
  $( "#flash-message-body" ).html( message );
};
function hidePleaseWait() {
	cleanMessage();
};

$( document ).ready( function() {
	$( document ).on( 'click', '.alert .close', function( e ) {
    $( '#flash-message' ).hide();
	});
});
// Show/hide machine-translation buttons
function updateAutoTranslateAbility() {
  var srcLang = $( '#src-lang' ).val().indexOf( "*" );
  var trgtLang = $( '#trgt-lang' ).find( 'option:selected' ).text().indexOf( "*" );
  if ( srcLang < 0 || trgtLang < 0 ) {
    $( "span[class*='auto-transl']" ).attr( "data-disabled", "true" );
  } else {
    $( "span[class*='auto-transl']" ).attr( "data-disabled", "false" );
  }  
  $( '#trgt-file-name' ).attr("placeholder", $( '#trgt-lang' ).find( 'option:selected' ).val() + ".yml" );   
};

function callTranslation( data ) {
  $.ajax({
    type: "POST",
    url: Routes.translations_path(),
    data: data,
    dataType: "script",
    beforeSend: function(){
		showPleaseWait( I18n.t('js.messages.translation_progress') );
    },
    success: function( data ) {
		hidePleaseWait();
    }
  });
};

$( document ).ready( function() {
	// Change upload form, depending on file type (locales or draft) 
  $( document ).on( 'click', '#upload-locale', function( e ){
  	e.preventDefault();
		$( '#is-draft' ).val( false );
		$( '#src-file' ).get( 0 ).setAttribute( 'accept', '.yml' );
    $( "#src-file" ).trigger( 'click' );
  });
  $( document ).on( 'click', '#upload-draft', function( e ){
  	e.preventDefault();
		$( '#is-draft' ).val( true );
		$( '#src-file' ).get( 0 ).setAttribute( 'accept', '.json' );
    $( '#src-file' ).trigger( 'click' );
  });

	// Change save form, depending on file type (locales or draft) 
  $( document ).on( 'click', '#save-locale', function( e ){
  	e.preventDefault();
		$( '#trgt-is-draft' ).val( false);
    $( '#transl-form' ).submit();
  });
  $( document ).on( 'click', '#save-draft', function( e ){
  	e.preventDefault();
		$( '#trgt-is-draft' ).val( true );
    $( '#transl-form' ).submit();
  });

	// Auto submit upload form when file selected
  $( document ).on( 'change', '#src-file',  function() {
  	showPleaseWait( I18n.t('js.messages.uploading_progress') );
    $( this ).closest( 'form' ).submit()
  });

	// Machine-translate one row
  $( document ).on( 'click', '.auto-transl',  function( e ) {
    e.stopPropagation();
		var id = e.target.id.match( /[0-9 -()+]+$/ ).join()
    var trgt_id  = "#trgt-array-" + id;
    var array_key  = "src_plain_array[" + id + "]";
    if ($( trgt_id ).val()) {
    	if ( !confirm( I18n.t('js.messages.field_filled') ) ) { return false; }
    }
    var src_id  = "#src-array-" + id;
    var src_text = $( src_id ).val();
    var src_lang = $( '#src-lang-code' ).val();
    var trgt_lang = $( '#trgt-lang' ).find( 'option:selected' ).val();
    var data = { 'document[src_lang_code]': src_lang, 'document[trgt_lang_code]': trgt_lang }
    data[array_key] = src_text
		callTranslation( data );

  });

	// Machine-translate all rows
  $( document ).on( 'click', '.auto-transl-all',  function( e ) {
    e.stopPropagation();
    var anyFieldIsFilled = $( "textarea[id^='trgt-array']" ).filter( function() {
            return $.trim( this.value ).length !== 0;
        }).length > 0;
    if ( anyFieldIsFilled ) {
      if ( !confirm( I18n.t('js.messages.fields_filled') ) ) { return false; }
    }
		callTranslation( $( "#transl-form" ).serialize() );
  });

	// On file upload  
  $( "#upload-form" ).bind('ajax:success', function() {
	  $( '.select2' ).select2( { width: 'element' } );
    updateAutoTranslateAbility();
    treeView();
  	hidePleaseWait();
  });

	// On select target language
  $( document ).on( 'change', '#trgt-lang',  function() {
    updateAutoTranslateAbility();
  });

})

